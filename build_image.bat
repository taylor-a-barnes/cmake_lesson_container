set /p IMAGE=<.docker/image_name
docker build -t %IMAGE% .
pause
