# 独角数卡部署指南

欢迎使用独角数卡！本项目基于 Laravel 框架开发，提供了一套高效、稳定、快速的自动发货解决方案。

我们为您准备了两种主要的部署方式：推荐使用 **Docker 容器化部署**，或者使用 **Linux 手动 LNMP 部署**。

## 方式一：Docker 容器化部署（推荐）

这是最简单、最快捷的部署方式，适用于 Linux 和 Windows (WSL2) 环境。

### 前置条件

- 已安装 Docker 和 Docker Compose。

### 步骤

1.  **准备环境配置**
    将 `.env.example` 复制为 `.env`（首次安装其实不需要手动修改太多，安装引导会自动配置，但在 Docker 中我们需要映射文件）。
    _注意：在这个 Docker 配置中，我们直接将 `.env` 文件作为配置源。_

    ```bash
    cp .env.example .env
    ```

2.  **启动服务**
    使用我们准备好的生产环境 Docker Compose 配置文件启动：

    ```bash
    docker-compose -f docker-compose-production.yml up -d
    ```

3.  **访问安装引导**
    打开浏览器访问：`http://你的服务器IP:8898` (如果是本机则访问 `http://localhost:8898`)。
    系统会自动跳转到安装页面。

4.  **填写安装信息**
    在网页安装向导中，填写以下信息：
    - **MySQL数据库地址**：`db` (Docker 内部服务名)
    - **MySQL数据库名**：`dujiaoka`
    - **MySQL用户名**：`dujiaoka`
    - **MySQL密码**：`dujiaoka_pwd` (对应 docker-compose-production.yml 中的 MYSQL_PASSWORD)
    - **Redis连接地址**：`redis` (Docker 内部服务名)
    - **Redis密码**：留空
    - **网站URL**：`http://你的域名` 或 `http://IP:8898`

    点击安装，系统会自动迁移数据库并配置环境。

5.  **安装完成**
    默认管理员账号：`admin`
    默认管理员密码：`admin`
    后台地址：`/admin`

### 后续维护

- **重启服务**：`docker-compose -f docker-compose-production.yml restart`
- **停止服务**：`docker-compose -f docker-compose-production.yml down`
- **查看日志**：`docker-compose -f docker-compose-production.yml logs -f`

---

## 方式二：手动 Linux (LNMP) 部署

如果您熟悉 Linux 运维，或者使用类似宝塔面板的环境，可以手动部署。

详细步骤请参考项目根目录下的文档：
👉 [debian_manual.md](./debian_manual.md)

### 核心步骤概览

1.  **环境准备**：
    - Nginx >= 1.16
    - PHP >= 7.4 (需安装 redis, fileinfo, opcache 等扩展)
    - MySQL >= 5.6
    - Redis
    - Supervisor (用于管理队列进程)

2.  **代码部署**：
    - 克隆代码到网站目录。
    - 设置目录权限 `chmod -R 777 storage bootstrap/cache`。
    - 执行 `composer install` 安装依赖。

3.  **配置**：
    - 复制 `.env.example` 为 `.env`。
    - 配置 Nginx 伪静态（参考 `debian_manual.md` 中的配置）。
    - 配置 Supervisor 运行 `php artisan queue:work`。

4.  **安装**：
    - 访问域名，进入网页安装向导。

---

## 常见问题

- **Q: 安装完后图片无法显示？**
  A: 请检查后台配置中的 `APP_URL` 是否正确，是否开启了 HTTPS 但配置未同步。

- **Q: 邮件发送失败？**
  A: 请检查后台邮件配置，并确保 Supervisor 队列服务正常运行，因为邮件发送通常是异步的。

- **Q: 如何修改数据库密码？**
  A: 修改 `docker-compose-production.yml` 中的环境变量，然后删除 `db_data` 卷（注意数据丢失风险）重新启动，或者手动进入数据库修改。

祝您使用愉快！
