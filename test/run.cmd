@echo off

where /Q docker
if errorlevel 0 goto PRE_STEP1
echo Docker service and client are required to run this setup.
exit /b 1
:PRE_STEP1

if exist tmp rd /S /Q tmp
md tmp
if exist _site rd /S /Q _site
md _site

setlocal
set PWD=%~dp0
set PJHOME=%PWD:~0,-6%

rem ==== SET VOL1 ====
set VTHEMES=%1
if "%VTHEMES%"=="" set VTHEMES=%PJHOME%\tmp
set VOL1=%VTHEMES%:/v/t/

rem ==== SET VOL2 ====
set VOL2=%PJHOME%:/v/a/:ro

rem ==== SET VOL3 ====
set VOL3=%PJHOME%\_site:/srv/jekyll/_site

rem ==== SET VOL4 ====
set VOL4=%USERPROFILE%\.ssh\id_rsa:/root/.ssh/id_rsa:ro

set CONTAINER=jekyll
set IMAGE=danmaq/jekyll-git-redcarpet:github-pages
set GIT_NAME="Jekyll bot by Shuhei Nomura"
set GIT_EMAIL="info@danmaq.com"
set LOOP="mkdir /root/.ssh; while true; do sleep 1; done"

docker run -d -p 4000:4000 -v %VOL1% -v %VOL2% -v %VOL3% -v %VOL4% -e GIT_NAME=%GIT_NAME% -e GIT_EMAIL=%GIT_EMAIL% --name %CONTAINER% %IMAGE% sh -c %LOOP%
echo "Please open via browser: http://localhost:4000"

docker exec -it %CONTAINER% /v/a/test/incontainer
rem docker exec -it %CONTAINER% ash
docker rm -f %CONTAINER%
endlocal
exit /b 0
