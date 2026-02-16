import urllib.request
import urllib.error
import re
import time
import os
import sys

# Configuration
BASE_URL = "https://www.speed4card.com"
SQL_FILE = "import_speed4card.sql"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}

def fetch_url(url):
    print(f"Fetching {url}...")
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=10) as response:
            return response.read().decode('utf-8')
    except Exception as e:
        print(f"Failed to fetch {url}: {e}")
        return None

def parse_sidebar(html):
    # Determine categories
    # Structure: <li class="navlist_li" ...> ... <div class="text"><a href="...">Category Name</a></div> ... <ul>...<li><a href="link">SubItem</a></li>...</ul>
    
    categories = {}
    
    # Regex is tricky for nested HTML, but we'll try a pattern that captures the List Item block
    # We'll split by 'navlist_li' to isolate chunks
    chunks = html.split('class="navlist_li"')
    
    for chunk in chunks[1:]: # Skip the first split before the first li
        # Extract Category Name
        cat_match = re.search(r'<div class="text"><a href="[^"]+">([^<]+)</a></div>', chunk)
        if not cat_match:
            continue
        cat_name = cat_match.group(1).strip()
        
        # Extract Sub links
        # Looking for <div class="navlist_content"> ... </div>
        # Links are <li><a href="(url)">(text)</a></li>
        
        # Limit the chunk to the content div to avoid over-matching
        content_match = re.search(r'class="navlist_content"(.*?)<div class="icon">', chunk, re.DOTALL)
        if not content_match:
            continue
            
        content_html = content_match.group(1)
        
        links = re.findall(r'<li><a href="([^"]+)">([^<]+)</a></li>', content_html)
        
        # Filter and clean links
        clean_links = []
        for href, text in links:
            if not href.startswith('http'):
                href = BASE_URL + href
            clean_links.append((text, href))
            
        categories[cat_name] = clean_links
        
    return categories

def scrape_product_page(url):
    html = fetch_url(url)
    if not html:
        return []
    
    products = []
    
    # 1. Title
    title_match = re.search(r'<h1 class="btitle">([^<]+)</h1>', html)
    if not title_match:
        return []
    base_title = title_match.group(1).strip()
    
    # 2. Image
    img_match = re.search(r'<div class="product-img">\s*<img src="([^"]+)"', html)
    img_url = ""
    if img_match:
        img_url = img_match.group(1)
        if not img_url.startswith('http'):
            img_url = BASE_URL + img_url
            
    # 3. Description (Simple cleanup)
    # We just want some text. Maybe the description meta tag is enough or the description div.
    desc = ""
    desc_match = re.search(r'<meta name="description" content="([^"]+)">', html)
    if desc_match:
        desc = desc_match.group(1)
        
    # 4. Options and Prices
    # <a class="prodata product_size ..." data-amount="4.77" ...>5 加元</a>
    # Use distinct regex to locate the option links first, then extract attributes
    option_links = re.findall(r'<a [^>]*class="prodata product_size[^>]*>[^<]+</a>', html)
    
    products = []
    
    if option_links:
        for link in option_links:
            # Extract amount
            amount_match = re.search(r'data-amount="([\d\.]+)"', link)
            label_match = re.search(r'>([^<]+)</a>', link)
            
            if amount_match and label_match:
                price = float(amount_match.group(1))
                label = label_match.group(1).strip()
                
                # Construct name: "Canada iTunes - 5 CAD"
                full_name = f"{base_title} - {label}"
                products.append({
                    "name": full_name,
                    "price": price,
                    "img": img_url,
                    "desc": desc
                })
    
    # If no options found, maybe it's a single price product?
    # Check for <span id="product_price" class="amount" data-amount="4.77">$4.77</span>
    if not products:
        price_match = re.search(r'id="product_price"[^>]*data-amount="([\d\.]+)"', html)
        if price_match:
            price = float(price_match.group(1))
            products.append({
                "name": base_title,
                "price": price,
                "img": img_url,
                "desc": desc
            })

            
    return products


def download_image(url, save_dir):
    if not url: return ""
    try:
        filename = url.split('/')[-1]
        # Sanitize filename just in case
        filename = re.sub(r'[^\w\.-]', '_', filename)
        
        filepath = os.path.join(save_dir, filename)
        
        # Check if file already exists to skip download
        if os.path.exists(filepath):
            return f"images/speed4card/{filename}"
            
        print(f"Downloading image: {url}")
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=10) as response:
            data = response.read()
            with open(filepath, 'wb') as f:
                f.write(data)
                
        return f"images/speed4card/{filename}"
    except Exception as e:
        print(f"Failed to download image {url}: {e}")
        return ""

def generate_sql(categories_data):
    # Ensure directory exists for images
    img_save_dir = os.path.join("storage", "app", "public", "images", "speed4card")
    os.makedirs(img_save_dir, exist_ok=True)
    
    with open(SQL_FILE, 'w', encoding='utf-8') as f:
        f.write("-- Speed4Card Import Script\n")
        f.write("SET NAMES utf8mb4;\n\n")
        
        # Clean up old external link entries to avoid duplicates/broken images
        f.write("-- Remove previous imports that used external hotlinked images\n")
        f.write("DELETE FROM goods WHERE picture LIKE 'https://www.speed4card.com%';\n\n")
        
        cat_counter = 0
        
        for cat_name, items in categories_data.items():
            cat_counter += 1
            print(f"Processing Category: {cat_name} ({len(items)} items)")
            
            # Insert Goods Group
            f.write(f"\n-- Category: {cat_name}\n")
            # We use INSERT IGNORE to avoid duplicate group errors, or just check via simple logic?
            # Actually simplest is just insert. If it fails on duplicate key, we ignore? 
            # Dujiaoka doesn't have unique constraint on group name usually.
            f.write(f"INSERT INTO goods_group (gp_name, is_open, ord) VALUES ('{escape_sql(cat_name)}', 1, 1);\n")
            f.write(f"SET @cat_id_{cat_counter} = LAST_INSERT_ID();\n")
            
            # Process items
            # Constraint: Limiting to first 3 items per category to save time for this demo
            for item_name, item_url in items[:3]: 
                if "/product/" in item_url:
                    goods_list = scrape_product_page(item_url)
                    time.sleep(0.5) # Be nice to the server
                    
                    for good in goods_list:
                        final_price = round(good['price'] * 1.10, 2)
                        
                        # Download Image
                        local_img_path = download_image(good['img'], img_save_dir)
                        if not local_img_path:
                            local_img_path = good['img'] # Fallback to external if download fails
                        
                        # Insert Goods
                        f.write(f"INSERT INTO goods (gd_name, gd_description, gd_keywords, picture, retail_price, actual_price, group_id, type, is_open) VALUES "
                                f"('{escape_sql(good['name'])}', '{escape_sql(good['desc'])}', '{escape_sql(good['name'])}', "
                                f"'{escape_sql(local_img_path)}', {final_price}, {final_price}, @cat_id_{cat_counter}, 2, 1);\n")

def escape_sql(text):
    if not text: return ""
    return text.replace("'", "''").replace("\\", "\\\\")

def main():
    print("Reading sidebar structure...")
    # Read local file first to save a request
    if os.path.exists("product_page.html"):
        with open("product_page.html", "r", encoding="utf-8") as f:
            html = f.read()
    else:
        html = fetch_url(BASE_URL + "/product/10.html")
        
    categories = parse_sidebar(html)
    print(f"Found {len(categories)} categories.")
    
    generate_sql(categories)
    print(f"Done. SQL saved to {SQL_FILE}")

if __name__ == "__main__":
    main()
