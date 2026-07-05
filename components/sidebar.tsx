'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { signOut } from 'next-auth/react'

const menuItems = [
  { href: '/dashboard', label: 'لوحة التحكم', icon: '📊', roles: ['ADMIN', 'FACTORY', 'WAREHOUSE', 'SALES', 'ACCOUNTANT'] },
  { href: '/factory', label: 'المصنع', icon: '🏭', roles: ['ADMIN', 'FACTORY'] },
  { href: '/warehouse', label: 'المخزن', icon: '📦', roles: ['ADMIN', 'WAREHOUSE'] },
  { href: '/sales', label: 'المبيعات', icon: '🛒', roles: ['ADMIN', 'SALES'] },
  { href: '/delegates', label: 'المندوبين', icon: '🚚', roles: ['ADMIN', 'SALES'] },
  { href: '/finance', label: 'التقارير المالية', icon: '💰', roles: ['ADMIN', 'ACCOUNTANT'] },
  { href: '/governance', label: 'الحوكمة', icon: '🛡️', roles: ['ADMIN'] },
  { href: '/settings', label: 'الإعدادات', icon: '⚙️', roles: ['ADMIN'] },
]

export function Sidebar({ user }: { user: any }) {
  const pathname = usePathname()
  const userRole = user?.role as string
  const filteredMenu = menuItems.filter(item => item.roles.includes(userRole))

  return (
    <aside className="fixed right-0 top-0 bottom-0 w-72 bg-[#1a1a2e] text-white overflow-y-auto z-50">
      <div className="p-6 border-b border-gray-700">
        <h2 className="text-xl font-bold text-[#e94560]">☕ Golden Coffee</h2>
        <p className="text-xs text-gray-400 mt-1">ERP System v2.0</p>
      </div>
      <div className="p-4 border-b border-gray-700">
        <div className="flex items-center gap-3">
          <div className="w-10 h-10 rounded-full bg-[#e94560] flex items-center justify-center font-bold">
            {user?.name?.charAt(0) || 'U'}
          </div>
          <div>
            <p className="font-semibold text-sm">{user?.name || 'User'}</p>
            <p className="text-xs text-gray-400">{user?.role || 'User'}</p>
          </div>
        </div>
      </div>
      <nav className="p-4 space-y-1">
        {filteredMenu.map((item) => (
          <Link key={item.href} href={item.href}
            className={`flex items-center gap-3 px-4 py-3 rounded-lg transition-colors ${
              pathname === item.href
                ? 'bg-[#16213e] text-[#e94560] border-r-4 border-[#e94560]'
                : 'text-gray-400 hover:bg-[#16213e] hover:text-white'
            }`}>
            <span>{item.icon}</span>
            <span className="font-medium">{item.label}</span>
          </Link>
        ))}
        <button onClick={() => signOut({ callbackUrl: '/' })}
          className="w-full flex items-center gap-3 px-4 py-3 rounded-lg text-red-400 hover:bg-[#16213e] transition-colors mt-8">
          <span>🚪</span>
          <span className="font-medium">تسجيل الخروج</span>
        </button>
      </nav>
    </aside>
  )
}
