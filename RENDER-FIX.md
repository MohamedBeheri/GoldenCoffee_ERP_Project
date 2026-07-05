# 🛠️ Fix: Type Error on Render

## المشكلة
`@auth/prisma-adapter` incompatible with `next-auth` v4

## الحل (3 خطوات)

### الخطوة 1: افتح Render Shell
1. Render Dashboard → `golden-coffee-erp`
2. اضغط **Shell** (في القائمة على اليسار)
3. هتفتح Terminal

### الخطوة 2: شغل الأوامر دي
```bash
# احذف الـ adapter
npm uninstall @auth/prisma-adapter

# تأكد إن package.json محدث
cat package.json | grep -v "prisma-adapter"

# نضف cache
rm -rf node_modules/.cache
rm -rf .next
```

### الخطوة 3: Redeploy
1. في نفس الصفحة → **Settings**
2. **Clear Build Cache**
3. **Manual Deploy** → **Deploy Latest Commit**

## ✅ لو لسه مش شغال

### الحل البديل: عدل Build Command
1. Render Dashboard → `golden-coffee-erp` → **Settings**
2. غير **Build Command** لـ:
```
npm uninstall @auth/prisma-adapter && npm install && npx prisma generate && npm run build
```
3. **Save** → **Deploy**

## 🔧 الحل النهائي (لو كل حاجة فشلت)

### 1. احذف الـ Project من Render واعمله تاني
### 2. لكن قبل ما تعمل Deploy، تأكد إن:
- `package.json` **مش** فيه `@auth/prisma-adapter`
- `app/api/auth/[...nextauth]/route.ts` **مش** فيه `import { PrismaAdapter }`
- `app/api/auth/[...nextauth]/route.ts` **مش** فيه `adapter: PrismaAdapter(prisma)`

### 3. اعمل Deploy من جديد
