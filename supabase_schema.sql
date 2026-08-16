-- ============================================================================
-- BookaBoo — full Supabase schema, security policies and seed data.
-- Paste this whole file into the Supabase SQL editor and run it once.
-- It is idempotent: running it again is safe and just refreshes the content.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Content tables (public catalogue — readable by everyone)
-- ---------------------------------------------------------------------------

create table if not exists public.categories (
  id          text primary key,
  name        text        not null,
  emoji       text        not null,
  color       text        not null,          -- ARGB hex, e.g. 0xFFFFB443
  image_asset text        not null,
  sort_order  int         not null default 0,
  created_at  timestamptz not null default now()
);

create table if not exists public.books (
  id          text primary key,
  title       text        not null,
  author      text        not null,
  cover_asset text        not null,
  cover_emoji text        not null,
  cover_color text        not null,          -- ARGB hex, e.g. 0xFFFFB443
  category_id text        not null references public.categories (id) on delete restrict,
  age_min     int         not null,
  age_max     int         not null,
  minutes     int         not null,
  rating      numeric(2,1) not null default 0,
  description text        not null,
  featured    boolean     not null default false,
  sort_order  int         not null default 0,
  created_at  timestamptz not null default now()
);

create index if not exists books_category_id_idx on public.books (category_id);
create index if not exists books_featured_idx    on public.books (featured) where featured;

create table if not exists public.book_pages (
  id          bigint generated always as identity primary key,
  book_id     text not null references public.books (id) on delete cascade,
  page_number int  not null,
  emoji       text not null,
  text        text not null,
  unique (book_id, page_number)
);

create index if not exists book_pages_book_id_idx on public.book_pages (book_id, page_number);

-- ---------------------------------------------------------------------------
-- 2. Per-user tables
-- ---------------------------------------------------------------------------

-- One row per signed-up account. Created automatically by the trigger below.
create table if not exists public.profiles (
  id             uuid primary key references auth.users (id) on delete cascade,
  email          text not null,
  display_name   text not null default 'Little Reader',
  avatar_index   int  not null default 0,
  sound_effects  boolean not null default true,
  night_light    boolean not null default false,
  reading_level  text    not null default 'earlyReader'
                 check (reading_level in ('littleListener', 'earlyReader', 'superReader')),
  created_at     timestamptz not null default now(),
  updated_at     timestamptz not null default now()
);

-- Books a child has added to their library.
create table if not exists public.favorites (
  user_id    uuid not null references auth.users (id) on delete cascade,
  book_id    text not null references public.books (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, book_id)
);

create index if not exists favorites_user_id_idx on public.favorites (user_id);

-- ---------------------------------------------------------------------------
-- 3. Keep profiles.updated_at fresh
-- ---------------------------------------------------------------------------

create or replace function public.touch_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists profiles_touch_updated_at on public.profiles;
create trigger profiles_touch_updated_at
  before update on public.profiles
  for each row execute function public.touch_updated_at();

-- ---------------------------------------------------------------------------
-- 4. Create a profile row automatically whenever someone signs up
--    (reads display_name / avatar_index out of the sign-up metadata)
-- ---------------------------------------------------------------------------

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, email, display_name, avatar_index)
  values (
    new.id,
    coalesce(new.email, ''),
    coalesce(nullif(new.raw_user_meta_data ->> 'display_name', ''), 'Little Reader'),
    coalesce((new.raw_user_meta_data ->> 'avatar_index')::int, 0)
  )
  on conflict (id) do nothing;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Backfill profiles for any accounts that already exist.
insert into public.profiles (id, email, display_name, avatar_index)
select
  u.id,
  coalesce(u.email, ''),
  coalesce(nullif(u.raw_user_meta_data ->> 'display_name', ''), 'Little Reader'),
  coalesce((u.raw_user_meta_data ->> 'avatar_index')::int, 0)
from auth.users u
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- 5. Row Level Security
--    Catalogue: readable by anyone (including anon), writable by nobody
--    from the client. Personal data: only ever the owner's own rows.
-- ---------------------------------------------------------------------------

alter table public.categories enable row level security;
alter table public.books      enable row level security;
alter table public.book_pages enable row level security;
alter table public.profiles   enable row level security;
alter table public.favorites  enable row level security;

drop policy if exists "categories are readable by everyone" on public.categories;
create policy "categories are readable by everyone"
  on public.categories for select
  to anon, authenticated
  using (true);

drop policy if exists "books are readable by everyone" on public.books;
create policy "books are readable by everyone"
  on public.books for select
  to anon, authenticated
  using (true);

drop policy if exists "book pages are readable by everyone" on public.book_pages;
create policy "book pages are readable by everyone"
  on public.book_pages for select
  to anon, authenticated
  using (true);

drop policy if exists "users read their own profile" on public.profiles;
create policy "users read their own profile"
  on public.profiles for select
  to authenticated
  using ((select auth.uid()) = id);

drop policy if exists "users update their own profile" on public.profiles;
create policy "users update their own profile"
  on public.profiles for update
  to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);

drop policy if exists "users insert their own profile" on public.profiles;
create policy "users insert their own profile"
  on public.profiles for insert
  to authenticated
  with check ((select auth.uid()) = id);

drop policy if exists "users read their own favorites" on public.favorites;
create policy "users read their own favorites"
  on public.favorites for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "users add their own favorites" on public.favorites;
create policy "users add their own favorites"
  on public.favorites for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "users remove their own favorites" on public.favorites;
create policy "users remove their own favorites"
  on public.favorites for delete
  to authenticated
  using ((select auth.uid()) = user_id);

-- ---------------------------------------------------------------------------
-- 6. Seed data — the BookaBoo catalogue
-- ---------------------------------------------------------------------------

insert into public.categories (id, name, emoji, color, image_asset, sort_order) values
  ('animals', 'Animals', '🦁', '0xFFFFB443', 'assets/categories/animals.svg', 0),
  ('adventure', 'Adventure', '🗺️', '0xFF22B8A6', 'assets/categories/adventure.svg', 1),
  ('bedtime', 'Bedtime', '🌙', '0xFF5B4BE0', 'assets/categories/bedtime.svg', 2),
  ('fairy', 'Fairy Tales', '🏰', '0xFFFF7A6B', 'assets/categories/fairy.svg', 3),
  ('space', 'Space', '🚀', '0xFF4FB6F5', 'assets/categories/space.svg', 4),
  ('ocean', 'Ocean', '🐳', '0xFF0E86B8', 'assets/categories/ocean.svg', 5)
on conflict (id) do update set
  name = excluded.name,
  emoji = excluded.emoji,
  color = excluded.color,
  image_asset = excluded.image_asset,
  sort_order = excluded.sort_order;

insert into public.books (id, title, author, cover_asset, cover_emoji, cover_color, category_id, age_min, age_max, minutes, rating, description, featured, sort_order) values
  ('b1', 'Leo the Brave Little Lion', 'Maya Whiskers', 'assets/covers/b1.svg', '🦁', '0xFFFFB443', 'animals', 3, 6, 5, 4.8, 'Leo has a big mane but a tiny roar. Join him as he discovers that being brave comes in all sizes!', true, 0),
  ('b2', 'The Sleepy Moon', 'Nina Nightlight', 'assets/covers/b2.svg', '🌙', '0xFF5B4BE0', 'bedtime', 2, 5, 4, 4.9, 'The Moon is so sleepy tonight, but who will light up the sky? A gentle bedtime tale to drift off to.', true, 1),
  ('b3', 'Zara''s Rocket Ride', 'Cosmo Comet', 'assets/covers/b3.svg', '🚀', '0xFF4FB6F5', 'space', 4, 8, 6, 4.7, 'Zara builds a rocket out of cardboard and dreams — and tonight, it actually flies!', true, 2),
  ('b4', 'The Whale Who Sang', 'Finn Splash', 'assets/covers/b4.svg', '🐳', '0xFF0E86B8', 'ocean', 3, 7, 5, 4.6, 'Wally the whale has the loveliest song in the sea, but he is too shy to sing it. Until one special day...', false, 3),
  ('b5', 'Pip the Penguin''s Big Slide', 'Maya Whiskers', 'assets/covers/b5.svg', '🐧', '0xFF4FB6F5', 'animals', 2, 5, 4, 4.5, 'Pip is scared of the big icy slide. But with friends cheering, anything is possible. Wheee!', false, 4),
  ('b6', 'The Dragon Who Loved Pancakes', 'Rosie Tales', 'assets/covers/b6.svg', '🐉', '0xFFFF7A6B', 'fairy', 3, 7, 6, 4.8, 'Darcy the dragon burns every pancake with her fiery sneezes. Can the village kids help her flip the perfect one?', false, 5),
  ('b7', 'Map to the Giggle Tree', 'Sunny Trails', 'assets/covers/b7.svg', '🗺️', '0xFF22B8A6', 'adventure', 4, 8, 7, 4.7, 'X marks the spot where giggles grow! Follow the squiggly map through jungles and rivers to the funniest tree on Earth.', false, 6),
  ('b8', 'Twinkle the Shy Star', 'Nina Nightlight', 'assets/covers/b8.svg', '⭐', '0xFFFFB443', 'bedtime', 2, 5, 4, 4.6, 'Twinkle hides behind clouds because she thinks her light is too small. A cozy tale about shining your own way.', false, 7),
  ('b9', 'The Mermaid''s Lost Comb', 'Finn Splash', 'assets/covers/b9.svg', '🧜‍♀️', '0xFFF472B6', 'ocean', 4, 8, 6, 4.5, 'Marina the mermaid lost her pearly comb in the kelp forest. Good thing the sea is full of helpful friends!', false, 8),
  ('b10', 'Benny Bear Goes to School', 'Maya Whiskers', 'assets/covers/b10.svg', '🐻', '0xFFB08968', 'animals', 3, 6, 5, 4.7, 'It is Benny''s first day of forest school. Butterflies in his tummy — and a new best friend waiting.', false, 9),
  ('b11', 'The Castle of Cupcakes', 'Rosie Tales', 'assets/covers/b11.svg', '🏰', '0xFFF472B6', 'fairy', 3, 7, 6, 4.6, 'A castle with frosting towers and sprinkle bridges? Princess Poppy invites everyone to the sweetest feast ever.', false, 10),
  ('b12', 'Rover on the Red Planet', 'Cosmo Comet', 'assets/covers/b12.svg', '🛸', '0xFFFF8A5B', 'space', 4, 8, 5, 4.4, 'Beep boop! Rover the robot explores Mars and finds something nobody expected: a very red, very bouncy ball.', false, 11)
on conflict (id) do update set
  title = excluded.title,
  author = excluded.author,
  cover_asset = excluded.cover_asset,
  cover_emoji = excluded.cover_emoji,
  cover_color = excluded.cover_color,
  category_id = excluded.category_id,
  age_min = excluded.age_min,
  age_max = excluded.age_max,
  minutes = excluded.minutes,
  rating = excluded.rating,
  description = excluded.description,
  featured = excluded.featured,
  sort_order = excluded.sort_order;

insert into public.book_pages (book_id, page_number, emoji, text) values
  ('b1', 1, '🦁', 'Leo was the littlest lion in the whole savanna.'),
  ('b1', 2, '🎈', 'His roar was so tiny it sounded like a squeaky balloon.'),
  ('b1', 3, '🐘', 'One day, a baby elephant got stuck in the mud and cried for help.'),
  ('b1', 4, '💪', 'Leo pushed and pulled with all his might until — POP! — out came the elephant.'),
  ('b1', 5, '🎉', 'The whole savanna cheered. Leo learned that brave hearts can be any size.'),
  ('b2', 1, '🌙', 'The Moon yawned a great big yawn. "I am so sleepy," she said.'),
  ('b2', 2, '⭐', '"Rest, dear Moon," twinkled the stars. "We will keep watch tonight."'),
  ('b2', 3, '🦉', 'The owls hooted a soft lullaby, hoo hoo, hoo hoo.'),
  ('b2', 4, '☁️', 'A fluffy cloud tucked the Moon in like a cozy blanket.'),
  ('b2', 5, '😴', 'Goodnight, Moon. Goodnight, stars. Goodnight, you.'),
  ('b3', 1, '📦', 'Zara built a rocket from a big cardboard box.'),
  ('b3', 2, '🚀', 'She counted down: three... two... one... BLAST OFF!'),
  ('b3', 3, '🪐', 'She zoomed past Saturn and waved at its sparkly rings.'),
  ('b3', 4, '👽', 'A friendly alien named Bloop shared his moon-cheese sandwich.'),
  ('b3', 5, '🛏️', 'Zara landed right back in her bed, just in time for dreams.'),
  ('b4', 1, '🐳', 'Wally the whale loved to sing — but only when no one was listening.'),
  ('b4', 2, '🐠', 'One day a little fish heard him and shouted, "More! More!"'),
  ('b4', 3, '🦀', 'The crabs clicked their claws like castanets to join in.'),
  ('b4', 4, '🎶', 'Soon the whole ocean was dancing to Wally''s wonderful song.'),
  ('b4', 5, '💙', 'Wally smiled. Sharing your song makes it twice as sweet.'),
  ('b5', 1, '🐧', 'Pip looked up at the big icy slide. It was VERY tall.'),
  ('b5', 2, '😰', '"What if I wobble? What if I tumble?" Pip worried.'),
  ('b5', 3, '📣', 'His friends cheered from below: "You can do it, Pip!"'),
  ('b5', 4, '🛝', 'Pip took a deep breath and... WHEEEEE! Down he zoomed!'),
  ('b5', 5, '🥳', '"Again! Again!" laughed Pip. Trying new things is fun!'),
  ('b6', 1, '🐉', 'Darcy the dragon loved pancakes more than anything.'),
  ('b6', 2, '🔥', 'But every time she cooked — ACHOO! — her sneeze burnt them to a crisp.'),
  ('b6', 3, '🧒', 'The village kids had an idea: "Let US cook, and YOU flip!"'),
  ('b6', 4, '🥞', 'Darcy flipped the pancake so high it did three somersaults!'),
  ('b6', 5, '🍯', 'They all shared a giant pancake feast. Teamwork tastes delicious.'),
  ('b7', 1, '🗺️', 'Milo found a squiggly map under his pillow. "To the Giggle Tree!" it said.'),
  ('b7', 2, '🌴', 'He tiptoed through the tickle-jungle, where the leaves giggled softly.'),
  ('b7', 3, '🛶', 'He paddled across the chuckle-river in a banana boat.'),
  ('b7', 4, '🌳', 'There it was — the Giggle Tree, wobbling with laughter!'),
  ('b7', 5, '😂', 'Milo laughed until his tummy hurt, and took a giggle home for you.'),
  ('b8', 1, '⭐', 'Twinkle was the smallest star in the night sky.'),
  ('b8', 2, '☁️', 'She hid behind a cloud. "My light is too tiny," she sighed.'),
  ('b8', 3, '🐞', 'Down below, a lost ladybug whispered, "I wish I could find my way home."'),
  ('b8', 4, '✨', 'Twinkle peeked out and shone with all her heart — just enough light!'),
  ('b8', 5, '🏡', 'The ladybug found her way home. Even tiny lights are mighty.'),
  ('b9', 1, '🧜‍♀️', 'Marina the mermaid lost her pearly comb. Oh no!'),
  ('b9', 2, '🌿', 'She searched the swishy kelp forest, up and down.'),
  ('b9', 3, '🐙', 'Ollie the octopus helped — eight arms find things fast!'),
  ('b9', 4, '🦞', 'A lobster found it being used as a tiny rake. Oops!'),
  ('b9', 5, '💖', 'Marina combed her hair and gave everyone seaweed high-fives.'),
  ('b10', 1, '🐻', 'Benny Bear held his honey sandwich tight. First day of school!'),
  ('b10', 2, '🦋', 'His tummy felt full of butterflies. Flutter, flutter.'),
  ('b10', 3, '🐰', 'A little rabbit waved. "Want to share my carrot cake?"'),
  ('b10', 4, '🎨', 'They painted, sang, and built a leaf fort together.'),
  ('b10', 5, '🌟', 'Benny skipped home. "School is my new favorite adventure!"'),
  ('b11', 1, '🏰', 'Princess Poppy lived in a castle made of cupcakes.'),
  ('b11', 2, '🌧️', 'One rainy day, the frosting towers began to slide!'),
  ('b11', 3, '🐿️', 'Poppy called every squirrel, mouse and bird to help.'),
  ('b11', 4, '🍓', 'They patched the walls with strawberries and sprinkles.'),
  ('b11', 5, '🧁', 'Then they ate the leftovers, of course. Best. Feast. Ever.'),
  ('b12', 1, '🤖', 'Rover the robot rolled across the red sands of Mars.'),
  ('b12', 2, '🔴', 'Beep! His scanner found something round and bouncy.'),
  ('b12', 3, '⛰️', 'He followed it bouncing over craters and dusty hills.'),
  ('b12', 4, '🛸', 'It bounced right into a tiny spaceship — it was a spaceball!'),
  ('b12', 5, '🏓', 'Rover and the aliens played catch until the stars came out.')
on conflict (book_id, page_number) do update set
  emoji = excluded.emoji,
  text = excluded.text;



-- ---------------------------------------------------------------------------
-- 7. Optional: the demo account the sign-in screen pre-fills
--    (hello@bookaboo.app / bookaboo). Delete this section if you would rather
--    everyone sign up for themselves.
-- ---------------------------------------------------------------------------

create extension if not exists pgcrypto with schema extensions;

do $$
declare
  demo_id uuid;
begin
  select id into demo_id from auth.users where email = 'hello@bookaboo.app';

  if demo_id is null then
    demo_id := gen_random_uuid();

    insert into auth.users (
      id, instance_id, aud, role, email, encrypted_password,
      email_confirmed_at, raw_app_meta_data, raw_user_meta_data,
      created_at, updated_at
    ) values (
      demo_id,
      '00000000-0000-0000-0000-000000000000',
      'authenticated',
      'authenticated',
      'hello@bookaboo.app',
      extensions.crypt('bookaboo', extensions.gen_salt('bf')),
      now(),
      '{"provider":"email","providers":["email"]}'::jsonb,
      '{"display_name":"Sam","avatar_index":0}'::jsonb,
      now(),
      now()
    );

    -- GoTrue expects a matching identity row for the email provider.
    insert into auth.identities (
      id, user_id, provider, provider_id, identity_data,
      last_sign_in_at, created_at, updated_at
    ) values (
      gen_random_uuid(),
      demo_id,
      'email',
      demo_id::text,
      jsonb_build_object(
        'sub', demo_id::text,
        'email', 'hello@bookaboo.app',
        'email_verified', true
      ),
      now(),
      now(),
      now()
    );
  end if;

  -- The trigger above creates the profile row; give Sam two starter books.
  insert into public.favorites (user_id, book_id)
  values (demo_id, 'b2'), (demo_id, 'b6')
  on conflict do nothing;
end
$$;
