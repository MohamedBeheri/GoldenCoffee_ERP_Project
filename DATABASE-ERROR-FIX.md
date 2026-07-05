# ❌ Error: "cannot have more than one active free tier database"

## إزاي تحلها في 30 ثانية؟

### الحل السريع (موصى به): استخدم Supabase

1. روح [supabase.com](https://supabase.com) → سجل → New Project
2. انسخ الـ Connection String من **Connect → URI**
3. في Render Dashboard → Web Service → Environment
4. اضيف `DATABASE_URL` = [اللي نسخته]
5. Save → Deploy

### الحل البديل: احذف الـ Database القديمة على Render

1. Render Dashboard → PostgreSQL
2. اختار الـ Database القديمة
3. **Settings** → **Delete Database**
4. ارجع اعمل جديدة

⚠️ **تحذير:** لو عندك بيانات مهمة في الـ Database القديمة، احفظها الأول!
