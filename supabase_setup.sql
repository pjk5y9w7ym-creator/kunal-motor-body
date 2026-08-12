-- Run in Supabase SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.admin_users enable row level security;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path=public as $$
  select exists(select 1 from public.admin_users where user_id=auth.uid());
$$;

create table if not exists public.site_settings (
  id integer primary key check (id=1),
  tagline text default 'मजबूत बॉडी, आपका भरोसा हमारी जिम्मेदारी',
  address text default 'NH 48 Delhi Jaipur Highway, Paota',
  phone1 text default '90413 49014',
  phone2 text default '99963 83907',
  updated_by uuid references auth.users(id),
  updated_at timestamptz default now()
);
insert into public.site_settings(id) values(1) on conflict(id) do nothing;
alter table public.site_settings enable row level security;

create table if not exists public.media (
  id uuid primary key default gen_random_uuid(),
  title text,
  media_type text not null check(media_type in ('photo','video')),
  storage_path text not null unique,
  public_url text not null,
  created_by uuid not null references auth.users(id),
  created_at timestamptz default now()
);
alter table public.media enable row level security;

create policy "public read settings" on public.site_settings for select using(true);
create policy "admin change settings" on public.site_settings for all using(public.is_admin()) with check(public.is_admin());

create policy "public read media" on public.media for select using(true);
create policy "admin insert media" on public.media for insert with check(public.is_admin() and created_by=auth.uid());
create policy "admin delete media" on public.media for delete using(public.is_admin());

-- Create a Storage bucket named exactly: media
-- Make it PUBLIC so website visitors can view uploaded photos/videos.
create policy "public view media files" on storage.objects for select using(bucket_id='media');
create policy "admin upload media files" on storage.objects for insert with check(bucket_id='media' and public.is_admin());
create policy "admin delete media files" on storage.objects for delete using(bucket_id='media' and public.is_admin());

-- After creating your own user in Authentication > Users, paste that user's UUID here:
-- insert into public.admin_users(user_id) values ('YOUR-AUTH-USER-UUID');
