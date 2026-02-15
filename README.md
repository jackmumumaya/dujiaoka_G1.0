<p align="center"><img src="https://i.loli.net/2020/04/07/nAzjDJlX7oc5qEw.png" width="400"></p>

<p align="center">
<a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue" alt="license MIT"></a>
<a href="https://github.com/assimon/dujiaoka/releases/tag/2.0.4"><img src="https://img.shields.io/badge/version-2.0.4-red" alt="version 2.0.4"></a>
<a href="https://www.php.net/releases/7_4_0.php"><img src="https://img.shields.io/badge/PHP-7.4-lightgrey" alt="php74"></a>
<a href="https://shang.qq.com/wpa/qunwpa?idkey=37b6b06f7c941dae20dcd5784088905d6461064d7f33478692f0c4215546cee0"><img src="https://img.shields.io/badge/QQ%E7%BE%A4-568679748-green" alt="QQ群：568679748"></a>
</p>

## 独角数卡 (二次开发版)

本版本基于独角数卡 2.0.6 进行增强，主要新增了 **前台会员中心** 及 **Docker 一键部署优化**。

### 📝 二次开发修改明细

本项目在原版 2.0.6 基础上进行了以下核心修改：

#### 1. 前台会员中心 (Frontend User System)

- **核心逻辑**: 新增 `UserController` (`app/Http/Controllers/Home/UserController.php`)，实现了标准的登录、注册、注销及订单查询逻辑。
- **页面模板**: 新增 `resources/views/common/frontend/` 目录，包含 `login`, `register`, `user/index` 等通用页面模板，自动适配现有主题风格。
- **路由配置**: 修改 `routes/common/web.php`，注册了 `login`, `register`, `user` 等命名路由，兼容 unicorn/hyper 等主题导航栏的 `Auth::user()` 判断。
- **订单关联**: 用户中心通过**邮箱**自动关联历史订单，展示订单状态、价格及详情链接。

#### 2. 后台管理增强 (Backend Enhancements)

- **管理控制器**: 新增 `FrontUserController` (`app/Admin/Controllers/FrontUserController.php`)，允许管理员在后台查看和管理前台注册的会员信息。
- **后台路由**: 修改 `app/Admin/routes.php`，增加 `front-users` 资源路由。

#### 3. 部署与数据库优化 (Deployment & DB)

- **Docker重构**: 优化 `docker-compose-production.yml`，修正了 `.env` 文件挂载方式，解决权限报错，默认端口调整为 `8898`。
- **字段修复**: 修复了原版数据库中 `pays` 表缺失 `icon_path` 字段的问题，确保支付图标可正常上传显示。

---

## 🚀 快速部署 (Docker推荐)

这是最简单、最快捷的部署方式，适用于 Linux 和 Windows 环境。

### 前置条件

- 已安装 Docker 和 Docker Compose。

### 步骤

1.  **克隆代码**

    ```bash
    git clone https://github.com/jackmumumaya/dujiaoka_G1.0.git
    cd dujiaoka_G1.0
    ```

2.  **准备环境配置**
    复制配置文件（首次安装无需修改内容）：

    ```bash
    cp .env.example .env
    ```

3.  **启动服务**

    ```bash
    docker-compose -f docker-compose-production.yml up -d
    ```

4.  **初始化权限 (首次必须)**

    ```bash
    # 赋予 storage 目录写入权限
    docker-compose -f docker-compose-production.yml exec web chmod -R 777 /app/storage /app/bootstrap/cache
    # 生成应用密钥
    docker-compose -f docker-compose-production.yml exec web php artisan key:generate
    ```

5.  **访问安装向导**
    打开浏览器访问：`http://你的服务器IP:8898`
    _(如果是本机调试，访问 http://localhost:8898)_

### 🛠️ 安装向导填写指南

请务必按照下表填写数据库配置（Docker 内部网络自动解析）：

| 字段名称             | 填写内容         | 说明                            |
| :------------------- | :--------------- | :------------------------------ |
| **MySQL 数据库地址** | **`db`**         | **注意**：填 `db`，不要填 IP    |
| **MySQL 端口**       | `3306`           | 默认值                          |
| **MySQL 数据库名**   | `dujiaoka`       | 默认值                          |
| **MySQL 用户名**     | `dujiaoka`       | 默认值                          |
| **MySQL 密码**       | `dujiaoka_pwd`   | 对应配置文件的默认密码          |
| **Redis 连接地址**   | **`redis`**      | **注意**：填 `redis`，不要填 IP |
| **Redis 密码**       | (留空)           | 默认无密码                      |
| **Redis 端口**       | `6379`           | 默认值                          |
| **网站 URL**         | `http://IP:8898` | **注意**：必须带上端口号        |

### 🎉 安装完成后的配置

安装成功后，为了启用前台会员功能，**请务必执行以下两步操作**：

1.  **修复支付图标字段** (用于显示支付方式图标)

    ```bash
    docker-compose -f docker-compose-production.yml exec db mysql -u dujiaoka -pdujiaoka_pwd dujiaoka -e "ALTER TABLE pays ADD COLUMN icon_path varchar(255) DEFAULT NULL COMMENT '支付图标' AFTER pay_handleroute;"
    ```

2.  **添加后台菜单** (让管理员能管理前台会员)

    ```bash
    docker-compose -f docker-compose-production.yml exec db mysql -u dujiaoka -pdujiaoka_pwd dujiaoka -e "INSERT INTO admin_menu (parent_id, \`order\`, title, icon, uri, extension, \`show\`, created_at, updated_at) VALUES (0, 99, '前台会员管理', 'feather icon-users', 'front-users', '', 1, NOW(), NOW());"
    ```

3.  **刷新路由缓存**
    ```bash
    docker-compose -f docker-compose-production.yml exec web php /app/artisan route:clear
    ```

现在，您可以访问 `http://IP:8898` 开始使用了！

---

## 界面尝鲜

【官方unicorn模板】
![首页.png](https://i.loli.net/2021/09/14/NZIl6s9RXbHwkmA.png)

## License

独角数卡 DJK Inc [MIT license](https://opensource.org/licenses/MIT).
