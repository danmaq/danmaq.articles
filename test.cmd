@echo off

where /Q docker
if errorlevel 0 goto PRE_STEP1
echo Docker is required to run this setup.
exit /b 1
:PRE_STEP1

setlocal
set CONTAINER=jekyll
set IMAGE=danmaq/jekyll-git-redcarpet
docker run -d -p 4000:4000 -v %~dp0:/v:ro --name %CONTAINER% %IMAGE% sh -c "mkdir /root/.ssh;while true; do sleep 1; done"
echo "Please open via browser: http://localhost:4000"

docker exec -it %CONTAINER% /v/test.incontainer
rem docker exec -it %CONTAINER% ash
docker rm -f %CONTAINER%
endlocal
exit /b 0
