# 🔗 DATABASE_URL - دليل كامل

## إيه هو DATABASE_URL؟

ده الرابط اللي بيخلي التطبيق يتصل بقاعدة البيانات. شكله كده:

```
postgresql://USER:PASSWORD@HOST:PORT/DATABASE_NAME
```

## إزاي تجيبه من Render؟

### الخطوة 1: افتح الـ Database
1. روح [dashboard.render.com](https://dashboard.render.com)
2. من القائمة على اليسار، اختار **PostgreSQL**
3. اضغط على اسم الـ Database (مثلاً: `golden-coffee-db`)

### الخطوة 2: انسخ الـ Internal URL
1. في صفحة الـ Database، انزل لتحت شوية
2. هتلاقي قسم اسمه **Connections**
3. فيه حاجة اسمها **Internal Database URL**
4. اضغط على الـ Copy button (📋) جنبها

```
مثال على الـ URL:
postgresql://postgres:AbCdEfGh123@dpg-abc123-a.frankfurt-postgres.render.com:5432/golden_coffee
```

### ⚠️ مهم جداً:
- **لو التطبيق شغال على Render** → استخدم **Internal URL**
- **لو التطبيق شغال على جهازك** → استخدم **External URL**

## إزاي تضيفه في Render Web Service؟

### الخطوة 1: افتح الـ Web Service
1. في Dashboard → اختار **Web Services**
2. اضغط على `golden-coffee-erp`

### الخطوة 2: اضيف Environment Variable
1. من القائمة على اليسار → **Environment**
2. اضغط **Add Environment Variable**
3. املأ البيانات:

| Key | Value |
|-----|-------|
| `DATABASE_URL` | `postgresql://postgres:AbCdEfGh123@dpg-abc123-a.frankfurt-postgres.render.com:5432/golden_coffee` |

4. اضغط **Save Changes**

### الخطوة 3: Redeploy
1. بعد ما تحفظ، اضغط **Manual Deploy** → **Deploy Latest Commit**
2. انتظر 2-3 دقايق

## ❌ أخطاء شائعة

### Error 1: `connection refused`
**السبب:** استخدمت External URL بدل Internal URL
**الحل:** انسخ Internal URL من Render

### Error 2: `password authentication failed`
**السبب:** غيرت الـ Password أو الـ User
**الحل:** استخدم الـ URL زي ما هو من Render متغيرش فيه حاجة

### Error 3: `database does not exist`
**السبب:** غيرت اسم الـ Database في الـ URL
**الحل:** تأكد إن اسم الـ Database في الـ URL هو نفسه اللي عملته

## 🧪 إزاي تتأكد إنه شغال؟

افتح الـ URL ده في المتصفح:
```
https://golden-coffee-erp.onrender.com/api/seed
```

لو ظهر:
```json
{"success": true, "message": "Database seeded successfully!"}
```

يبقى كل حاجة شغالة! 🎉

## 🔧 لو لسه مش شغال

### جرب تضيف `?schema=public` في آخر الـ URL:
```
postgresql://USER:PASSWORD@HOST:PORT/DATABASE_NAME?schema=public
```

### أو جرب الـ External URL لو Internal مش شغال:
```
postgresql://USER:PASSWORD@HOST-EXTERNAL:PORT/DATABASE_NAME
```
