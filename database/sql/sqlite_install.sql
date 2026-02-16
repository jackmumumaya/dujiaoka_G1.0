





DROP TABLE IF EXISTS `admin_menu`;
CREATE TABLE `admin_menu` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `parent_id` INTEGER NOT NULL DEFAULT '0',
  `order` INTEGER NOT NULL DEFAULT '0',
  `title` varchar(50)   NOT NULL,
  `icon` varchar(50)   DEFAULT NULL,
  `uri` varchar(50)   DEFAULT NULL,
  `extension` varchar(50)   NOT NULL DEFAULT '',
  `show` tinyint NOT NULL DEFAULT '1',
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `admin_menu` VALUES (1, 0, 1, 'Index', 'feather icon-bar-chart-2', '/', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (2, 0, 2, 'Admin', 'feather icon-settings', '', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (3, 2, 3, 'Users', '', 'auth/users', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (4, 2, 4, 'Roles', '', 'auth/roles', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (5, 2, 5, 'Permission', '', 'auth/permissions', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (6, 2, 6, 'Menu', '', 'auth/menu', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (7, 2, 7, 'Extensions', '', 'auth/extensions', '', 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_menu` VALUES (11, 0, 9, 'Goods_Manage', 'fa-shopping-bag', NULL, '', 1, '2021-05-16 11:39:55', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (12, 11, 11, 'Goods', 'fa-shopping-bag', '/goods', '', 1, '2021-05-16 11:44:35', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (13, 11, 10, 'Goods_Group', 'fa-star-half-o', '/goods-group', '', 1, '2021-05-16 17:08:43', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (14, 0, 12, 'Carmis_Manage', 'fa-credit-card-alt', NULL, '', 1, '2021-05-17 21:29:50', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (15, 14, 13, 'Carmis', 'fa-credit-card', '/carmis', '', 1, '2021-05-17 21:37:59', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (16, 14, 14, 'Import_Carmis', 'fa-plus-circle', '/import-carmis', '', 1, '2021-05-18 14:46:35', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (17, 18, 16, 'Coupon', 'fa-dollar', '/coupon', '', 1, '2021-05-18 17:29:53', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (18, 0, 15, 'Coupon_Manage', 'fa-diamond', NULL, '', 1, '2021-05-18 17:32:03', '2021-05-18 17:32:03');
INSERT INTO `admin_menu` VALUES (19, 0, 17, 'Configuration', 'fa-wrench', NULL, '', 1, '2021-05-20 20:06:47', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (20, 19, 18, 'Email_Template_Configuration', 'fa-envelope', '/emailtpl', '', 1, '2021-05-20 20:17:07', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (21, 19, 19, 'Pay_Configuration', 'fa-cc-visa', '/pay', '', 1, '2021-05-20 20:41:24', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (22, 0, 8, 'Order_Manage', 'fa-table', NULL, '', 1, '2021-05-23 20:43:43', '2021-05-23 20:44:20');
INSERT INTO `admin_menu` VALUES (23, 22, 20, 'Order', 'fa-heart', '/order', '', 1, '2021-05-23 20:46:13', '2021-05-23 20:47:16');
INSERT INTO `admin_menu` VALUES (24, 19, 21, 'System_Setting', 'fa-cogs', '/system-setting', '', 1, '2021-05-26 10:26:34', '2021-05-26 10:26:34');
INSERT INTO `admin_menu` VALUES (25, 19, 22, 'Email_Test', 'fa-envelope', '/email-test', '', 1, '2022-07-26 12:09:34', '2022-07-26 12:17:21');

COMMIT;




DROP TABLE IF EXISTS `admin_permission_menu`;
CREATE TABLE `admin_permission_menu` (
  `permission_id` INTEGER NOT NULL,
  `menu_id` INTEGER NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `admin_permissions`;
CREATE TABLE `admin_permissions` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(50)   NOT NULL,
  `slug` varchar(50)   NOT NULL,
  `http_method` varchar(255)   DEFAULT NULL,
  `http_path` text  ,
  `order` INTEGER NOT NULL DEFAULT '0',
  `parent_id` INTEGER NOT NULL DEFAULT '0',
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `admin_permissions` VALUES (1, 'Auth management', 'auth-management', '', '', 1, 0, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_permissions` VALUES (2, 'Users', 'users', '', '/auth/users*', 2, 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_permissions` VALUES (3, 'Roles', 'roles', '', '/auth/roles*', 3, 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_permissions` VALUES (4, 'Permissions', 'permissions', '', '/auth/permissions*', 4, 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_permissions` VALUES (5, 'Menu', 'menu', '', '/auth/menu*', 5, 1, '2021-05-16 02:06:08', NULL);
INSERT INTO `admin_permissions` VALUES (6, 'Extension', 'extension', '', '/auth/extensions*', 6, 1, '2021-05-16 02:06:08', NULL);
COMMIT;




DROP TABLE IF EXISTS `admin_role_menu`;
CREATE TABLE `admin_role_menu` (
  `role_id` INTEGER NOT NULL,
  `menu_id` INTEGER NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `admin_role_permissions`;
CREATE TABLE `admin_role_permissions` (
  `role_id` INTEGER NOT NULL,
  `permission_id` INTEGER NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `admin_role_users`;
CREATE TABLE `admin_role_users` (
  `role_id` INTEGER NOT NULL,
  `user_id` INTEGER NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `admin_role_users` VALUES (1, 1, '2021-05-16 02:06:08', '2021-05-16 02:06:08');
COMMIT;




DROP TABLE IF EXISTS `admin_roles`;
CREATE TABLE `admin_roles` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(50)   NOT NULL,
  `slug` varchar(50)   NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `admin_roles` VALUES (1, 'Administrator', 'administrator', '2021-05-16 02:06:08', '2021-05-16 02:06:08');
COMMIT;




DROP TABLE IF EXISTS `admin_settings`;
CREATE TABLE `admin_settings` (
  `slug` varchar(100)   NOT NULL,
  `value` longtext   NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `username` varchar(120)   NOT NULL,
  `password` varchar(80)   NOT NULL,
  `name` varchar(255)   NOT NULL,
  `avatar` varchar(255)   DEFAULT NULL,
  `remember_token` varchar(100)   DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `admin_users` VALUES (1, 'admin', '$2y$10$e7z99Mhxm9BOHL55xHZTx.QcNTZJC6ftRXHCR/ZkBja/jBeasVeBy', 'Administrator', NULL, '4UAXF2BEw9EL1Tr2aGmwkv5DKwxqRF6djOMAHSiBMSOrPfPNHYrjCCQMtnTC', '2021-05-16 02:06:08', '2021-05-16 02:06:08');
COMMIT;




DROP TABLE IF EXISTS `carmis`;
CREATE TABLE `carmis` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `goods_id` INTEGER NOT NULL ,
  `status` INTEGER NOT NULL DEFAULT '1' ,
  `is_loop` INTEGER NOT NULL DEFAULT '0' ,
  `carmi` text   NOT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `discount` REAL NOT NULL DEFAULT '0.00' ,
  `is_use` INTEGER NOT NULL DEFAULT '1' ,
  `is_open` INTEGER NOT NULL DEFAULT '1' ,
  `coupon` varchar(150)   NOT NULL ,
  `ret` INTEGER NOT NULL DEFAULT '0' ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `coupons_goods`;
CREATE TABLE `coupons_goods` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `goods_id` INTEGER NOT NULL ,
  `coupons_id` INTEGER NOT NULL 
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `emailtpls`;
CREATE TABLE `emailtpls` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `tpl_name` varchar(150)   NOT NULL ,
  `tpl_content` text   NOT NULL ,
  `tpl_token` varchar(50)   NOT NULL ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `emailtpls` VALUES (2, '【{webname}】感谢您的购买，请查收您的收据', '<!DOCTYPE html>\r\n<html\r\n    style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<head>\r\n    <meta name="viewport" content="width=device-width"/>\r\n    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>\r\n    <title>Billing e.g. invoices and receipts</title>\r\n\r\n    <style type="text/css">\r\n        img {\r\n            max-width: 100%;\r\n        }\r\n\r\n        body {\r\n            -webkit-font-smoothing: antialiased;\r\n            -webkit-text-size-adjust: none;\r\n            width: 100% !important;\r\n            height: 100%;\r\n            line-height: 1.6em;\r\n        }\r\n\r\n        body {\r\n            background-color: #f6f6f6;\r\n        }\r\n\r\n        @media only screen and (max-width: 640px) {\r\n            body {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            h1 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h4 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h1 {\r\n                font-size: 22px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-size: 18px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-size: 16px !important;\r\n            }\r\n\r\n            .container {\r\n                padding: 0 !important;\r\n                width: 100% !important;\r\n            }\r\n\r\n            .content {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            .content-wrap {\r\n                padding: 10px !important;\r\n            }\r\n\r\n            .invoice {\r\n                width: 100% !important;\r\n            }\r\n        }\r\n    </style>\r\n</head>\r\n\r\n<body itemscope itemtype="http://schema.org/EmailMessage"\r\n      style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; width: 100% !important; height: 100%; line-height: 1.6em; background-color: #f6f6f6; margin: 0;"\r\n      bgcolor="#f6f6f6">\r\n\r\n<table class="body-wrap"\r\n       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;"\r\n       bgcolor="#f6f6f6">\r\n    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n        <td class="container" width="600"\r\n            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;"\r\n            valign="top">\r\n            <div class="content"\r\n                 style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;">\r\n                <table class="main" width="100%" cellpadding="0" cellspacing="0"\r\n                       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;"\r\n                       bgcolor="#fff">\r\n                    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <td class="content-wrap aligncenter"\r\n                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 20px;"\r\n                            align="center" valign="top">\r\n                            <table width="100%" cellpadding="0" cellspacing="0"\r\n                                   style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h1 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 32px; color: #000; line-height: 1.2em; font-weight: 500; text-align: center; margin: 40px 0 0;"\r\n                                            align="center"> {ord_title} </h1>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h2 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 24px; color: #000; line-height: 1.2em; font-weight: 400; text-align: center; margin: 40px 0 0;"\r\n                                            align="center">感谢您的购买。</h2>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <table class="invoice"\r\n                                               style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; text-align: left; width: 80%; margin: 40px auto;">\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;" valign="top">\r\n                                                    订单号: {order_id}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    {created_at}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    以下是您的卡密信息：<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    {ord_info}\r\n                                                </td>\r\n                                            </tr>\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;"\r\n                                                    valign="top">\r\n                                                    <table class="invoice-items" cellpadding="0" cellspacing="0"\r\n                                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; margin: 0;">\r\n                                                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                valign="top">{product_name}\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">x {buy_amount}\r\n                                                            </td>\r\n                                                        </tr>\r\n\r\n                                                        <tr class="total"\r\n                                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td class="alignright" width="80%"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">总价\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">{ord_price} ¥\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </table>\r\n                                                </td>\r\n                                            </tr>\r\n                                        </table>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <a href="{weburl}"\r\n                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: #348eda; text-decoration: underline; margin: 0;">{webname}</a>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        {webname} Inc. {created_at}\r\n                                    </td>\r\n                                </tr>\r\n                            </table>\r\n                        </td>\r\n                    </tr>\r\n                </table>\r\n                <div class="footer"\r\n                     style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0; padding: 20px;">\r\n                    <table width="100%"\r\n                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n\r\n                        </tr>\r\n                    </table>\r\n                </div>\r\n            </div>\r\n        </td>\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n    </tr>\r\n</table>\r\n</body>\r\n</html>', 'card_send_user_email', '2020-04-06 13:27:56', '2021-05-20 20:24:42', NULL);
INSERT INTO `emailtpls` VALUES (3, '【{webname}】新订单等待处理！', '<p><span style="">尊敬的管理员：</span></p><p><span style="">客户购买的商品：<span style=""><span style="">【{product_name}】</span></span> 已支付成功，请及时处理。</span></p><p>订单号：{order_id}<br></p><p>数量：{buy_amount}<br></p><p>金额：{ord_price}<br></p><p>时间：<span style="">{created_at}</span><br></p><hr><p>{ord_info}</p><hr><p style="margin-left: 40px;"><b>来自{webname} -{weburl}</b></p>', 'manual_send_manage_mail', '2020-04-06 13:32:03', '2020-04-06 13:32:18', NULL);
INSERT INTO `emailtpls` VALUES (4, '【{webname}】订单处理失败！', '<!DOCTYPE html>\r\n<html\r\n    style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<head>\r\n    <meta name="viewport" content="width=device-width"/>\r\n    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>\r\n    <title>Billing e.g. invoices and receipts</title>\r\n\r\n    <style type="text/css">\r\n        img {\r\n            max-width: 100%;\r\n        }\r\n\r\n        body {\r\n            -webkit-font-smoothing: antialiased;\r\n            -webkit-text-size-adjust: none;\r\n            width: 100% !important;\r\n            height: 100%;\r\n            line-height: 1.6em;\r\n        }\r\n\r\n        body {\r\n            background-color: #f6f6f6;\r\n        }\r\n\r\n        @media only screen and (max-width: 640px) {\r\n            body {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            h1 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h4 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h1 {\r\n                font-size: 22px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-size: 18px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-size: 16px !important;\r\n            }\r\n\r\n            .container {\r\n                padding: 0 !important;\r\n                width: 100% !important;\r\n            }\r\n\r\n            .content {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            .content-wrap {\r\n                padding: 10px !important;\r\n            }\r\n\r\n            .invoice {\r\n                width: 100% !important;\r\n            }\r\n        }\r\n    </style>\r\n</head>\r\n\r\n<body itemscope itemtype="http://schema.org/EmailMessage"\r\n      style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; width: 100% !important; height: 100%; line-height: 1.6em; background-color: #f6f6f6; margin: 0;"\r\n      bgcolor="#f6f6f6">\r\n\r\n<table class="body-wrap"\r\n       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;"\r\n       bgcolor="#f6f6f6">\r\n    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n        <td class="container" width="600"\r\n            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;"\r\n            valign="top">\r\n            <div class="content"\r\n                 style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;">\r\n                <table class="main" width="100%" cellpadding="0" cellspacing="0"\r\n                       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;"\r\n                       bgcolor="#fff">\r\n                    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <td class="content-wrap aligncenter"\r\n                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 20px;"\r\n                            align="center" valign="top">\r\n                            <table width="100%" cellpadding="0" cellspacing="0"\r\n                                   style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h1 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 32px; color: #000; line-height: 1.2em; font-weight: 500; text-align: center; margin: 40px 0 0;"\r\n                                            align="center"> {ord_title} </h1>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h2 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 24px; color: #000; line-height: 1.2em; font-weight: 400; text-align: center; margin: 40px 0 0;"\r\n                                            align="center">非常遗憾，您的订单处理失败(╥﹏╥).</h2>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <table class="invoice"\r\n                                               style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; text-align: left; width: 80%; margin: 40px auto;">\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;" valign="top">\r\n                                                    订单号: {order_id}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    {created_at}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    尊敬的客户，十分抱歉，订单处理失败，请联系网站工作人员核查原因。\r\n                                                </td>\r\n                                            </tr>\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;"\r\n                                                    valign="top">\r\n                                                    <table class="invoice-items" cellpadding="0" cellspacing="0"\r\n                                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; margin: 0;">\r\n                                                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                valign="top">{ord_title}\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">\r\n                                                            </td>\r\n                                                        </tr>\r\n\r\n                                                        <tr class="total"\r\n                                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td class="alignright" width="80%"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">总价\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">{ord_price} ¥\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </table>\r\n                                                </td>\r\n                                            </tr>\r\n                                        </table>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <a href="{weburl}"\r\n                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: #348eda; text-decoration: underline; margin: 0;">{webname}</a>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        {webname} Inc. {created_at}\r\n                                    </td>\r\n                                </tr>\r\n                            </table>\r\n                        </td>\r\n                    </tr>\r\n                </table>\r\n                <div class="footer"\r\n                     style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0; padding: 20px;">\r\n                    <table width="100%"\r\n                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n\r\n                        </tr>\r\n                    </table>\r\n                </div>\r\n            </div>\r\n        </td>\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n    </tr>\r\n</table>\r\n</body>\r\n</html>', 'failed_order', '2020-06-30 09:54:58', '2020-06-30 10:47:21', NULL);
INSERT INTO `emailtpls` VALUES (5, '【{webname}】您的订单已经处理完成！', '<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<table class="body-wrap" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;" bgcolor="#f6f6f6">\r\n<tbody>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;" valign="top">&nbsp;</td>\r\n<td class="container" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;" valign="top" width="600">\r\n<div class="content" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;">\r\n<table class="main" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;" width="100%" cellspacing="0" cellpadding="0" bgcolor="#fff">\r\n<tbody>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-wrap aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 20px;" align="center" valign="top">\r\n<table style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;" width="100%" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-block" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;" valign="top">\r\n<h1 class="aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 32px; color: #000; line-height: 1.2em; font-weight: 500; text-align: center; margin: 40px 0 0;" align="center">{ord_title}</h1>\r\n</td>\r\n</tr>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-block" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;" valign="top">\r\n<h2 class="aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 24px; color: #000; line-height: 1.2em; font-weight: 400; text-align: center; margin: 40px 0 0;" align="center">您的订单已完成。</h2>\r\n</td>\r\n</tr>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-block aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;" align="center" valign="top">\r\n<table class="invoice" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; text-align: left; width: 80%; margin: 40px auto;">\r\n<tbody>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;" valign="top">订单号: {order_id}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;" />{created_at}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;" />尊敬的客户，您的订单已经处理完毕，请及时前往网站核对处理结果，如有疑问请联系网站工作人员！</td>\r\n</tr>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;" valign="top">\r\n<table class="invoice-items" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; margin: 0;" cellspacing="0" cellpadding="0">\r\n<tbody>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;" valign="top"><span style="font-size: 14pt;">{ord_title}</span></td>\r\n<td class="alignright" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;" align="right" valign="top">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; border-top: 1px solid #eeeeee; margin: 0px; padding: 5px 0px;">{ord_info}</td>\r\n<td style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top: 1px solid #eeeeee; margin: 0px; padding: 5px 0px;">&nbsp;</td>\r\n</tr>\r\n<tr class="total" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="alignright" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: bold; margin: 0; padding: 5px 0;" align="right" valign="top" width="80%">总价</td>\r\n<td class="alignright" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: bold; margin: 0; padding: 5px 0;" align="right" valign="top">{ord_price} &yen;</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-block aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;" align="center" valign="top"><a style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: #348eda; text-decoration: underline; margin: 0;" href="{weburl}">{webname}</a></td>\r\n</tr>\r\n<tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<td class="content-block aligncenter" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;" align="center" valign="top">{webname} Inc. {created_at}</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<div class="footer" style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0; padding: 20px;">&nbsp;</div>\r\n</div>\r\n</td>\r\n<td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;" valign="top">&nbsp;</td>\r\n</tr>\r\n</tbody>\r\n</table>', 'completed_order', '2022-05-08 15:41:49', '2022-05-08 15:47:26', NULL);
INSERT INTO `emailtpls` VALUES (6, '【{webname}】已收到您的订单，请等候处理', '<!DOCTYPE html>\r\n<html\r\n    style="font-family: ''Helvetica Neue'', Helvetica, Arial, sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n<head>\r\n    <meta name="viewport" content="width=device-width"/>\r\n    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>\r\n    <title>Billing e.g. invoices and receipts</title>\r\n\r\n    <style type="text/css">\r\n        img {\r\n            max-width: 100%;\r\n        }\r\n\r\n        body {\r\n            -webkit-font-smoothing: antialiased;\r\n            -webkit-text-size-adjust: none;\r\n            width: 100% !important;\r\n            height: 100%;\r\n            line-height: 1.6em;\r\n        }\r\n\r\n        body {\r\n            background-color: #f6f6f6;\r\n        }\r\n\r\n        @media only screen and (max-width: 640px) {\r\n            body {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            h1 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h4 {\r\n                font-weight: 800 !important;\r\n                margin: 20px 0 5px !important;\r\n            }\r\n\r\n            h1 {\r\n                font-size: 22px !important;\r\n            }\r\n\r\n            h2 {\r\n                font-size: 18px !important;\r\n            }\r\n\r\n            h3 {\r\n                font-size: 16px !important;\r\n            }\r\n\r\n            .container {\r\n                padding: 0 !important;\r\n                width: 100% !important;\r\n            }\r\n\r\n            .content {\r\n                padding: 0 !important;\r\n            }\r\n\r\n            .content-wrap {\r\n                padding: 10px !important;\r\n            }\r\n\r\n            .invoice {\r\n                width: 100% !important;\r\n            }\r\n        }\r\n    </style>\r\n</head>\r\n\r\n<body itemscope itemtype="http://schema.org/EmailMessage"\r\n      style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; -webkit-font-smoothing: antialiased; -webkit-text-size-adjust: none; width: 100% !important; height: 100%; line-height: 1.6em; background-color: #f6f6f6; margin: 0;"\r\n      bgcolor="#f6f6f6">\r\n\r\n<table class="body-wrap"\r\n       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; background-color: #f6f6f6; margin: 0;"\r\n       bgcolor="#f6f6f6">\r\n    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n        <td class="container" width="600"\r\n            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; display: block !important; max-width: 600px !important; clear: both !important; margin: 0 auto;"\r\n            valign="top">\r\n            <div class="content"\r\n                 style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; max-width: 600px; display: block; margin: 0 auto; padding: 20px;">\r\n                <table class="main" width="100%" cellpadding="0" cellspacing="0"\r\n                       style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; border-radius: 3px; background-color: #fff; margin: 0; border: 1px solid #e9e9e9;"\r\n                       bgcolor="#fff">\r\n                    <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <td class="content-wrap aligncenter"\r\n                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 20px;"\r\n                            align="center" valign="top">\r\n                            <table width="100%" cellpadding="0" cellspacing="0"\r\n                                   style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h1 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 32px; color: #000; line-height: 1.2em; font-weight: 500; text-align: center; margin: 40px 0 0;"\r\n                                            align="center"> {ord_title} </h1>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 0 0 20px;"\r\n                                        valign="top">\r\n                                        <h2 class="aligncenter"\r\n                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,''Lucida Grande'',sans-serif; box-sizing: border-box; font-size: 24px; color: #000; line-height: 1.2em; font-weight: 400; text-align: center; margin: 40px 0 0;"\r\n                                            align="center">感谢您的惠顾。</h2>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <table class="invoice"\r\n                                               style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; text-align: left; width: 80%; margin: 40px auto;">\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;" valign="top">\r\n                                                    订单号: {order_id}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    {created_at}<br style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;"/>\r\n                                                    系统已向工作人员发送订单通知，代充类商品需要工作人员手动处理，请耐心等待通知！\r\n                                                </td>\r\n                                            </tr>\r\n                                            <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0; padding: 5px 0;"\r\n                                                    valign="top">\r\n                                                    <table class="invoice-items" cellpadding="0" cellspacing="0"\r\n                                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; margin: 0;">\r\n                                                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                valign="top">{ord_title}\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 1px; border-top-color: #eee; border-top-style: solid; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">\r\n                                                            </td>\r\n                                                        </tr>\r\n\r\n                                                        <tr class="total"\r\n                                                            style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                                            <td class="alignright" width="80%"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">总价\r\n                                                            </td>\r\n                                                            <td class="alignright"\r\n                                                                style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: right; border-top-width: 2px; border-top-color: #333; border-top-style: solid; border-bottom-color: #333; border-bottom-width: 2px; border-bottom-style: solid; font-weight: 700; margin: 0; padding: 5px 0;"\r\n                                                                align="right" valign="top">{ord_price} ¥\r\n                                                            </td>\r\n                                                        </tr>\r\n                                                    </table>\r\n                                                </td>\r\n                                            </tr>\r\n                                        </table>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        <a href="{weburl}"\r\n                                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; color: #348eda; text-decoration: underline; margin: 0;">{webname}</a>\r\n                                    </td>\r\n                                </tr>\r\n                                <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                                    <td class="content-block aligncenter"\r\n                                        style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; text-align: center; margin: 0; padding: 0 0 20px;"\r\n                                        align="center" valign="top">\r\n                                        {webname} Inc. {created_at}\r\n                                    </td>\r\n                                </tr>\r\n                            </table>\r\n                        </td>\r\n                    </tr>\r\n                </table>\r\n                <div class="footer"\r\n                     style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; width: 100%; clear: both; color: #999; margin: 0; padding: 20px;">\r\n                    <table width="100%"\r\n                           style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n                        <tr style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; margin: 0;">\r\n\r\n                        </tr>\r\n                    </table>\r\n                </div>\r\n            </div>\r\n        </td>\r\n        <td style="font-family: ''Helvetica Neue'',Helvetica,Arial,sans-serif; box-sizing: border-box; font-size: 14px; vertical-align: top; margin: 0;"\r\n            valign="top"></td>\r\n    </tr>\r\n</table>\r\n</body>\r\n</html>', 'pending_order', '2020-06-30 09:55:55', '2020-06-30 10:45:40', NULL);
COMMIT;




DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `connection` text   NOT NULL,
  `queue` text   NOT NULL,
  `payload` longtext   NOT NULL,
  `exception` longtext   NOT NULL,
  `failed_at` DATETIME NOT NULL DEFAULT CURRENT_DATETIME
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `group_id` INTEGER NOT NULL ,
  `gd_name` varchar(200)   NOT NULL ,
  `gd_description` varchar(200)   NOT NULL ,
  `gd_keywords` varchar(200)   NOT NULL ,
  `picture` text   ,
  `retail_price` REAL DEFAULT '0.00' ,
  `actual_price` REAL NOT NULL DEFAULT '0.00' ,
  `in_stock` INTEGER NOT NULL DEFAULT '0' ,
  `sales_volume` INTEGER DEFAULT '0' ,
  `ord` INTEGER DEFAULT '1' ,
  `buy_limit_num` INTEGER NOT NULL DEFAULT '0' ,
  `buy_prompt` text   ,
  `description` text   ,
  `type` INTEGER NOT NULL DEFAULT '1' ,
  `wholesale_price_cnf` text   ,
  `other_ipu_cnf` text   ,
  `api_hook` text   ,
  `is_open` INTEGER NOT NULL DEFAULT '1' ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `goods_group`;
CREATE TABLE `goods_group` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `gp_name` varchar(200)   NOT NULL ,
  `is_open` INTEGER NOT NULL DEFAULT '1' ,
  `ord` INTEGER NOT NULL DEFAULT '1' ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `migration` varchar(255)   NOT NULL,
  `batch` INTEGER NOT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `order_sn` varchar(150)   NOT NULL ,
  `goods_id` INTEGER NOT NULL ,
  `coupon_id` INTEGER DEFAULT '0' ,
  `title` varchar(200)   NOT NULL ,
  `type` INTEGER NOT NULL DEFAULT '1' ,
  `goods_price` REAL NOT NULL DEFAULT '0.00' ,
  `buy_amount` INTEGER NOT NULL DEFAULT '1' ,
  `coupon_discount_price` REAL NOT NULL DEFAULT '0.00' ,
  `wholesale_discount_price` REAL NOT NULL DEFAULT '0.00' ,
  `total_price` REAL NOT NULL DEFAULT '0.00' ,
  `actual_price` REAL NOT NULL DEFAULT '0.00' ,
  `search_pwd` varchar(200)   DEFAULT '' ,
  `email` varchar(200)   NOT NULL ,
  `info` text   ,
  `pay_id` INTEGER DEFAULT NULL ,
  `buy_ip` varchar(50)   NOT NULL ,
  `trade_no` varchar(200)   DEFAULT '' ,
  `status` INTEGER NOT NULL DEFAULT '1' ,
  `coupon_ret_back` INTEGER NOT NULL DEFAULT '0' ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;




DROP TABLE IF EXISTS `pays`;
CREATE TABLE `pays` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `pay_name` varchar(200)   NOT NULL ,
  `pay_check` varchar(50)   NOT NULL ,
  `pay_method` INTEGER NOT NULL ,
  `pay_client` INTEGER NOT NULL DEFAULT '1' ,
  `merchant_id` varchar(200)   DEFAULT NULL ,
  `merchant_key` text   ,
  `merchant_pem` text   NOT NULL ,
  `pay_handleroute` varchar(200)   NOT NULL ,
  `is_open` INTEGER NOT NULL DEFAULT '1' ,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  `deleted_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
INSERT INTO `pays` VALUES (1, '支付宝当面付', 'zfbf2f', 2, 3, '商户号', '支付宝公钥', '商户私钥', '/pay/alipay', 1, '2019-03-11 05:04:52', '2021-06-08 16:28:06', NULL);
INSERT INTO `pays` VALUES (2, '支付宝 PC', 'aliweb', 1, 1, '商户号', '', '密钥', '/pay/alipay', 1, '2019-07-08 13:25:27', '2019-07-12 09:47:53', NULL);
INSERT INTO `pays` VALUES (3, '码支付 QQ', 'mqq', 1, 1, '商户号', '', '密钥', '/pay/mapay', 1, '2019-07-11 09:05:27', '2019-07-11 12:13:11', NULL);
INSERT INTO `pays` VALUES (4, '码支付支付宝', 'mzfb', 1, 1, '商户号', '', '密钥', '/pay/mapay', 1, '2019-07-11 09:06:02', '2019-07-11 12:12:58', NULL);
INSERT INTO `pays` VALUES (5, '码支付微信', 'mwx', 1, 1, '商户号', '', '密钥', '/pay/mapay', 1, '2019-07-11 09:06:23', '2019-07-11 12:13:05', NULL);
INSERT INTO `pays` VALUES (6, 'Paysapi 支付宝', 'pszfb', 1, 1, '商户号', '', '密钥', '/pay/paysapi', 1, '2019-07-11 09:31:12', '2019-07-11 09:31:12', NULL);
INSERT INTO `pays` VALUES (7, 'Paysapi 微信', 'pswx', 1, 1, '商户号', '', '密钥', '/pay/paysapi', 1, '2019-07-11 09:31:43', '2019-07-11 09:31:43', NULL);
INSERT INTO `pays` VALUES (8, '微信扫码', 'wescan', 2, 1, '商户号', '', '密钥', '/pay/wepay', 1, '2019-07-12 07:50:20', '2019-07-12 08:08:26', NULL);
INSERT INTO `pays` VALUES (11, 'Payjs 微信扫码', 'payjswescan', 1, 1, '商户号', '', '密钥', '/pay/payjs', 1, '2019-07-25 07:28:42', '2019-08-20 12:17:58', NULL);
INSERT INTO `pays` VALUES (14, '易支付-支付宝', 'alipay', 1, 1, '商户号', '', '密钥', '/pay/yipay', 2, '2020-01-10 15:22:56', '2020-01-11 06:33:07', NULL);
INSERT INTO `pays` VALUES (15, '易支付-微信', 'wxpay', 1, 1, '商户号', NULL, '密钥', '/pay/yipay', 1, '2020-07-14 16:27:06', NULL, NULL);
INSERT INTO `pays` VALUES (16, '易支付-QQ 钱包', 'qqpay', 1, 1, '商户号', NULL, '密钥', '/pay/yipay', 1, '2020-07-14 16:27:03', NULL, NULL);
INSERT INTO `pays` VALUES (17, 'PayPal', 'paypal', 1, 1, '商户号', NULL, '密钥', '/pay/paypal', 1, '2020-07-14 16:25:20', NULL, NULL);
INSERT INTO `pays` VALUES (19, 'V 免签支付宝', 'vzfb', 1, 1, 'V 免签通讯密钥', NULL, 'V 免签地址 例如 https://vpay.qq.com/    结尾必须有/', 'pay/vpay', 1, '2020-05-01 13:15:56', '2020-05-01 13:18:29', NULL);
INSERT INTO `pays` VALUES (20, 'V 免签微信', 'vwx', 1, 1, 'V 免签通讯密钥', NULL, 'V 免签地址 例如 https://vpay.qq.com/    结尾必须有/', 'pay/vpay', 1, '2020-05-01 13:17:28', '2020-05-01 13:18:38', NULL);
INSERT INTO `pays` VALUES (21, 'Stripe[微信支付宝]', 'stripe', 1, 1, 'pk开头的可发布密钥', NULL, 'sk开头的密钥', 'pay/stripe', 1, '2020-10-29 13:15:56', '2020-10-29 13:18:29', NULL);
INSERT INTO `pays` VALUES (22, 'Coinbase[加密货币]', 'coinbase', 1, 3, '费率', 'API密钥', '共享密钥', 'pay/coinbase', 0, '2021-08-15 13:15:56', '2021-10-12 13:15:56', NULL);
INSERT INTO `pays` VALUES (23, 'Epusdt[trc20]', 'epusdt', 1, 3, 'API密钥', '不填即可', 'api请求地址', 'pay/epusdt', 0, '2022-03-22 13:15:56', '2022-03-22 13:15:56', NULL);


COMMIT;




DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `name` varchar(255)   NOT NULL,
  `email` varchar(255)   NOT NULL,
  `email_verified_at` DATETIME NULL DEFAULT NULL,
  `password` varchar(255)   NOT NULL,
  `remember_token` varchar(100)   DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL
);




BEGIN;
COMMIT;


