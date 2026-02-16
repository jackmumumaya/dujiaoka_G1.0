-- =============================================
-- Douyiner.cn 商品导入脚本(含卡密)
-- 生成时间: 2026-02-16
-- 来源: https://douyiner.cn
-- =============================================

SET NAMES utf8mb4;

-- ========== 分类: Gemini (5 个商品) ==========
INSERT INTO goods_group (gp_name, is_open, ord, created_at, updated_at) VALUES ('Gemini', 1, 1, NOW(), NOW());
SET @douyiner_cat_1 = LAST_INSERT_ID();

-- 商品1: Gemini学生优惠1年会员成品号
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, sales_volume, group_id, type, is_open, ord, created_at, updated_at) VALUES ('Gemini学生优惠1年会员成品号', 'Gemini学生优惠1年会员成品号', 'Gemini学生优惠1年会员成品号', '<h3>账号格式：</h3><h3>邮箱----邮箱密码----辅助邮箱----2fa；</h3><h3>长期使用请绑定手机号，改2fa（自行学习使用），和辅助邮箱。禁止立马改密码！！！（过一阵在改），不要频繁登录登出！！</h3><h3>登录上立刻改密码导致账户风控的，不提供任何售后!!!!</h3><h3>只承诺 gemini.google.com 服务已开通12个月（误差1～7天）</h3><h3>不承诺google所有服务可用，特别是antigravity/gcp/gmail相关。</h3><h3>不要指望买gemini年卡买一份google全家桶回家！（互相避雷）</h3><h3>2fa验证码获取地址：2fa.fun  输入2fa到这个网站可以获取2fa密码</h3><h3>售后：包首登&amp;24小时</h3>', 'images/douyiner/202601182205061458053.jpg', 25.0, 25.0, 5, 4654, @douyiner_cat_1, 1, 1, 1, NOW(), NOW());
SET @gd_id = LAST_INSERT_ID();
INSERT INTO carmis (goods_id, status, carmi, created_at, updated_at) VALUES
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW());

-- 商品2: GPT PLUS 年卡[内购】【12个月PLUS】
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, sales_volume, group_id, type, is_open, ord, created_at, updated_at) VALUES ('GPT PLUS 年卡[内购】【12个月PLUS】', 'GPT PLUS 年卡[内购】【12个月PLUS】', 'GPT PLUS 年卡[内购】【12个月PLUS】', '<p>注意：质保7天（7天掉订阅或者封号补新）</p><p>1：充值无需密码，token直冲</p><p>2：充值到自己账户，5分钟完成</p><p>获取token</p><p>1：登录GPT: https://chatgpt.com/</p><p>2：获取Token: https://chatgpt.com/api/auth/session (登录gpt游览器打开这个连接，出现的内容就是token)</p><p>token全部复制。</p>', 'images/douyiner/202602010955339782399.png', 200.0, 200.0, 5, 6, @douyiner_cat_1, 1, 1, 2, NOW(), NOW());
SET @gd_id = LAST_INSERT_ID();
INSERT INTO carmis (goods_id, status, carmi, created_at, updated_at) VALUES
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW());

-- 商品3: 【26年1月开通】GPT Plus一年成品号 【veterans-claim】
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, sales_volume, group_id, type, is_open, ord, created_at, updated_at) VALUES ('【26年1月开通】GPT Plus一年成品号 【veterans-claim】', '【26年1月开通】GPT Plus一年成品号 【veterans-claim】', '【26年1月开通】GPT Plus一年成品号 【veterans-claim】', '<p><b>gpt绝版大兵账户，还有11个月有效期</b></p><p>ChatGPT Plus 会员 1 年</p><p>发货为账号密码，邮箱密码</p><p>不需要二次验证支付卡</p><p>到手启用就是一年后到期</p><p>开通时间误差 3～10 天（不以该理由为退款凭证）</p><p>质保3 天（3 天内封号补号，没号补退款）</p><p>ps:两种不质保的场景</p><p>1：邮件反馈涉嫌协同诈骗不质保</p><p>2：共享账号导致封号不质保</p>', 'images/douyiner/796aeca8f8a1553e9409281c821a0e98.png', 218.0, 218.0, 5, 1, @douyiner_cat_1, 1, 1, 3, NOW(), NOW());
SET @gd_id = LAST_INSERT_ID();
INSERT INTO carmis (goods_id, status, carmi, created_at, updated_at) VALUES
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW());

-- 商品4: GPT自助充值卡密～支持Plus新开续费
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, sales_volume, group_id, type, is_open, ord, created_at, updated_at) VALUES ('GPT自助充值卡密～支持Plus新开续费', 'GPT自助充值卡密～支持Plus新开续费', 'GPT自助充值卡密～支持Plus新开续费', '<p><b>防止恶意扫单，下单请务必使用查询密码。</b></p><p>🔵 谷歌英区免费试用Plus一个月（传说中的0元购）</p><p>🔵CDK使用方法与本店其它商品一样，无需上号，只需token即可充值</p><p>🔵登入本站帐号会自动显示会员价</p><p>🔵建议使用余额购买，方便快捷，可提前充余额</p><p>🔵未使用卡密永久有效，不会过期</p><p>🔵只要有卡密24小时都可自助充值</p><p>🔴由于商品特殊性，零元购无售后，无售后，无售后</p><p>🔴常见封号原因：批量注册的3.5帐号、帐号共享、频繁更换使用ip、问一些敏感问题、翻译敏感话术等，都会造成封号</p><p>🔵如遇充值失败，过一会再提交即可</p><p>🔵遇到问题请勿使用多个卡密码充值同一个帐号，及时联系TG客服</p><p>🔵客服在线时间：9:00~24:00，如未及时回复消息，耐心等待，所有问题我们都会处理</p><p>🔴重要的问题说三遍：</p><p>⭕新号/老号，都可以充，可以提前续费，无需会员到期，会覆盖时间并非累计！</p>', 'images/douyiner/202602010955339782399.png', 16.0, 16.0, 5, 12, @douyiner_cat_1, 1, 1, 4, NOW(), NOW());
SET @gd_id = LAST_INSERT_ID();
INSERT INTO carmis (goods_id, status, carmi, created_at, updated_at) VALUES
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW());

-- 商品5: Google验证美国号（2个月内任意接）
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, sales_volume, group_id, type, is_open, ord, created_at, updated_at) VALUES ('Google验证美国号（2个月内任意接）', 'Google验证美国号（2个月内任意接）', 'Google验证美国号（2个月内任意接）', '<h2>Google老号验证服务</h2><h2>仅支持老号验证，不支持新号注册</h2>', 'images/douyiner/202602081703565251087.png', 3.0, 3.0, 5, 143, @douyiner_cat_1, 1, 1, 5, NOW(), NOW());
SET @gd_id = LAST_INSERT_ID();
INSERT INTO carmis (goods_id, status, carmi, created_at, updated_at) VALUES
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW()),
(@gd_id, 1, '请联系客服获取', NOW(), NOW());

-- =============================================
-- 导入完成: 1 个分类, 5 个商品, 每个商品 5 条卡密
-- 每个商品库存将显示为 5 (未售出卡密数)
-- =============================================
