@echo off
echo ☕ Golden Coffee ERP - GitHub Setup Script
echo ==========================================

REM Check if git is installed
git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git is not installed. Please install Git first:
    echo    https://git-scm.com/downloads
    pause
    exit /b 1
)

REM Initialize git
echo 🔄 Initializing Git repository...
git init

REM Add all files
echo 📦 Adding files...
git add .

REM Commit
echo 💾 Committing...
git commit -m "🚀 Golden Coffee ERP v2.0 - Initial Release"

REM Ask for GitHub username
echo.
echo 📋 Please enter your GitHub username:
set /p username=

REM Create repository name
set repo_name=golden-coffee-erp

echo.
echo 🔗 Now follow these steps:
echo    1. Go to: https://github.com/new
echo    2. Repository name: %repo_name%
echo    3. DON'T check 'Add a README'
echo    4. Click 'Create repository'
echo.
echo Press ENTER when done...
pause >nul

REM Add remote and push
echo 🚀 Pushing to GitHub...
git branch -M main
git remote add origin https://github.com/%username%/%repo_name%.git
git push -u origin main

if %errorlevel% == 0 (
    echo.
    echo ✅ SUCCESS! Repository pushed to:
    echo    https://github.com/%username%/%repo_name%
    echo.
    echo 🌐 Next step: Deploy to Render
    echo    Read: DEPLOY-RENDER.md
) else (
    echo.
    echo ❌ Push failed. You may need to:
    echo    1. Login to GitHub: git config --global user.name "Your Name"
    echo    2. Set email: git config --global user.email "your@email.com"
    echo    3. Or use HTTPS with token instead of password
)

pause
