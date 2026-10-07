@echo off
echo Recompiling Flutter Web app...
cd flutter_source
call D:\flutter\bin\flutter.bat build web --release
if %errorlevel% neq 0 (
    echo Build failed!
    exit /b %errorlevel%
)
echo Copying web build to root...
cd ..
xcopy /s /e /y flutter_source\build\web\* .
echo Done!
