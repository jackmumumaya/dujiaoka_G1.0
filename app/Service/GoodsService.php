<?php
/**
 * The file was created by Assimon.
 *
 * @author    assimon<ashang@utf8.hk>
 * @copyright assimon<ashang@utf8.hk>
 * @link      http://utf8.hk/
 */

namespace App\Service;


use App\Exceptions\RuleValidationException;
use App\Models\Carmis;
use App\Models\Goods;
use App\Models\GoodsGroup;

/**
 * 商品服务层
 *
 * Class GoodsService
 * @package App\Service
 * @author: Assimon
 * @email: Ashang@utf8.hk
 * @blog: https://utf8.hk
 * Date: 2021/5/30
 */
class GoodsService
{

    /**
     * 获取所有分类并加载该分类下的商品
     *
     * @return array|null
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function withGroup($params = []): ?array
    {
        $goods = GoodsGroup::query()
            ->with([
                'goods' => function ($query) use ($params) {
                    $query->withCount([
                        'carmis' => function ($query) {
                            $query->where('status', Carmis::STATUS_UNSOLD);
                        }
                    ])->where('is_open', Goods::STATUS_OPEN);

                    // Filter: In Stock Only
                    if (isset($params['filter']) && $params['filter'] === 'in_stock') {
                        $query->where(function ($q) {
                            // Automatic: Check carmis count
                            $q->where('type', Goods::AUTOMATIC_DELIVERY)->has('carmis', '>', 0, 'and', function ($cq) {
                                $cq->where('status', Carmis::STATUS_UNSOLD);
                            });
                        })->orWhere(function ($q) {
                            // Manual: Check in_stock field
                            $q->where('type', Goods::MANUAL_PROCESSING)->where('in_stock', '>', 0);
                        });
                    }

                    // Sorting
                    if (isset($params['sort'])) {
                        switch ($params['sort']) {
                            case 'sales_volume':
                                $query->orderBy('sales_volume', 'DESC');
                                break;
                            case 'price_asc':
                                $query->orderBy('actual_price', 'ASC');
                                break;
                            case 'price_desc':
                                $query->orderBy('actual_price', 'DESC');
                                break;
                            default:
                                $query->orderBy('ord', 'DESC')->orderBy('id', 'DESC');
                        }
                    } else {
                        $query->orderBy('ord', 'DESC')->orderBy('id', 'DESC');
                    }
                }
            ])
            ->where('is_open', GoodsGroup::STATUS_OPEN)
            ->orderBy('ord', 'DESC')
            ->get();
        // 将自动
        return $goods ? $goods->toArray() : null;
    }

    /**
     * 商品详情
     *
     * @param int $id 商品id
     * @return \Illuminate\Database\Eloquent\Builder|\Illuminate\Database\Eloquent\Model|object|null
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function detail(int $id)
    {
        $goods = Goods::query()
            ->with(['coupon'])
            ->withCount([
                'carmis' => function ($query) {
                    $query->where('status', Carmis::STATUS_UNSOLD);
                }
            ])->where('id', $id)->first();
        return $goods;
    }

    /**
     * 格式化商品信息
     *
     * @param Goods $goods 商品模型
     * @return Goods
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function format(Goods $goods)
    {
        // 格式化批发配置以及输入框配置
        $goods->wholesale_price_cnf = $goods->wholesale_price_cnf ?
            format_wholesale_price($goods->wholesale_price_cnf) :
            null;
        // 如果存在其他配置输入框且为代充
        $goods->other_ipu = $goods->other_ipu_cnf ?
            format_charge_input($goods->other_ipu_cnf) :
            null;
        return $goods;
    }

    /**
     * 验证商品状态
     *
     * @param Goods $goods
     * @return Goods
     * @throws RuleValidationException
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function validatorGoodsStatus(Goods $goods): Goods
    {
        if (empty($goods)) {
            throw new RuleValidationException(__('dujiaoka.prompt.goods_does_not_exist'));
        }
        // 上架判断.
        if ($goods->is_open != Goods::STATUS_OPEN) {
            throw new RuleValidationException(__('dujiaoka.prompt.the_goods_is_not_on_the_shelves'));
        }
        return $goods;
    }

    /**
     * 库存减去
     *
     * @param int $id 商品id
     * @param int $number 出库数量
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function inStockDecr(int $id, int $number = 1): bool
    {
        return Goods::query()->where('id', $id)->decrement('in_stock', $number);
    }

    /**
     * 商品销量加
     *
     * @param int $id 商品id
     * @param int $number 数量
     * @return bool
     *
     * @author    assimon<ashang@utf8.hk>
     * @copyright assimon<ashang@utf8.hk>
     * @link      http://utf8.hk/
     */
    public function salesVolumeIncr(int $id, int $number = 1): bool
    {
        return Goods::query()->where('id', $id)->increment('sales_volume', $number);
    }

}
