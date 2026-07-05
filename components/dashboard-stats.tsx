'use client'

interface StatsProps {
  totalInventory: number
  totalSales: number
  activeDelegates: number
  alerts: number
}

export function DashboardStats({ totalInventory, totalSales, activeDelegates, alerts }: StatsProps) {
  const stats = [
    { label: 'رصيد المخزن', value: totalInventory, icon: '📦', color: 'bg-blue-50 text-blue-600' },
    { label: 'إجمالي المبيعات', value: `ج.م ${totalSales.toFixed(2)}`, icon: '💰', color: 'bg-green-50 text-green-600' },
    { label: 'مندوبين نشطين', value: activeDelegates, icon: '🚚', color: 'bg-orange-50 text-orange-600' },
    { label: 'تنبيهات', value: alerts, icon: '⚠️', color: 'bg-red-50 text-red-600' },
  ]

  return (
    <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
      {stats.map((stat) => (
        <div key={stat.label} className="bg-white p-6 rounded-xl shadow-sm flex items-center gap-4">
          <div className={`w-14 h-14 rounded-xl flex items-center justify-center text-2xl ${stat.color}`}>
            {stat.icon}
          </div>
          <div>
            <p className="text-2xl font-bold text-[#1a1a2e]">{stat.value}</p>
            <p className="text-sm text-gray-500">{stat.label}</p>
          </div>
        </div>
      ))}
    </div>
  )
}
