<?php

namespace App\Admin\Controllers;

use Dcat\Admin\Layout\Content;
use Dcat\Admin\Admin;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use App\Models\Goods;
use App\Models\GoodsGroup;
use GuzzleHttp\Client;

class ProductScraperController extends Controller
{
    public function index(Content $content)
    {
        return $content
            ->header('Product Scraper')
            ->description('Scrape products from supported sites')
            ->body($this->renderForm());
    }

    protected function renderForm()
    {
        $action = admin_url('product-scraper/preview');
        $token = csrf_token();

        return <<<HTML
<div class="card">
    <div class="card-header">
        <h3 class="card-title">Scraper Settings</h3>
    </div>
    <div class="card-body">
        <form action="$action" method="POST">
            <input type="hidden" name="_token" value="$token">
            <div class="form-group">
                <label>Target URL (Homepage)</label>
                <input type="text" name="url" class="form-control" value="https://laotie.nnnbbb.qzz.io" required>
                <small class="form-text text-muted">Enter the homepage URL of the Dujiaoka/Laotie site.</small>
            </div>
            <div class="form-group">
                <label>Price Markup (%)</label>
                <input type="number" name="markup" class="form-control" value="10">
                <small class="form-text text-muted">Increase scraped prices by this percentage.</small>
            </div>
            <button type="submit" class="btn btn-primary">Start Scraping</button>
        </form>
    </div>
</div>
HTML;
    }

    public function preview(Request $request, Content $content)
    {
        $url = $request->input('url');
        $markup = $request->input('markup', 0);

        try {
            $data = $this->scrapeSite($url);
        } catch (\Exception $e) {
            return $content
                ->header('Scraper Error')
                ->body('<div class="alert alert-danger">Error scraping site: ' . $e->getMessage() . '</div>');
        }

        return $content
            ->header('Scraper Preview')
            ->description('Found ' . count($data['products']) . ' products')
            ->body($this->renderPreviewTable($data, $markup, $url));
    }

    protected function renderPreviewTable($data, $markup, $baseUrl)
    {
        $action = admin_url('product-scraper/import');
        $token = csrf_token();
        $products = $data['products'];

        $html = '<div class="card"><div class="card-body">';
        $html .= '<form action="' . $action . '" method="POST">';
        $html .= '<input type="hidden" name="_token" value="' . $token . '">';
        $html .= '<input type="hidden" name="base_url" value="' . $baseUrl . '">';
        $html .= '<table class="table table-hover table-striped">';
        $html .= '<thead><tr>
                    <th width="40"><input type="checkbox" id="select-all" checked></th>
                    <th>Image</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Original Price</th>
                    <th>New Price (+' . $markup . '%)</th>
                    <th>Stock</th>
                  </tr></thead><tbody>';

        foreach ($products as $index => $product) {
            $newPrice = round($product['price'] * (1 + $markup / 100), 2);
            $imgUrl = $product['img'];
            if (!Str::startsWith($imgUrl, 'http')) {
                $imgUrl = rtrim($baseUrl, '/') . '/' . ltrim($imgUrl, '/');
            }

            $html .= '<tr>';
            $html .= '<td>
                        <input type="checkbox" name="products[' . $index . '][selected]" value="1" checked class="product-select">
                        <input type="hidden" name="products[' . $index . '][name]" value="' . e($product['name']) . '">
                        <input type="hidden" name="products[' . $index . '][desc]" value="' . e($product['desc']) . '">
                        <input type="hidden" name="products[' . $index . '][img]" value="' . e($product['img']) . '">
                        <input type="hidden" name="products[' . $index . '][price]" value="' . $newPrice . '">
                        <input type="hidden" name="products[' . $index . '][stock]" value="' . $product['stock'] . '">
                        <input type="hidden" name="products[' . $index . '][category]" value="' . e($product['category']) . '">
                        <input type="hidden" name="products[' . $index . '][url]" value="' . e($product['url']) . '">
                      </td>';
            $html .= '<td><img src="' . $imgUrl . '" style="max-height:50px; border-radius:4px;"></td>';
            $html .= '<td>' . e($product['name']) . '</td>';
            $html .= '<td>' . e($product['category']) . '</td>';
            $html .= '<td>' . $product['price'] . '</td>';
            $html .= '<td><span class="text-success font-weight-bold">' . $newPrice . '</span></td>';
            $html .= '<td>' . $product['stock'] . '</td>';
            $html .= '</tr>';
        }

        $html .= '</tbody></table>';

        $html .= '<div class="mt-3"><button type="submit" class="btn btn-primary">Import Selected Products</button></div>';
        $html .= '</form></div></div>';

        $html .= '<script>
            $(document).ready(function() {
                $("#select-all").click(function() {
                    $(".product-select").prop("checked", this.checked);
                });
            });
        </script>';

        return $html;
    }

    public function import(Request $request, Content $content)
    {
        $products = $request->input('products', []);
        $baseUrl = $request->input('base_url');

        $importedCount = 0;
        $imgSaveDir = storage_path('app/public/images/scraper');

        if (!file_exists($imgSaveDir)) {
            mkdir($imgSaveDir, 0755, true);
        }

        foreach ($products as $product) {
            if (!isset($product['selected']))
                continue;

            // 1. Create/Find Category
            $categoryName = $product['category'] ?: 'Imported';
            $group = GoodsGroup::firstOrCreate(['gp_name' => $categoryName], ['is_open' => 1, 'ord' => 1]);

            // 2. Download Image
            $imgUrl = $product['img'];
            if (!Str::startsWith($imgUrl, 'http')) {
                $imgUrl = rtrim($baseUrl, '/') . '/' . ltrim($imgUrl, '/');
            }

            $localImgPath = $product['img']; // Default fallback

            try {
                $pathInfo = parse_url($imgUrl, PHP_URL_PATH);
                $filename = basename($pathInfo);
                $filename = preg_replace('/[^\w\.-]/', '_', $filename);
                if (empty($filename))
                    $filename = 'img_' . time() . '_' . rand(100, 999) . '.jpg';

                $localPath = $imgSaveDir . '/' . $filename;

                // Determine if we need to download
                if (!file_exists($localPath)) {
                    // Use Guzzle for downloading
                    $client = new Client(['timeout' => 30, 'verify' => false]);
                    $client->get($imgUrl, ['sink' => $localPath]);
                }
                $localImgPath = 'images/scraper/' . $filename;

            } catch (\Exception $e) {
                // Ignore image error
            }

            // 3. Create Product
            // Check existence?
            // Goods::updateOrCreate(...) ?
            // For now, simple create to avoid complexity
            Goods::create([
                'gd_name' => $product['name'],
                'gd_description' => $product['name'],
                'description' => $product['desc'],
                'gd_keywords' => $product['name'],
                'picture' => $localImgPath,
                'retail_price' => $product['price'],
                'actual_price' => $product['price'],
                'in_stock' => $product['stock'],
                'group_id' => $group->id,
                'type' => 2, // Manual
                'is_open' => 1,
            ]);

            $importedCount++;
        }

        return $content
            ->header('Import Successful')
            ->description("Imported $importedCount products")
            ->body("<div class='alert alert-success'>Successfully imported $importedCount products!</div>")
            ->body('<a href="' . admin_url('goods') . '" class="btn btn-primary">Go to Goods Management</a> ');
    }

    // --- Scraping Logic ---

    protected function scrapeSite($url)
    {
        $client = new Client(['timeout' => 30, 'verify' => false, 'headers' => ['User-Agent' => 'Mozilla/5.0']]);
        try {
            $response = $client->get($url);
            $html = (string) $response->getBody();
        } catch (\Exception $e) {
            throw new \Exception("Failed to fetch $url: " . $e->getMessage());
        }

        $products = [];

        // Strategy 1: i4store Template (Hyper/Grid)
        if (strpos($html, 'category-btn') !== false && strpos($html, 'item-link') !== false) {
            $products = $this->scrapeI4Store($html, $url, $client);
        }

        // Strategy 2: Laotie/Unicorn Template (Tabs with #group-x)
        if (empty($products) && strpos($html, 'tab-title') !== false) {
            $products = $this->scrapeLaotie($html, $url, $client);
        }

        // Strategy 3: Generic Fallback (Try to find common product grids)
        if (empty($products)) {
            // Very basic generic attempt could go here, or we accept failure.
            // For now, let's just return what we have or try a simple regex for finding price/image/link combo
        }

        return ['products' => $products];
    }

    protected function scrapeI4Store($html, $baseUrl, $client)
    {
        $products = [];
        $seenUrls = [];

        // 1. Extract Categories: <a href="#cat16" class="category-btn">TikTok ...</a>
        preg_match_all('/<a[^>]+href="#(cat\d+)"[^>]*class="category-btn[^"]*"[^>]*>(.*?)<\/a>/s', $html, $catMatches, PREG_SET_ORDER);

        $catMap = [];
        foreach ($catMatches as $m) {
            $catMap[$m[1]] = trim(strip_tags($m[2]));
        }
        // Fallback if no specific categories found or 'All'
        if (empty($catMap))
            $catMap['all'] = 'General';

        // 2. Extract Products
        // They are usually in <div id="cat16"> ... </div>
        // Or just scattered if it's "All" view.

        // Let's iterate found categories divs
        foreach ($catMap as $catId => $catName) {
            // Find content block for this category
            // <div ... id="cat16">
            // The HTML structure in i4store is <div ... id="cat16"> <div class="panel-body"> ... products ... </div> </div>

            // Simpler: Just find the div with id and grab everything until next cat or end of div
            // Using explode might be safer than complex regex for nested divs

            $parts = explode('id="' . $catId . '"', $html);
            if (count($parts) < 2)
                continue;

            $contentPart = $parts[1];
            // Cut it before the next category or reasonable end
            // Trying to find the matching closing div is hard with regex. 
            // We can look for "tb-recommend-content-item" inside.

            // let's match all item-links in this chunk

            // We need to limit this contentPart to avoid bleeding into next category
            // Hacky way: split by 'class="panel panel-default' (next category start)
            $subParts = explode('class="panel panel-default', $contentPart);
            $cleanContent = $subParts[0];

            preg_match_all('/<a href="([^"]+)" class="item-link">/i', $cleanContent, $linkMatches);

            foreach ($linkMatches[1] as $href) {
                $fullUrl = $href;
                if (!Str::startsWith($fullUrl, 'http')) {
                    $fullUrl = rtrim($baseUrl, '/') . '/' . ltrim($fullUrl, '/');
                }

                if (in_array($fullUrl, $seenUrls))
                    continue;
                $seenUrls[] = $fullUrl;

                // Fetch Detail
                $details = $this->scrapeI4StoreDetail($client, $fullUrl);
                if ($details) {
                    $details['category'] = $catName;
                    $products[] = $details;
                }
            }
        }

        return $products;
    }

    protected function scrapeI4StoreDetail($client, $url)
    {
        try {
            $response = $client->get($url);
            $html = (string) $response->getBody();

            // Name: <div class="goods-title">...</div> or similar?
            // On i4store detail page:
            // Often just simple title. Let's look for <title> as fallback or specific class.
            // Hyper theme usually has <h3 class="panel-title">Name</h3> or similar

            $name = 'Unknown';
            preg_match('/<div class="goods-title__text"[^>]*>(.*?)<\/div>/s', $html, $nMatch);
            if (isset($nMatch[1]))
                $name = strip_tags($nMatch[1]);
            else {
                preg_match('/<h3[^>]*>(.*?)<\/h3>/s', $html, $h3Match);
                if (isset($h3Match[1]))
                    $name = strip_tags($h3Match[1]);
            }

            // Price
            preg_match('/<span class="price-value">.*?([\d\.]+).*?<\/span>/', $html, $pMatch);
            $price = $pMatch[1] ?? 0;

            // Stock
            // 库存：999
            preg_match('/库存.*?(\d+)/', $html, $sMatch);
            $stock = $sMatch[1] ?? 0;

            // Image
            // .goods-picture img src
            preg_match('/<div class="goods-picture">.*?<img src="([^"]+)"/s', $html, $iMatch);
            $img = $iMatch[1] ?? '';
            // Fallback to OG image
            if (!$img) {
                preg_match('/<meta property="og:image" content="([^"]+)">/', $html, $ogMatch);
                $img = $ogMatch[1] ?? '';
            }
            if ($img && !Str::startsWith($img, 'http')) {
                // handle absolute/relative
                // i4store uses /uploads/...
                // This needs to be handled by the caller if it's a relative path from the base URL
                // For now, assume it's either absolute or relative to site root (e.g., /uploads/...)
            }

            // Description
            // .goods-buy-card .goods-intro ? or .panel-body
            preg_match('/<div class="goods-intro"[^>]*>(.*?)<\/div>/s', $html, $dMatch);
            $desc = $dMatch[1] ?? '';
            if (!$desc) {
                // Try generic description container
                preg_match('/<div class="panel-body">(.*?)<\/div>/s', $html, $pbMatch);
                $desc = $pbMatch[1] ?? '';
            }

            return [
                'name' => trim($name),
                'price' => $price,
                'stock' => $stock,
                'img' => $img,
                'desc' => trim($desc),
                'url' => $url
            ];
        } catch (\Exception $e) {
            return null;
        }
    }

    protected function scrapeLaotie($html, $url, $client)
    {
        // 1. Parse Categories
        preg_match_all('/<a href="#group-(\d+|all)"[^>]*>.*?<span class="tab-title">([^<]+)<\/span>/s', $html, $catMatches, PREG_SET_ORDER);

        $catMap = [];
        foreach ($catMatches as $match) {
            if ($match[1] == 'all')
                continue;
            $catMap[$match[1]] = trim($match[2]);
        }

        // 2. Parse Products
        $parts = explode('id="group-', $html);
        $products = [];
        $seenUrls = [];

        foreach ($parts as $part) {
            if (!preg_match('/^(\d+|all)"/', $part, $gidMatch))
                continue;
            $gid = $gidMatch[1];
            if ($gid == 'all')
                continue;

            preg_match_all('/<a href="\s*([^"]+)\s*"[^>]*class="home-card category">/', $part, $urlMatches);
            $catName = $catMap[$gid] ?? 'Unknown';

            foreach ($urlMatches[1] as $prodUrl) {
                $prodUrl = trim($prodUrl);
                if (!Str::startsWith($prodUrl, 'http')) {
                    $prodUrl = rtrim($url, '/') . '/' . ltrim($prodUrl, '/');
                }

                if (in_array($prodUrl, $seenUrls))
                    continue;
                $seenUrls[] = $prodUrl;

                $details = $this->scrapeDetail($client, $prodUrl);
                if ($details) {
                    $details['category'] = $catName;
                    $products[] = $details;
                }
            }
        }
        return $products;
    }

    // Kept for Laotie details
    protected function scrapeDetail($client, $url)
    {
        try {
            $response = $client->get($url);
            $html = (string) $response->getBody();

            preg_match('/<h3>\s*(.*?)\s*<\/h3>/s', $html, $nameMatch);
            $name = isset($nameMatch[1]) ? strip_tags($nameMatch[1]) : 'Unknown Product';
            $name = trim($name);

            preg_match('/<span class="buy-price">.*?([\d\.]+).*?<\/span>/', $html, $priceMatch);
            $price = $priceMatch[1] ?? 0;

            preg_match('/>\s*库存\s*(\d+)\s*</', $html, $stockMatch);
            $stock = $stockMatch[1] ?? 0;

            preg_match('/<div class="panel-body">(.*?)<\/div>/s', $html, $descMatch);
            $desc = $descMatch[1] ?? '';
            if (empty($desc)) {
                preg_match('/<div class="card card-body buy-product">(.*?)<\/div>/s', $html, $descMatch);
                $desc = $descMatch[1] ?? '';
            }

            preg_match('/<meta property="og:image" content="([^"]+)">/', $html, $imgMatch);
            $img = $imgMatch[1] ?? '';
            // Fix relative image path if it starts with images/
            if ($img && Str::startsWith($img, 'images/')) {
                $img = 'uploads/' . $img;
            }

            return [
                'name' => $name,
                'price' => $price,
                'stock' => $stock,
                'img' => $img,
                'desc' => trim($desc),
                'url' => $url
            ];

        } catch (\Exception $e) {
            return null;
        }
    }
}
