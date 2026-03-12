
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

export function middleware(request: NextRequest) {
  const role = request.cookies.get("role")?.value;
  const membershipType = request.cookies.get("membershipType")?.value;
  const { pathname } = request.nextUrl;

  // Publicly accessible routes
  const publicPaths = ["/", "/login", "/signup", "/contact", "/events","/about"];

  //  Allow public pages, dynamic event details, verify-enquiry
  if (
    publicPaths.includes(pathname) ||
    pathname.startsWith("/events/") ||
    pathname.startsWith("/verify-enquiry/")
  ) {
    return NextResponse.next();
  }

  //  If user is NOT authenticated → redirect to login
  if (!role) {
    return NextResponse.redirect(new URL("/login", request.url));
  }
    
  // Role-based allowed paths mapping
  const roleRoutes: Record<string, string[]> = {
    admin: ["/", "/events", "/contact", "/dashboard"],
    organizer: ["/", "/events", "/contact", "/organizerdashboard", "/outer/dashboard"],
    attendee: ["/", "/events", "/contact", "/favorites","/profile"], 
  };

  const allowedPaths = roleRoutes[role] || [];

  //  Check if current path is allowed for role
  if (allowedPaths.includes(pathname) || pathname.startsWith("/events/")) {
    return NextResponse.next();
  }

  //  Redirect to proper default dashboard/home for each role
  if (role === "admin") {
    return NextResponse.redirect(new URL("/dashboard", request.url));
  } else if (role === "organizer" && membershipType === "outer") {
    return NextResponse.redirect(new URL("/outer/dashboard", request.url));
  }else if (role === "organizer" && membershipType === "inner") {
    return NextResponse.redirect(new URL("/organizerdashboard", request.url));
  }
   else if (role === "attendee") {
    return NextResponse.redirect(new URL("/", request.url));
  }

  // Default fallback: redirect to login
  return NextResponse.redirect(new URL("/login", request.url));
}

export const config = {
  matcher: [
    "/((?!_next/|api/|static/|images/|fonts/|favicon.ico|.*\\..*$).*)",
  ],
};


