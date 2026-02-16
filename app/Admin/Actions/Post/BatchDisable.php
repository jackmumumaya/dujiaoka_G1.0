<?php
/**
 * 批量下架商品
 */

namespace App\Admin\Actions\Post;

use Dcat\Admin\Grid\BatchAction;
use Illuminate\Http\Request;
use App\Models\Goods;

class BatchDisable extends BatchAction
{
    protected $title = '<i class="feather icon-x-circle"></i> 批量下架';

    public function handle(Request $request)
    {
        $keys = (array) $this->getKey();
        if (empty($keys)) {
            return $this->response()->error('请选择要下架的商品')->refresh();
        }

        $count = Goods::whereIn('id', $keys)->update(['is_open' => 0]);

        return $this->response()->success("成功下架 {$count} 个商品")->refresh();
    }

    public function confirm()
    {
        return ['确定要批量下架所选商品吗？'];
    }
}
