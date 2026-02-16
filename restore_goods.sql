-- 恢复所有被软删除的商品
UPDATE goods SET deleted_at = NULL WHERE deleted_at IS NOT NULL;
