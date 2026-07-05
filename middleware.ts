import { withAuth } from 'next-auth/middleware'
import { NextResponse } from 'next/server'

export default withAuth(
  function middleware(req) {
    const token = req.nextauth.token
    const path = req.nextUrl.pathname
    const role = token?.role as string

    const permissions: Record<string, string[]> = {
      '/factory': ['ADMIN', 'FACTORY'],
      '/warehouse': ['ADMIN', 'WAREHOUSE'],
      '/sales': ['ADMIN', 'SALES'],
      '/delegates': ['ADMIN', 'SALES'],
      '/finance': ['ADMIN', 'ACCOUNTANT'],
      '/governance': ['ADMIN'],
      '/settings': ['ADMIN'],
    }

    for (const [route, allowedRoles] of Object.entries(permissions)) {
      if (path.startsWith(route) && !allowedRoles.includes(role)) {
        return NextResponse.redirect(new URL('/dashboard', req.url))
      }
    }

    return NextResponse.next()
  },
  {
    callbacks: {
      authorized({ token }) {
        return !!token
      },
    },
  }
)

export const config = {
  matcher: ['/dashboard/:path*', '/factory/:path*', '/warehouse/:path*', '/sales/:path*', '/delegates/:path*', '/finance/:path*', '/governance/:path*', '/settings/:path*'],
}
