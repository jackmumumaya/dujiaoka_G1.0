import urllib.request
import urllib.error
import re
import os
import time
import html

BASE_URL = "https://laotie.nnnbbb.qzz.io"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}
SQL_FILE = "import_laotie.sql"

def fetch_url(url):
    print(f"Fetching {url}...")
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=15) as response:
            return response.read().decode('utf-8')
    except Exception as e:
        print(f"Error fetching {url}: {e}")
        return ""

def download_image(url, save_dir):
    if not url: return ""
    if not url.startswith('http'):
        url = BASE_URL + url if url.startswith('/') else BASE_URL + '/' + url
        
    try:
        filename = url.split('/')[-1]
        filename = re.sub(r'[^\w\.-]', '_', filename)
        if not filename: return ""
        
        filepath = os.path.join(save_dir, filename)
        
        if os.path.exists(filepath):
            return f"images/laotie/{filename}"
            
        print(f"Downloading image: {url}")
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=10) as response:
            data = response.read()
            with open(filepath, 'wb') as f:
                f.write(data)
                
        return f"images/laotie/{filename}"
    except Exception as e:
        print(f"Failed to download image {url}: {e}")
        return ""

def parse_homepage(html_content):
    categories = []
    # Find categories in nav
    # <a href="#group-1" class="home-tab-link" ...><span class="tab-title">谷歌账号</span></a>
    cat_matches = re.findall(r'<a href="#group-(\d+|all)"[^>]*>.*?<span class="tab-title">([^<]+)</span>', html_content, re.DOTALL)
    
    # Map group ID to Name
    # We skip 'all'
    cat_map = {}
    for gid, name in cat_matches:
        if gid == 'all': continue
        cat_map[gid] = name.strip()
        
    print(f"Found categories: {cat_map}")
    
    products_by_cat = {}
    
    # regex for tab pane
    # <div class="tab-pane" id="group-1"> ... </div>
    # This is tricky with regex because nested divs.
    # We can split by id="group-
    
    parts = html_content.split('id="group-')
    for part in parts[1:]:
        # extract group id
        gid_match = re.match(r'(\d+|all)"', part)
        if not gid_match: continue
        gid = gid_match.group(1)
        if gid == 'all': continue # Skip 'all' tab as it duplicates items
        
        # Find products in this part (until next tab-pane or end of div?)
        # A simpler way: Find all product cards in this block.
        # <a href=" (url) " ... class="home-card category">
        
        # Extract the content of the tab pane roughly
        # We assume the tab pane ends before the next <div class="tab-pane" or similar
        # But split already handled that roughly.
        
        item_matches = re.findall(r'<a href="\s*([^"]+)\s*"[^>]*class="home-card category">', part)
        
        # Also need to extract basic info from the card to avoid fetching if possible?
        # User wants "product details", "price", "stock".
        # Homepage has Price and Stock.
        # But Detail page has Description. We need description.
        # So we must fetch detail page.
        
        clean_items = []
        for url in item_matches:
             if not url.startswith('http'):
                 url = BASE_URL + url.strip()
             else:
                 url = url.strip()
             clean_items.append(url)
             
        if gid in cat_map:
            products_by_cat[cat_map[gid]] = list(set(clean_items)) # Dedup
            
    return products_by_cat

def scrape_product_detail(url):
    html = fetch_url(url)
    if not html: return None
    
    # Name
    # <h3>Gemini 3.0pro...</h3>
    # There might be multiple h3, looking for the one in form-group or closest to top
    name_match = re.search(r'<h3>\s*(.*?)\s*</h3>', html)
    # The first H3 in the body in the provided html is likely the name in the form
    # But wait, looking at file: <div class="form-group"><h3>...</h3></div>
    
    name = "Unknown Product"
    if name_match:
        name = name_match.group(1).strip()
    
    # Price
    # <span class="buy-price">￥29.99 </span>
    price = 0.0
    price_match = re.search(r'<span class="buy-price">.*?([\d\.]+).*?</span>', html)
    if price_match:
        try:
            price = float(price_match.group(1))
        except: pass
        
    # Stock
    # <span class="badge badge-outline-primary">库存3</span>
    stock = 0
    stock_match = re.search(r'>\s*库存\s*(\d+)\s*<', html)
    if stock_match:
        stock = int(stock_match.group(1))
        
    # Image
    # Try og:image first
    img_url = ""
    og_img = re.search(r'<meta property="og:image" content="([^"]+)">', html)
    if og_img:
        img_url = og_img.group(1)
        if img_url.startswith('images/'):
            img_url = 'uploads/' + img_url
            
    # If still empty, try finding main image in description or top
    if not img_url:
        # Homepage thumbnail approach?
        pass
    
    # Description
    # <div class="card card-body buy-product"><div class="panel-body">...</div></div>
    desc = ""
    desc_match = re.search(r'<div class="card card-body buy-product">\s*<div class="panel-body">(.*?)</div>\s*<p>&nbsp;</p>\s*</div>', html, re.DOTALL)
    if desc_match:
        desc = desc_match.group(1).strip()
    else:
        # Fallback regex
        desc_match = re.search(r'<div class="panel-body">(.*?)</div>', html, re.DOTALL)
        if desc_match:
            desc = desc_match.group(1).strip()
            
    # Clean description sql
    # desc = re.sub(r'<[^>]+>', '', desc) # Keep HTML? Dujiaoka supports HTML description.
    
    return {
        "name": name,
        "price": price,
        "stock": stock,
        "desc": desc,
        "img": img_url
    }

def escape_sql(text):
    if not text: return ""
    return text.replace("'", "''").replace("\\", "\\\\")

def generate_sql():
    img_save_dir = os.path.join("storage", "app", "public", "images", "laotie")
    os.makedirs(img_save_dir, exist_ok=True)
    
    html = fetch_url(BASE_URL + "/")
    products_map = parse_homepage(html)
    
    with open(SQL_FILE, 'w', encoding='utf-8') as f:
        f.write("-- Laotie Import Script\n")
        f.write("SET NAMES utf8mb4;\n\n")
        
        # Clear existing goods
        f.write("DELETE FROM goods;\n\n")
        
        cat_counter = 0
        
        for cat_name, product_urls in products_map.items():
            cat_counter += 1
            print(f"Processing Category: {cat_name} ({len(product_urls)} items)")
            
            # Insert Group
            f.write(f"\n-- Category: {cat_name}\n")
            f.write(f"INSERT INTO goods_group (gp_name, is_open, ord) VALUES ('{escape_sql(cat_name)}', 1, {cat_counter});\n")
            f.write(f"SET @cat_id_{cat_counter} = LAST_INSERT_ID();\n")
            
            for url in product_urls:
                details = scrape_product_detail(url)
                if not details: continue
                
                # Download Image
                local_img = download_image(details['img'], img_save_dir)
                
                # Insert Good
                # type 1 = Auto, 2 = Manual. Default to 2 (Manual) as we don't have accounts.
                # Usually imported goods are manual unless we import carmis too.
                
                f.write(f"INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, group_id, type, is_open) VALUES "
                        f"('{escape_sql(details['name'])}', '{escape_sql(details['name'])}', '{escape_sql(details['name'])}', '{escape_sql(details['desc'])}', "
                        f"'{escape_sql(local_img)}', {details['price']}, {details['price']}, {details['stock']}, "
                        f"@cat_id_{cat_counter}, 2, 1);\n")
                
                print(f"Scraped: {details['name']}")
                time.sleep(1)

    print(f"Done. SQL saved to {SQL_FILE}")

if __name__ == "__main__":
    generate_sql()
