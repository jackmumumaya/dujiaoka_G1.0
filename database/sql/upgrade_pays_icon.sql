ALTER TABLE `pays` ADD COLUMN `icon_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '支付图标' AFTER `pay_handleroute`;
