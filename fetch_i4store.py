import urllib.request
import urllib.error

url = "https://i4store.net/"
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}

def fetch(url):
    print(f"Fetching {url}...")
    try:
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=15) as response:
            return response.read().decode('utf-8')
    except Exception as e:
        print(f"Error fetching {url}: {e}")
        return None

html = fetch(url)
if html:
    with open("i4store_home.html", "w", encoding="utf-8") as f:
        f.write(html)
    print("Saved to i4store_home.html")
