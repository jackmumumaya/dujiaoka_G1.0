-- =============================================
-- 删除卡密为0的商品
-- 即 goods 表中没有对应 carmis 记录的商品
-- =============================================

SET NAMES utf8mb4;

-- 删除没有卡密的商品 (软删除，设置 deleted_at)
UPDATE goods 
SET deleted_at = NOW() 
WHERE id NOT IN (
    SELECT DISTINCT goods_id FROM carmis WHERE status = 1
)
AND deleted_at IS NULL;

-- 如果需要彻底硬删除（取消注释下面的语句）：
-- DELETE FROM goods WHERE id NOT IN (SELECT DISTINCT goods_id FROM carmis WHERE status = 1);
