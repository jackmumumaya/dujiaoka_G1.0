<?php
/**
 * 批量编辑商品 - 支持批量修改价格、分类、上下架状态
 */

namespace App\Admin\Actions\Post;

use Dcat\Admin\Grid\BatchAction;
use Dcat\Admin\Widgets\Modal;
use Illuminate\Http\Request;
use App\Models\Goods as GoodsModel;
use App\Models\GoodsGroup;

class BatchEditGoods extends BatchAction
{
    protected $title = '批量编辑';

    public function handle(Request $request)
    {
        $keys = (array) $this->getKey();
        if (empty($keys)) {
            return $this->response()->error('请选择要编辑的商品')->refresh();
        }

        $action = $request->get('edit_action');
        $value = $request->get('edit_value');

        $count = count($keys);

        switch ($action) {
            case 'is_open':
                // 批量上架/下架
                GoodsModel::whereIn('id', $keys)->update(['is_open' => (int) $value]);
                $statusText = $value ? '上架' : '下架';
                return $this->response()->success("成功{$statusText} {$count} 个商品")->refresh();

            case 'group_id':
                // 批量修改分类
                GoodsModel::whereIn('id', $keys)->update(['group_id' => (int) $value]);
                $groupName = GoodsGroup::find($value)->gp_name ?? $value;
                return $this->response()->success("成功将 {$count} 个商品移动到分类 [{$groupName}]")->refresh();

            case 'actual_price':
                // 批量修改价格
                if (!is_numeric($value) || $value < 0) {
                    return $this->response()->error('请输入有效的价格');
                }
                GoodsModel::whereIn('id', $keys)->update([
                    'actual_price' => $value,
                    'retail_price' => $value,
                ]);
                return $this->response()->success("成功修改 {$count} 个商品价格为 ¥{$value}")->refresh();

            default:
                return $this->response()->error('未知的编辑操作');
        }
    }

    public function actionScript()
    {
        $warning = '请选择要编辑的商品';

        return <<<JS
function (data, target, action) {
    var key = {$this->getSelectedKeysScript()};
    if (key.length === 0) {
        Dcat.warning('{$warning}');
        return false;
    }

    var options = '<option value="">请选择操作</option>'
        + '<option value="is_open">批量上架/下架</option>'
        + '<option value="group_id">批量修改分类</option>'
        + '<option value="actual_price">批量修改价格</option>';

    var html = '<div style="padding:20px">'
        + '<div class="form-group"><label>操作类型</label>'
        + '<select class="form-control" id="batch-edit-action">' + options + '</select></div>'
        + '<div class="form-group"><label>值</label>'
        + '<input type="text" class="form-control" id="batch-edit-value" placeholder="上架/下架填1或0，分类填分类ID，价格填数字">'
        + '</div></div>';

    layer.open({
        type: 1,
        title: '批量编辑 (' + key.length + ' 个商品)',
        area: ['450px', '300px'],
        content: html,
        btn: ['确认', '取消'],
        yes: function(index) {
            var editAction = $('#batch-edit-action').val();
            var editValue = $('#batch-edit-value').val();

            if (!editAction) {
                Dcat.warning('请选择操作类型');
                return;
            }
            if (editValue === '') {
                Dcat.warning('请填写值');
                return;
            }

            data.edit_action = editAction;
            data.edit_value = editValue;
            action.submit(key, data);
            layer.close(index);
        }
    });

    return false;
}
JS;
    }
}
