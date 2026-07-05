#!/bin/bash

echo "☕ Golden Coffee ERP - GitHub Setup Script"
echo "=========================================="

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first:"
    echo "   https://git-scm.com/downloads"
    exit 1
fi

# Initialize git
echo "🔄 Initializing Git repository..."
git init

# Add all files
echo "📦 Adding files..."
git add .

# Commit
echo "💾 Committing..."
git commit -m "🚀 Golden Coffee ERP v2.0 - Initial Release"

# Ask for GitHub username
echo ""
echo "📋 Please enter your GitHub username:"
read username

# Create repository name
repo_name="golden-coffee-erp"

echo ""
echo "🔗 Now follow these steps:"
echo "   1. Go to: https://github.com/new"
echo "   2. Repository name: $repo_name"
echo "   3. DON'T check 'Add a README'"
echo "   4. Click 'Create repository'"
echo ""
echo "Press ENTER when done..."
read

# Add remote and push
echo "🚀 Pushing to GitHub..."
git branch -M main
git remote add origin https://github.com/$username/$repo_name.git
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ SUCCESS! Repository pushed to:"
    echo "   https://github.com/$username/$repo_name"
    echo ""
    echo "🌐 Next step: Deploy to Render"
    echo "   Read: DEPLOY-RENDER.md"
else
    echo ""
    echo "❌ Push failed. You may need to:"
    echo "   1. Login to GitHub: git config --global user.name 'Your Name'"
    echo "   2. Set email: git config --global user.email 'your@email.com'"
    echo "   3. Or use HTTPS with token instead of password"
fi
