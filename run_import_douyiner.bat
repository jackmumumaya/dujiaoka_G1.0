@echo off
echo ========================================
echo  Douyiner.cn 商品导入工具
echo ========================================
echo.
echo [1/3] 拉取最新代码...
git pull origin main
echo.
echo [2/3] 导入商品数据到数据库...
type import_douyiner.sql | docker-compose -f docker-compose-production.yml exec -T db mysql -u dujiaoka -pdujiaoka_pwd -D dujiaoka
if %errorlevel% neq 0 (
    echo 导入失败！请确保 docker-compose 正在运行。
    pause
    exit /b %errorlevel%
)
echo.
echo [3/3] 清除缓存...
docker-compose -f docker-compose-production.yml exec web php /app/artisan cache:clear
echo.
echo ========================================
echo  导入完成！5个商品已上架。
echo ========================================
pause
