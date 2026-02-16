import urllib.request
import urllib.error

url = "https://www.speed4card.com/resources/product/202207/bad1da31d251d1989e3629d6803a1c72.jpeg"
headers = {
    "User-Agent": "Mozilla/5.0",
    "Referer": "http://example.com"
}

try:
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req) as response:
        print(f"Status Code: {response.getcode()}")
        print("Success: Image is accessible with external Referer.")
except urllib.error.HTTPError as e:
    print(f"HTTP Error: {e.code} {e.reason}")
    if e.code == 403:
        print("Hotlinking is likely blocked.")
except Exception as e:
    print(f"Error: {e}")
