@echo off
echo.
echo ☕ Golden Coffee ERP - Auto Push to GitHub
echo ==========================================
echo.

REM Check prerequisites
echo Checking prerequisites...

git --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Git is not installed.
    echo    Install from: https://git-scm.com/downloads
    pause
    exit /b 1
)

node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed.
    echo    Install from: https://nodejs.org
    pause
    exit /b 1
)

echo ✅ Git and Node.js found

REM Check if we're in the right directory
if not exist "package.json" (
    echo ❌ Error: package.json not found.
    echo    Please run this script from the GoldenCoffee_ERP_Project folder
    pause
    exit /b 1
)

REM Initialize git
echo.
echo 🔄 Initializing Git repository...
if not exist ".git" (
    git init
    echo ✅ Git initialized
) else (
    echo ✅ Git already initialized
)

REM Install dependencies
echo.
echo 📦 Installing dependencies...
call npm install

REM Generate Prisma client
echo.
echo 🔨 Generating Prisma client...
call npx prisma generate

REM Add all files
echo.
echo 📦 Adding files to Git...
git add .

REM Commit
echo.
echo 💾 Committing...
git diff --cached --quiet
if %errorlevel% == 0 (
    echo ⚠️ No changes to commit
) else (
    git commit -m "🚀 Golden Coffee ERP v2.0 - Full Stack Release"
    echo ✅ Committed
)

REM Get GitHub info
echo.
echo 📋 GitHub Setup
echo ---------------
echo.
echo Please enter your GitHub username:
set /p GITHUB_USERNAME=

if "%GITHUB_USERNAME%"=="" (
    echo ❌ Username cannot be empty
    pause
    exit /b 1
)

set REPO_NAME=golden-coffee-erp
set REPO_URL=https://github.com/%GITHUB_USERNAME%/%REPO_NAME%

echo.
echo 🔗 Repository will be: %REPO_URL%
echo.
echo 👉 Follow these steps:
echo    1. Open: https://github.com/new
echo    2. Repository name: %REPO_NAME%
echo    3. DON'T check 'Add a README file'
echo    4. Click 'Create repository'
echo.
echo Press ENTER when done...
pause >nul

REM Add remote and push
echo.
echo 🚀 Pushing to GitHub...

git remote remove origin 2>nul
git branch -M main
git remote add origin %REPO_URL%.git

git push -u origin main
if %errorlevel% == 0 (
    echo.
    echo ✅ SUCCESS! Repository pushed to:
    echo    %REPO_URL%
    echo.
    echo 🎉 Next steps:
    echo    1. Go to https://render.com
echo    2. Sign up with GitHub
echo    3. New + -^> PostgreSQL -^> Name: golden-coffee-db -^> Free
echo    4. New + -^> Web Service -^> Connect: %REPO_NAME%
echo    5. Build: npm install ^&^& npm run build
echo    6. Start: npm start
echo    7. Add Environment Variables (see DEPLOY-RENDER.md)
echo    8. Create Web Service
echo    9. Visit: /api/seed to initialize database
echo.
    echo 📖 Full guide: DEPLOY-RENDER.md

    start %REPO_URL%
) else (
    echo.
    echo ❌ Push failed.
    echo.
    echo Common fixes:
    echo    1. If asked for password, use Personal Access Token:
    echo       https://github.com/settings/tokens -^> Generate new token
echo    2. Or use SSH:
echo       git remote set-url origin git@github.com:%GITHUB_USERNAME%/%REPO_NAME%.git
echo    3. Make sure the repository exists on GitHub
echo.
    echo Alternative: Upload ZIP manually
echo    1. Go to: %REPO_URL%
echo    2. Click 'Uploading an existing file'
echo    3. Drag ^& drop all files
)

pause
