# 🌐 النشر على Render (خطوة بخطوة بالصور)

## الخطوة 1: سجل على Render
1. روح [render.com](https://render.com)
2. اضغط **Sign Up** → سجل بحساب **GitHub** (أسهل)

## الخطوة 2: اعمل PostgreSQL Database
1. من Dashboard → اضغط **New +** → **PostgreSQL**
   - Name: `golden-coffee-db`
   - Region: **Frankfurt (EU)**
   - Plan: **Free**
   - اضغط **Create Database**

2. انتظر 1 دقيقة لحد ما يتعمل

3. اضغط على الـ Database → انسخ **Internal Connection String**
   - هيبقى شكله: `postgresql://postgres:PASSWORD@golden-coffee-db:5432/golden_coffee`

## الخطوة 3: اعمل Web Service
1. من Dashboard → اضغط **New +** → **Web Service**
2. Connect → اختار `golden-coffee-erp` من GitHub
3. املأ البيانات:

| الحقل | القيمة |
|-------|--------|
| Name | `golden-coffee-erp` |
| Region | Frankfurt (EU) |
| Branch | `main` |
| Runtime | `Node` |
| Build Command | `npm install && npm run build` |
| Start Command | `npm start` |

4. اضغط **Advanced** → **Add Environment Variable**:

```
DATABASE_URL = [انسخ الـ Internal Connection String من الـ Database]
NEXTAUTH_URL = https://golden-coffee-erp.onrender.com
NEXTAUTH_SECRET = [تولده من الأمر اللي تحت]
```

**لتوليد NEXTAUTH_SECRET:**
```bash
# في Terminal أي مكان
openssl rand -base64 32
```

5. اضغط **Create Web Service**

## الخطوة 4: انتظر Build
- Render هياخد 2-3 دقايق
- لو نجح، هيطلعلك URL: `https://golden-coffee-erp.onrender.com`

## الخطوة 5: Seed Database (أول مرة بس)
افتح في المتصفح:
```
https://golden-coffee-erp.onrender.com/api/seed
```
هيطلعلك: `{"success": true, "message": "Database seeded successfully!"}`

## الخطوة 6: سجل دخول! 🎉
افتح: `https://golden-coffee-erp.onrender.com`

| Username | Password | Role |
|----------|----------|------|
| `admin` | `123456` | مدير النظام |
| `factory` | `123456` | مدير المصنع |
| `warehouse` | `123456` | مدير المخزن |
| `sales` | `123456` | مدير المبيعات |
| `accountant` | `123456` | محاسب |

## ⚠️ Troubleshooting

| المشكلة | الحل |
|---------|------|
| Build failed | اتأكد إن `package.json` فيه `"build": "prisma generate && next build"` |
| Prisma error | `postinstall` script موجود في `package.json` |
| Database not connected | اتأكد من `DATABASE_URL` صح |
| Seed not working | افتح `/api/seed` في المتصفح بعد Build |
| Static files missing | `next.config.js` فيه `output: 'standalone'` |

## 🔄 تحديث الموقع

لو عدلت في الكود ورفعت على GitHub:
```bash
git add .
git commit -m "Update description"
git push origin main
```
Render هيعمل Deploy تلقائي!
