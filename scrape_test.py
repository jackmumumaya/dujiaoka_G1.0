import urllib.request

url = "https://www.speed4card.com/product/10.html"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}

req = urllib.request.Request(url, headers=headers)
try:
    with urllib.request.urlopen(req) as response:
        content = response.read().decode('utf-8')
        with open('product_page.html', 'w', encoding='utf-8') as f:
            f.write(content)
        print("Scraped successfully.")
except Exception as e:
    print(f"Error: {e}")
