-- Laotie Import Script
SET NAMES utf8mb4;

DELETE FROM goods;


-- Category: 谷歌账号
INSERT INTO goods_group (gp_name, is_open, ord) VALUES ('谷歌账号', 1, 1);
SET @cat_id_1 = LAST_INSERT_ID();
INSERT INTO goods (gd_name, gd_description, gd_keywords, description, picture, retail_price, actual_price, in_stock, group_id, type, is_open) VALUES ('Gemini 3.0pro学生优惠1年会员成品号', 'Gemini 3.0pro学生优惠1年会员成品号', 'Gemini 3.0pro学生优惠1年会员成品号', '<h3><img src="https://laotie.nnnbbb.qzz.io/uploads/tinymce/images/b599f126b673a878ac32da4ea2ba291969917a5a88ea1.jpg" alt="" width="509" height="274" /></h3>
<h3>账号格式：</h3>
<h3>邮箱----邮箱密码----辅助邮箱----2fa；</h3>
<h3>长期使用请绑定手机号，改2fa（自行学习使用），和辅助邮箱。禁止立马改密码！！！（过一阵在改），不要频繁登录登出！！</h3>
<h3>登录上立刻改密码导致账户风控的，不提供任何售后!!!!</h3>
<h3>只承诺 gemini.google.com 服务已开通12个月（误差1～7天）</h3>
<h3>不承诺google所有服务可用，特别是antigravity/gcp/gmail相关。</h3>
<h3>不要指望买gemini年卡买一份google全家桶回家！（互相避雷）</h3>
<h3>2fa验证码获取地址：2fa.hk 输入2fa到这个网站可以获取2fa密码</h3>
<h3>售后：包首登&amp;24小时</h3>', 'images/laotie/2bf53c7eb8b0c93456022b55630f43c0.png', 29.99, 29.99, 3, @cat_id_1, 2, 1);
