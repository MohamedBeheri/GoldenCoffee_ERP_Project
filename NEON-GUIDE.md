# ⚡ Neon PostgreSQL - Serverless (مجاني)

## الخطوة 1: سجل على Neon
1. روح [neon.tech](https://neon.tech)
2. سجل بحساب Google أو GitHub

## الخطوة 2: اعمل Project
1. **Create Project**
2. Name: `golden-coffee-erp`
3. Region: **Frankfurt (EU)**
4. اضغط **Create Project**

## الخطوة 3: جيب DATABASE_URL
1. في Dashboard → **Connection Details**
2. اختار **PostgreSQL**
3. انسخ الـ Connection String:
```
postgresql://user:password@ep-xxx.eu-central-1.aws.neon.tech/neondb?sslmode=require
```

## الخطوة 4: ضيفه في Render
نفس الخطوات اللي في Supabase Guide.

## ⚡ مميزات Neon
- Scale to zero (مش هتدفع لما مش شغال)
- Database branching (زي Git branches)
- Cold start ~0.5s
