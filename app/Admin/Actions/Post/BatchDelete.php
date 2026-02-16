<?php
/**
 * 批量删除商品
 */

namespace App\Admin\Actions\Post;

use Dcat\Admin\Grid\BatchAction;
use Illuminate\Http\Request;

class BatchDelete extends BatchAction
{
    protected $title;

    protected $model;

    public function __construct(string $model = null)
    {
        $this->title = '批量删除';
        $this->model = $model;
    }

    public function handle(Request $request)
    {
        $model = $request->get('model');

        $keys = (array) $this->getKey();
        if (empty($keys)) {
            return $this->response()->error('请选择要删除的商品')->refresh();
        }

        $count = 0;
        foreach ($keys as $key) {
            $item = $model::find($key);
            if ($item) {
                $item->delete();
                $count++;
            }
        }

        return $this->response()->success("成功删除 {$count} 个商品")->refresh();
    }

    public function confirm()
    {
        return ['确定要批量删除所选商品吗？', '删除后可在回收站恢复'];
    }

    public function parameters()
    {
        return [
            'model' => $this->model,
        ];
    }
}
