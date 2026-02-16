<?php
/**
 * 批量上架商品
 */

namespace App\Admin\Actions\Post;

use Dcat\Admin\Grid\BatchAction;
use Illuminate\Http\Request;
use App\Models\Goods;

class BatchEnable extends BatchAction
{
    protected $title = '<i class="feather icon-check-circle"></i> 批量上架';

    public function handle(Request $request)
    {
        $keys = (array) $this->getKey();
        if (empty($keys)) {
            return $this->response()->error('请选择要上架的商品')->refresh();
        }

        $count = Goods::whereIn('id', $keys)->update(['is_open' => 1]);

        return $this->response()->success("成功上架 {$count} 个商品")->refresh();
    }

    public function confirm()
    {
        return ['确定要批量上架所选商品吗？'];
    }
}
