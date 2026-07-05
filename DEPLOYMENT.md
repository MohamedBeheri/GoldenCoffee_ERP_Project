# 🚀 دليل النشر على الإنترنت

## الخطوة 1: تحضير المشروع

```bash
# 1. افتح Terminal/CMD وروح لمجلد المشروع
cd golden-coffee-erp

# 2. نزل الـ Dependencies
npm install

# 3. اعمل ملف .env
cp .env.example .env
```

## الخطوة 2: قاعدة البيانات (3 خيارات)

### الخيار A: PostgreSQL محلي بـ Docker (للتطوير)
```bash
docker-compose up -d
npx prisma db push
npx prisma db seed
```

### الخيار B: Railway (مجاني + سهل)
1. سجل على [railway.app](https://railway.app)
2. اعمل New Project → Provision PostgreSQL
3. خد الـ DATABASE_URL من Settings
4. حطه في ملف `.env`

### الخيار C: Supabase (مجاني + موثوق)
1. سجل على [supabase.com](https://supabase.com)
2. اعمل New Project
3. من Settings → Database → Connection String
4. اختار URI وانسخه
5. حطه في `.env`

## الخطوة 3: تشغيل محلي

```bash
npm run dev
# افتح http://localhost:3000
```

## الخطوة 4: النشر على Vercel (الأسهل)

```bash
# 1. سجل على Vercel
npm i -g vercel

# 2. لينك المشروع
vercel

# 3. حط متغيرات البيئة
vercel env add DATABASE_URL
vercel env add NEXTAUTH_SECRET

# 4. نشر الإنتاج
vercel --prod
```

## الخطوة 5: النشر على Render (مجاني)

1. سجل على [render.com](https://render.com)
2. New → Web Service
3. Connect GitHub repo
4. Build Command: `npm install && npx prisma generate && npm run build`
5. Start Command: `npm start`
6. Add Environment Variables (DATABASE_URL, NEXTAUTH_SECRET, NEXTAUTH_URL)
7. Create Web Service

## 🔐 متغيرات البيئة المطلوبة

```env
DATABASE_URL="postgresql://..."
NEXTAUTH_URL="https://your-domain.com"
NEXTAUTH_SECRET="your-random-secret-key-min-32-chars"
```

لتوليد NEXTAUTH_SECRET:
```bash
openssl rand -base64 32
```

## 📱 بعد النشر

- الموقع هيكون شغال 24/7
- كل البيانات هتتحفظ في PostgreSQL
- تقدر تدخل من أي مكان في العالم
- تقدر تضيف SSL certificate تلقائي (Vercel/Render بيعملوا ده)

## ⚡ Performance Tips

- فعل CDN في Vercel (تلقائي)
- استخدم connection pooling (PgBouncer)
- فعل ISR للصفحات الثابتة
- استخدم Image Optimization

## 🆘 Troubleshooting

| المشكلة | الحل |
|---------|------|
| `prisma generate failed` | شغل `npx prisma generate` قبل `npm run build` |
| `Database connection error` | اتأكد من DATABASE_URL صح |
| `NEXTAUTH_SECRET missing` | تولد secret واضيفه في env |
| `Build fails on Vercel` | حط `prisma generate` في postinstall |

## 🎉 خلاص!

الموقع شغال على النت! جرب تسجل دخول بـ `admin` / `123456` ☕
