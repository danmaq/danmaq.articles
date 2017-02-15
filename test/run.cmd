@echo off

where /Q docker
if errorlevel 0 goto PRE_STEP1
echo Docker service and client are required to run this setup.
exit /b 1
:PRE_STEP1

if not exist "_site\" md _site

setlocal
set VSRC=%~dp0
set CONTAINER=jekyll
set IMAGE=danmaq/jekyll-git-redcarpet:github-pages
set VOL1=%VSRC:~0,-6%:/v/:ro
set VOL2=%VSRC:~0,-5%_site:/srv/jekyll/_site
set LOOP="mkdir /root/.ssh; while true; do sleep 1; done"
docker run -d -p 4000:4000 -v %VOL1% -v %VOL2% --name %CONTAINER% %IMAGE% sh -c %LOOP%
echo "Please open via browser: http://localhost:4000"
docker exec -it %CONTAINER% /v/test/incontainer
rem docker exec -it %CONTAINER% ash
docker rm -f %CONTAINER%
endlocal
exit /b 0
