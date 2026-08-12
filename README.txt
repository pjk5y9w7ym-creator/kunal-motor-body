KUNAL MOTOR BODY — SECURE ADMIN + PHOTO/VIDEO SYSTEM

This version keeps the same black/gold website theme and adds a real login + shared media system.

WHAT YOU GET
1. Public website: index.html
2. Secure admin page: admin.html
3. Admin login through Supabase Authentication.
4. Only the user ID placed in admin_users can upload/delete/change details.
5. Multiple photos/videos can be uploaded at once.
6. Uploaded media is stored in Supabase Storage and appears on the public site.
7. Admin can change tagline, address and phone numbers.
8. Public visitors cannot edit the website.

WHY SUPABASE?
GitHub Pages is static. A secure password-protected upload system cannot safely be implemented with only HTML/JS/localStorage. Supabase provides authentication, database, and file storage.

SETUP
A) Create a Supabase project.
B) Authentication > Users > create YOUR admin email/password.
C) Storage > New bucket > name it: media > Public.
D) SQL Editor > run supabase_setup.sql.
E) In the SQL file, uncomment/fill the admin user insert using YOUR Auth User UUID.
F) Rename config.example.js to config.js and put:
   - Supabase Project URL
   - public anon key
   Never use service_role/secret key in config.js.
G) Upload index.html, admin.html, style.css, config.js to GitHub.
H) Open /admin.html and login.

IMPORTANT
• This code skips individual files over 100 MB. For very large videos, resumable uploads can be added later.
• Keep your Supabase project protected by using the RLS policies in supabase_setup.sql.
• Do not share your admin password or service_role key.

SHOP LOCATION
https://maps.app.goo.gl/wGeiFZKvQ6QviSLcA?g_st=ic

FACEBOOK
https://www.facebook.com/share/1EK3PkZN1x/?mibextid=wwXIfr
