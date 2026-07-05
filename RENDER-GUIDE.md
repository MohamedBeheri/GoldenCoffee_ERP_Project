# 🌐 النشر على Render (بدون Docker - Native Node.js)

## ⚠️ مهم: Render بيستخدم Native Node.js مش Docker

الـ Error اللي ظهر لك بيحصل لأن Docker build بيفشل. الحل: **استخدم Native Node.js على Render** (مش Docker).

## الخطوة 1: رفع المشروع على GitHub

اتبع [MANUAL-UPLOAD.md](MANUAL-UPLOAD.md) أو شغل:
```bash
./push-to-github.sh
```

## الخطوة 2: سجل على Render

1. روح [dashboard.render.com](https://dashboard.render.com)
2. سجل بحساب **GitHub**

## الخطوة 3: اعمل PostgreSQL Database

1. **New +** → **PostgreSQL**
2. Name: `golden-coffee-db`
3. Region: **Frankfurt (EU)**
4. Plan: **Free**
5. **Create Database**
6. انتظر 1 دقيقة
7. اضغط على الـ Database
8. انسخ **Internal Connection String** (هيبقى شكله كده):
   ```
   postgresql://postgres:PASSWORD@golden-coffee-db:5432/golden_coffee
   ```

## الخطوة 4: اعمل Web Service (Native Node.js - مهم!)

1. **New +** → **Web Service** (مش Docker!)
2. Connect → اختار `golden-coffee-erp` من GitHub
3. املأ البيانات دي بالظبط:

| الحقل | القيمة |
|-------|--------|
| Name | `golden-coffee-erp` |
| Region | Frankfurt (EU) |
| Branch | `main` |
| Runtime | `Node` |
| Build Command | `npm install && npx prisma generate && npm run build` |
| Start Command | `npm start` |

4. **Advanced** → **Add Environment Variable**:

| Key | Value |
|-----|-------|
| `DATABASE_URL` | [انسخ الـ Internal Connection String] |
| `NEXTAUTH_URL` | `https://golden-coffee-erp.onrender.com` |
| `NEXTAUTH_SECRET` | [تولده من الأمر اللي تحت] |

**توليد NEXTAUTH_SECRET:**
```bash
openssl rand -base64 32
```

5. **Create Web Service**

## الخطوة 5: Seed Database

بعد ما يخلص Build (2-3 دقايق):

```bash
# افتح في المتصفح:
https://golden-coffee-erp.onrender.com/api/seed
```

هيطلعلك: `{"success": true, "message": "Database seeded successfully!"}`

## الخطوة 6: سجل دخول 🎉

افتح: `https://golden-coffee-erp.onrender.com`

| Username | Password | Role |
|----------|----------|------|
| `admin` | `123456` | مدير النظام |
| `factory` | `123456` | مدير المصنع |
| `warehouse` | `123456` | مدير المخزن |
| `sales` | `123456` | مدير المبيعات |
| `accountant` | `123456` | محاسب |

## ❌ لو Build فشل

### المشكلة: `npm install failed`
**الحل:**
1. تأكد إن `package.json` صح (النسخة الجديدة شلت `postinstall`)
2. في Render → Settings → Clear Build Cache → Manual Deploy → Deploy Latest Commit

### المشكلة: `prisma generate failed`
**الحل:**
1. تأكد إن `prisma/schema.prisma` موجود في الـ Repo
2. Build Command لازم تكون: `npm install && npx prisma generate && npm run build`

### المشكلة: `next build failed`
**الحل:**
1. تأكد إن `next.config.js` فيه `output: 'standalone'`
2. Check logs في Render Dashboard → Logs

## 🔄 تحديث الموقع

لو عدلت في الكود:
```bash
git add .
git commit -m "Update"
git push origin main
```
Render هيعمل Deploy تلقائي!
