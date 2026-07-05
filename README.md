# ☕ Golden Coffee ERP

<p align="center">
  <img src="https://img.shields.io/badge/Next.js-14-black?style=for-the-badge&logo=next.js" />
  <img src="https://img.shields.io/badge/Prisma-5.10-2D3748?style=for-the-badge&logo=prisma" />
  <img src="https://img.shields.io/badge/PostgreSQL-16-316192?style=for-the-badge&logo=postgresql" />
  <img src="https://img.shields.io/badge/Tailwind-3.4-38B2AC?style=for-the-badge&logo=tailwind-css" />
  <img src="https://img.shields.io/badge/TypeScript-5.3-3178C6?style=for-the-badge&logo=typescript" />
</p>

## 📋 نظام ERP متكامل لمطاحن ومصانع البن

نظام إدارة متكامل يغطي:
- 🏭 **المصنع**: شراء بن أخضر + تصنيع (تحميص وتعبئة)
- 📦 **المخزن**: دخول/خروج بضاعة + جرد + تنبيهات
- 🛒 **المبيعات**: فواتير + عملاء (فوري/آجل) + نقاط بيع
- 🚚 **المندوبين**: أوامر تسليم + تسويات + عمولات
- 💰 **التقارير المالية**: قائمة دخل + ميزانية عمومية + تدفق نقدي
- 🛡️ **الحوكمة**: سجل مراجعة + صلاحيات + مستخدمين

## 🚀 Quick Start (محلي)

```bash
# 1. Clone
git clone https://github.com/YOUR_USERNAME/golden-coffee-erp.git
cd golden-coffee-erp

# 2. Install
npm install

# 3. Setup database
cp .env.example .env
# عدل DATABASE_URL في .env

# 4. Push schema & seed
npx prisma db push
npx prisma db seed

# 5. Run
npm run dev
# افتح http://localhost:3000
```

## 🔑 Demo Credentials

| Username | Password | Role |
|----------|----------|------|
| `admin` | `123456` | مدير النظام |
| `factory` | `123456` | مدير المصنع |
| `warehouse` | `123456` | مدير المخزن |
| `sales` | `123456` | مدير المبيعات |
| `accountant` | `123456` | محاسب |

## 🌐 النشر على Render (خطوة بخطوة)

### الخطوة 1: رفع على GitHub

```bash
# 1. اعمل repo جديد على GitHub (بدون README)
# 2. في Terminal:
git init
git add .
git commit -m "Initial commit - Golden Coffee ERP v2.0"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/golden-coffee-erp.git
git push -u origin main
```

### الخطوة 2: ربط Render

1. سجل على [render.com](https://render.com) بحساب GitHub
2. من Dashboard → **New +** → **Web Service**
3. اختار **Build and deploy from a Git repository**
4. Connect → اختار `golden-coffee-erp`
5. املأ البيانات:

| Field | Value |
|-------|-------|
| Name | `golden-coffee-erp` |
| Region | Frankfurt (EU) |
| Branch | `main` |
| Runtime | `Node` |
| Build Command | `npm install && npm run build` |
| Start Command | `npm start` |

6. اضغط **Advanced** → **Add Environment Variable**:

```
NEXTAUTH_URL = https://golden-coffee-erp.onrender.com
NEXTAUTH_SECRET = (تولد من openssl rand -base64 32)
```

7. **Add PostgreSQL** (New + → PostgreSQL):
   - Name: `golden-coffee-db`
   - Plan: Free
   - بعد ما يتعمل، اضغط عليه → Internal Connection String
   - انسخه وارجع للـ Web Service → Environment Variables
   - اضف: `DATABASE_URL = [اللي نسخته]`

8. اضغط **Create Web Service**

### الخطوة 3: Seed Database

بعد ما يخلص Build:

```bash
# افتح Render Shell (أو استخدم Render CLI)
npx prisma db seed
```

أو اعمل Seed Route مؤقت:

```bash
# افتح المتصفح
https://golden-coffee-erp.onrender.com/api/seed
```

### الخطوة 4: خلاص! 🎉

افتح الموقع وسجل دخول بـ `admin` / `123456`

## 🐳 Docker (اختياري)

```bash
# Start everything
docker-compose up -d

# View logs
docker-compose logs -f app
```

## 📁 Project Structure

```
golden-coffee-erp/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Login page
│   ├── dashboard/         # Dashboard + Stats
│   ├── api/               # REST API
│   │   ├── auth/          # NextAuth
│   │   ├── purchases/     # Purchase API
│   │   ├── production/    # Production API
│   │   ├── invoices/      # Invoice API
│   │   └── products/      # Product API
│   └── layout.tsx         # Root layout
├── components/            # React Components
├── lib/                   # Prisma Client
├── prisma/
│   ├── schema.prisma      # 20+ Tables
│   └── seed.ts            # Demo data
├── types/                 # TypeScript types
├── public/                # Static assets
├── middleware.ts          # Auth + RBAC
├── docker-compose.yml     # Docker
├── render.yaml            # Render Blueprint
├── package.json
└── README.md
```

## 🔐 Security

- JWT Authentication (NextAuth.js)
- Role-Based Access Control (RBAC)
- Middleware protection
- Audit logging
- Input validation (Zod)
- SQL injection protection (Prisma)
- Password hashing (bcrypt)

## 📊 Database Schema

20+ tables: Users, Products, Suppliers, Purchases, Production, Warehouse, Customers, Invoices, Delegates, Settlements, CashFlow, AuditLog...

## 📝 License

MIT License - Open Source

---
<p align="center">Made with ☕ by Golden Coffee Team</p>
