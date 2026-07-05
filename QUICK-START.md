# ⚡ Quick Start - ابدأ في 5 دقايق

## 1️⃣ فك الضغط
```bash
unzip GoldenCoffee_ERP_Project.zip
cd GoldenCoffee_ERP_Project
```

## 2️⃣ ارفع على GitHub (اختر طريقة)

### طريقة A: Script تلقائي (الأسهل)
```bash
# Linux/Mac:
./setup.sh

# Windows:
setup.bat
```

### طريقة B: يدوي
```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/golden-coffee-erp.git
git push -u origin main
```

## 3️⃣ انشر على Render
1. سجل على [render.com](https://render.com) بحساب GitHub
2. New + → PostgreSQL → Name: `golden-coffee-db` → Free
3. New + → Web Service → Connect `golden-coffee-erp`
4. Build: `npm install && npm run build`
5. Start: `npm start`
6. Environment Variables:
   - `DATABASE_URL` = [من PostgreSQL]
   - `NEXTAUTH_URL` = `https://your-app.onrender.com`
   - `NEXTAUTH_SECRET` = `openssl rand -base64 32`
7. Create Web Service

## 4️⃣ Seed Database
افتح: `https://your-app.onrender.com/api/seed`

## 5️⃣ سجل دخول
- URL: `https://your-app.onrender.com`
- admin / 123456

🎉 **خلاص! الموقع شغال على النت!**
