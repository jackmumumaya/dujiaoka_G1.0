"""
Douyiner.cn 商品爬虫
功能：爬取 douyiner.cn 的商品信息、详情、库存、销量，
      下载图片到本地，生成 SQL 导入脚本用于独角数卡。

API 端点：
  - 分类列表: /user/api/index/data
  - 商品列表: /user/api/index/commodity?categoryId={id}
  - 商品详情: /item/{id} (HTML 页面)
"""

import urllib.request
import urllib.error
import json
import re
import os
import time
import html

BASE_URL = "https://douyiner.cn"
SQL_FILE = "import_douyiner.sql"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
    "Accept": "application/json, text/html, */*",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
    "Referer": "https://douyiner.cn/"
}

def fetch_url(url, expect_json=False):
    """获取 URL 内容"""
    print(f"  Fetching: {url}")
    try:
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=15) as response:
            data = response.read().decode('utf-8')
            if expect_json:
                return json.loads(data)
            return data
    except Exception as e:
        print(f"  Error fetching {url}: {e}")
        return None

def download_image(url, save_dir):
    """下载图片到本地，返回相对路径"""
    if not url:
        return ""
    if not url.startswith('http'):
        url = BASE_URL + url

    try:
        # 从 URL 提取文件名
        filename = url.split('/')[-1]
        filename = re.sub(r'[^\w\.\-]', '_', filename)
        if not filename:
            return ""

        filepath = os.path.join(save_dir, filename)

        if os.path.exists(filepath):
            print(f"  Image exists: {filename}")
            return f"images/douyiner/{filename}"

        print(f"  Downloading image: {url}")
        req = urllib.request.Request(url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=10) as response:
            data = response.read()
            with open(filepath, 'wb') as f:
                f.write(data)

        return f"images/douyiner/{filename}"
    except Exception as e:
        print(f"  Failed to download image {url}: {e}")
        return ""

def get_categories():
    """获取所有商品分类"""
    print("\n[1/4] 获取分类列表...")
    result = fetch_url(f"{BASE_URL}/user/api/index/data", expect_json=True)
    if not result or result.get('code') != 200:
        print("  Failed to get categories!")
        return []

    categories = result.get('data', [])
    print(f"  找到 {len(categories)} 个分类:")
    for cat in categories:
        print(f"    - [{cat['id']}] {cat['name']} (商品数: {cat.get('commodity_count', '?')})")
    return categories

def get_commodity_list(category_id):
    """获取某分类下的所有商品"""
    result = fetch_url(f"{BASE_URL}/user/api/index/commodity?categoryId={category_id}", expect_json=True)
    if not result or result.get('code') != 200:
        return []
    return result.get('data', [])

def scrape_product_detail(item_id):
    """爬取商品详情页面，提取 HTML 描述"""
    html_content = fetch_url(f"{BASE_URL}/item/{item_id}")
    if not html_content:
        return ""

    # 提取商品详情区域
    # 目标格式: <div class="product-detail"> ... </div> 或类似结构
    # 从页面提取 "宝贝详情" 后面的内容
    desc = ""

    # 尝试提取 panel-body 中的描述内容
    desc_match = re.search(
        r'宝贝详情.*?</h6>\s*</div>\s*<div class="panel-body">(.*?)</div>\s*</div>',
        html_content, re.DOTALL
    )
    if desc_match:
        desc = desc_match.group(1).strip()
    else:
        # 备用：提取 panel-body 内容
        desc_match = re.search(
            r'<div class="panel-body">\s*(.*?)\s*</div>\s*(?:</div>|<div)',
            html_content, re.DOTALL
        )
        if desc_match:
            desc = desc_match.group(1).strip()

    # 如果还是空，尝试更宽泛的匹配
    if not desc:
        # 找到第二个 panel-body (第一个通常是公告)
        panels = re.findall(r'<div class="panel-body">(.*?)</div>', html_content, re.DOTALL)
        if len(panels) >= 2:
            desc = panels[1].strip()
        elif panels:
            desc = panels[0].strip()

    return desc

def escape_sql(text):
    """SQL 转义"""
    if not text:
        return ""
    return text.replace("\\", "\\\\").replace("'", "\\'")

def generate_sql():
    """主函数：爬取数据并生成 SQL"""
    # 创建图片保存目录
    img_save_dir = os.path.join("storage", "app", "public", "images", "douyiner")
    os.makedirs(img_save_dir, exist_ok=True)

    # Step 1: 获取分类
    categories = get_categories()
    if not categories:
        print("没有找到分类，退出。")
        return

    # Step 2: 获取所有商品
    print("\n[2/4] 获取商品列表...")
    all_products = {}
    for cat in categories:
        items = get_commodity_list(cat['id'])
        all_products[cat['name']] = items
        print(f"  分类 [{cat['name']}]: {len(items)} 个商品")
        for item in items:
            stock_display = item.get('stock', 0)
            print(f"    - {item['name']} | ¥{item['price']} | 库存:{stock_display} | 已售:{item.get('order_sold', 0)}")
        time.sleep(0.5)

    # Step 3: 获取商品详情
    print("\n[3/4] 获取商品详情...")
    product_details = {}
    for cat_name, items in all_products.items():
        for item in items:
            item_id = item['id']
            print(f"  正在获取: {item['name']} (ID: {item_id})")
            desc = scrape_product_detail(item_id)
            product_details[item_id] = desc
            if desc:
                print(f"    详情长度: {len(desc)} 字符")
            else:
                print(f"    未获取到详情")
            time.sleep(1)

    # Step 4: 生成 SQL
    print(f"\n[4/4] 生成 SQL 文件: {SQL_FILE}")

    with open(SQL_FILE, 'w', encoding='utf-8') as f:
        f.write("-- =============================================\n")
        f.write("-- Douyiner.cn 商品导入脚本\n")
        f.write(f"-- 生成时间: {time.strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- 来源: {BASE_URL}\n")
        f.write("-- =============================================\n\n")
        f.write("SET NAMES utf8mb4;\n\n")

        cat_counter = 0
        total_products = 0

        for cat_name, items in all_products.items():
            cat_counter += 1
            f.write(f"\n-- ========== 分类: {cat_name} ({len(items)} 个商品) ==========\n")

            # 插入分类 (使用 INSERT IGNORE 避免重复)
            f.write(f"INSERT INTO goods_group (gp_name, is_open, ord, created_at, updated_at) "
                    f"VALUES ('{escape_sql(cat_name)}', 1, {cat_counter}, NOW(), NOW());\n")
            f.write(f"SET @douyiner_cat_{cat_counter} = LAST_INSERT_ID();\n\n")

            for item in items:
                total_products += 1

                # 处理库存 - 可能是数字也可能是文字("充足","非常多")
                stock = item.get('stock', 0)
                if isinstance(stock, str):
                    # 文字库存转数字
                    stock_map = {'充足': 999, '非常多': 9999, '很多': 999, '有货': 100}
                    stock_num = stock_map.get(stock, 99)
                else:
                    stock_num = int(stock)

                # 下载图片
                cover_url = item.get('cover', '')
                local_img = download_image(cover_url, img_save_dir)

                # 获取详情
                desc = product_details.get(item['id'], '')

                # 价格
                price = float(item.get('price', 0))

                # 销量
                sales = int(item.get('order_sold', 0))

                # 发货方式: delivery_way 0=自动, 其他=人工
                delivery_type = 1 if item.get('delivery_way', 0) == 0 else 2

                # 商品名称
                name = item.get('name', 'Unknown')

                f.write(f"-- 商品: {name}\n")
                f.write(f"INSERT INTO goods ("
                        f"gd_name, gd_description, gd_keywords, description, picture, "
                        f"retail_price, actual_price, in_stock, sales_volume, "
                        f"group_id, type, is_open, ord, created_at, updated_at"
                        f") VALUES ("
                        f"'{escape_sql(name)}', "
                        f"'{escape_sql(name)}', "
                        f"'{escape_sql(name)}', "
                        f"'{escape_sql(desc)}', "
                        f"'{escape_sql(local_img)}', "
                        f"{price}, {price}, {stock_num}, {sales}, "
                        f"@douyiner_cat_{cat_counter}, {delivery_type}, 1, {total_products}, "
                        f"NOW(), NOW()"
                        f");\n\n")

        f.write(f"\n-- =============================================\n")
        f.write(f"-- 导入完成: {cat_counter} 个分类, {total_products} 个商品\n")
        f.write(f"-- =============================================\n")

    print(f"\n{'='*50}")
    print(f"爬取完成!")
    print(f"  分类数: {cat_counter}")
    print(f"  商品数: {total_products}")
    print(f"  SQL 文件: {SQL_FILE}")
    print(f"  图片目录: {img_save_dir}")
    print(f"{'='*50}")

if __name__ == "__main__":
    generate_sql()
