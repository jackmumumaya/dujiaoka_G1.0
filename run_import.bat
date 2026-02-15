@echo off
echo Importing Speed4Card data into database...
type import_speed4card.sql | docker-compose -f docker-compose-production.yml exec -T db mysql -u dujiaoka -pdujiaoka_pwd -D dujiaoka
if %errorlevel% neq 0 (
    echo Error importing data. Please ensure docker-compose is running.
    pause
    exit /b %errorlevel%
)
echo Import successful!
pause
