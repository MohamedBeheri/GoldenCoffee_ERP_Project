#!/bin/bash
# ☕ Golden Coffee ERP - Push to GitHub & Deploy to Render
# =========================================================

set -e  # Exit on error

echo ""
echo "☕ Golden Coffee ERP - Auto Push & Deploy"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v git &> /dev/null; then
    echo "${RED}❌ Git is not installed.${NC}"
    echo "   Install from: https://git-scm.com/downloads"
    exit 1
fi

if ! command -v node &> /dev/null; then
    echo "${RED}❌ Node.js is not installed.${NC}"
    echo "   Install from: https://nodejs.org"
    exit 1
fi

echo "${GREEN}✅ Git and Node.js found${NC}"

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "${RED}❌ Error: package.json not found.${NC}"
    echo "   Please run this script from the GoldenCoffee_ERP_Project folder"
    exit 1
fi

# Git config check
echo ""
echo "🔧 Checking Git configuration..."
GIT_NAME=$(git config user.name || echo "")
GIT_EMAIL=$(git config user.email || echo "")

if [ -z "$GIT_NAME" ]; then
    echo "${YELLOW}⚠️  Git user.name not set${NC}"
    echo "   Run: git config --global user.name 'Your Name'"
fi

if [ -z "$GIT_EMAIL" ]; then
    echo "${YELLOW}⚠️  Git user.email not set${NC}"
    echo "   Run: git config --global user.email 'your@email.com'"
fi

# Initialize git
echo ""
echo "🔄 Initializing Git repository..."
if [ ! -d ".git" ]; then
    git init
    echo "${GREEN}✅ Git initialized${NC}"
else
    echo "${GREEN}✅ Git already initialized${NC}"
fi

# Install dependencies
echo ""
echo "📦 Installing dependencies..."
npm install

# Generate Prisma client
echo ""
echo "🔨 Generating Prisma client..."
npx prisma generate

# Add all files
echo ""
echo "📦 Adding files to Git..."
git add .

# Commit
echo ""
echo "💾 Committing..."
if git diff --cached --quiet; then
    echo "${YELLOW}⚠️  No changes to commit${NC}"
else
    git commit -m "🚀 Golden Coffee ERP v2.0 - Full Stack Release"
    echo "${GREEN}✅ Committed${NC}"
fi

# Get GitHub info
echo ""
echo "📋 GitHub Setup"
echo "---------------"
echo ""
echo "Please enter your GitHub username:"
read -r GITHUB_USERNAME

if [ -z "$GITHUB_USERNAME" ]; then
    echo "${RED}❌ Username cannot be empty${NC}"
    exit 1
fi

REPO_NAME="golden-coffee-erp"
REPO_URL="https://github.com/$GITHUB_USERNAME/$REPO_NAME"

echo ""
echo "🔗 Repository will be: $REPO_URL"
echo ""
echo "${YELLOW}👉 Follow these steps:${NC}"
echo "   1. Open: https://github.com/new"
echo "   2. Repository name: $REPO_NAME"
echo "   3. DON'T check 'Add a README file'"
echo "   4. Click 'Create repository'"
echo ""
echo "Press ENTER when done..."
read -r

# Add remote and push
echo ""
echo "🚀 Pushing to GitHub..."

# Remove old remote if exists
git remote remove origin 2>/dev/null || true

git branch -M main
git remote add origin "$REPO_URL.git"

# Try pushing
if git push -u origin main; then
    echo ""
    echo "${GREEN}✅ SUCCESS! Repository pushed to:${NC}"
    echo "   $REPO_URL"
    echo ""
    echo "${GREEN}🎉 Next steps:${NC}"
    echo "   1. Go to https://render.com"
    echo "   2. Sign up with GitHub"
    echo "   3. New + → PostgreSQL → Name: golden-coffee-db → Free"
    echo "   4. New + → Web Service → Connect: $REPO_NAME"
    echo "   5. Build: npm install && npm run build"
    echo "   6. Start: npm start"
    echo "   7. Add Environment Variables (see DEPLOY-RENDER.md)"
    echo "   8. Create Web Service"
    echo "   9. Visit: /api/seed to initialize database"
    echo ""
    echo "${GREEN}📖 Full guide: DEPLOY-RENDER.md${NC}"

    # Open browser (Linux/Mac)
    if command -v xdg-open &> /dev/null; then
        xdg-open "$REPO_URL" &
    elif command -v open &> /dev/null; then
        open "$REPO_URL" &
    fi
else
    echo ""
    echo "${RED}❌ Push failed.${NC}"
    echo ""
    echo "${YELLOW}Common fixes:${NC}"
    echo "   1. If asked for password, use Personal Access Token instead:"
    echo "      https://github.com/settings/tokens → Generate new token"
    echo "   2. Or use SSH:"
    echo "      git remote set-url origin git@github.com:$GITHUB_USERNAME/$REPO_NAME.git"
    echo "   3. Make sure the repository exists on GitHub"
    echo ""
    echo "${YELLOW}Alternative: Upload ZIP manually${NC}"
    echo "   1. Go to: $REPO_URL"
    echo "   2. Click 'Uploading an existing file'"
    echo "   3. Drag & drop all files"
fi
