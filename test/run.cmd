@echo off

where /Q docker
if errorlevel 0 goto PRE_STEP1
echo Docker service and client are required to run this setup.
exit /b 1
:PRE_STEP1

setlocal
set VSRC=%~dp0
set CONTAINER=jekyll
set IMAGE=danmaq/jekyll-git-redcarpet
docker run -d -p 4000:4000 -v %VSRC:~0,-1%:/v/:ro --name %CONTAINER% %IMAGE% sh -c "mkdir /root/.ssh;while true; do sleep 1; done"
echo "Please open via browser: http://localhost:4000"

docker exec -it %CONTAINER% /v/test/incontainer
docker exec -it %CONTAINER% ash
docker rm -f %CONTAINER%
endlocal
exit /b 0
