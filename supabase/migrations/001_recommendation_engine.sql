-- ============================================
-- Recommendation Engine Schema
-- ============================================

-- 1. CATEGORIES (if not exists)
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL UNIQUE,
  description text,
  image_url text,
  created_at timestamptz DEFAULT now()
);

-- 2. PRODUCTS
CREATE TABLE IF NOT EXISTS products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  title text NOT NULL,
  description text,
  category_id uuid REFERENCES categories(id) ON DELETE SET NULL,
  tags text[] DEFAULT '{}',
  brand text,
  price numeric NOT NULL CHECK (price >= 0),
  currency text DEFAULT 'USD',
  stock int DEFAULT 0 CHECK (stock >= 0),
  active boolean DEFAULT true,
  image_url text,
  region_available text[] DEFAULT '{}',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Add active column if it doesn't exist (for existing tables)
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='products' AND column_name='active') THEN
    ALTER TABLE products ADD COLUMN active boolean DEFAULT true;
  END IF;
END
$$;

CREATE INDEX IF NOT EXISTS idx_products_category_id ON products(category_id);
CREATE INDEX IF NOT EXISTS idx_products_active_stock ON products(active, stock) WHERE active = true AND stock > 0;
CREATE INDEX IF NOT EXISTS idx_products_created_at ON products(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_products_brand ON products(brand);
CREATE INDEX IF NOT EXISTS idx_products_tags ON products USING GIN(tags);

-- 3. EVENTS (core tracking)
CREATE TABLE IF NOT EXISTS events (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid,
  session_id text,
  event_type text NOT NULL,
  product_id uuid REFERENCES products(id) ON DELETE SET NULL,
  category_id uuid REFERENCES categories(id) ON DELETE SET NULL,
  query text,
  dwell_ms int DEFAULT 0,
  ts timestamptz DEFAULT now(),
  meta jsonb DEFAULT '{}',
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_events_user_id_ts ON events(user_id, ts DESC) WHERE user_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_events_product_id_ts ON events(product_id, ts DESC) WHERE product_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_events_event_type_ts ON events(event_type, ts DESC);
CREATE INDEX IF NOT EXISTS idx_events_session_id_ts ON events(session_id, ts DESC) WHERE session_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_events_ts ON events(ts DESC);

-- 4. ORDERS & ORDER_ITEMS (for co-occurrence and budget tracking)
CREATE TABLE IF NOT EXISTS orders (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid,
  total numeric NOT NULL,
  currency text DEFAULT 'USD',
  status text DEFAULT 'completed',
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_orders_user_id_created_at ON orders(user_id, created_at DESC) WHERE user_id IS NOT NULL;

CREATE TABLE IF NOT EXISTS order_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  order_id uuid NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  quantity int DEFAULT 1,
  price_at_purchase numeric NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_order_items_product_id ON order_items(product_id);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);

-- 5. USER_PROFILES (materialized, updated by batch job)
CREATE TABLE IF NOT EXISTS user_profiles (
  user_id uuid PRIMARY KEY,
  country text,
  city text,
  budget_median numeric,
  budget_p95 numeric,
  top_categories jsonb DEFAULT '[]'::jsonb,
  top_tags jsonb DEFAULT '[]'::jsonb,
  top_brands jsonb DEFAULT '[]'::jsonb,
  total_purchases int DEFAULT 0,
  updated_at timestamptz DEFAULT now()
);

-- 6. PRODUCT_AFFINITIES (manual + extensible)
CREATE TABLE IF NOT EXISTS product_affinities (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  source_product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  target_product_id uuid REFERENCES products(id) ON DELETE SET NULL,
  target_category_id uuid REFERENCES categories(id) ON DELETE SET NULL,
  target_tag text,
  reason text,
  strength int DEFAULT 5 CHECK (strength >= 1 AND strength <= 10),
  min_delay_days int DEFAULT 0,
  active boolean DEFAULT true,
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_product_affinities_source ON product_affinities(source_product_id, active);
CREATE INDEX IF NOT EXISTS idx_product_affinities_target_product ON product_affinities(target_product_id);
CREATE INDEX IF NOT EXISTS idx_product_affinities_reason ON product_affinities(reason);

-- 7. PRODUCT_PAIRS (co-occurrence batch)
CREATE TABLE IF NOT EXISTS product_pairs (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  paired_product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  pair_count int DEFAULT 1,
  score numeric DEFAULT 0,
  updated_at timestamptz DEFAULT now(),
  UNIQUE(product_id, paired_product_id)
);

CREATE INDEX IF NOT EXISTS idx_product_pairs_product_id ON product_pairs(product_id, score DESC);
CREATE INDEX IF NOT EXISTS idx_product_pairs_updated_at ON product_pairs(updated_at DESC);

-- 8. TRENDING_PRODUCTS (per zone + category)
CREATE TABLE IF NOT EXISTS trending_products (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  country text NOT NULL,
  city text,
  category_id uuid REFERENCES categories(id) ON DELETE SET NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  score numeric NOT NULL,
  updated_at timestamptz DEFAULT now(),
  UNIQUE(country, city, category_id, product_id)
);

CREATE INDEX IF NOT EXISTS idx_trending_products_country_dt ON trending_products(country, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_trending_products_country_city_dt ON trending_products(country, city, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_trending_products_category ON trending_products(category_id) WHERE category_id IS NOT NULL;

-- 9. USER_RECENT_RECOMMENDATIONS (cache for diversity)
CREATE TABLE IF NOT EXISTS user_recent_recommendations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  context text,
  recommended_at timestamptz DEFAULT now(),
  created_at timestamptz DEFAULT now()
);

CREATE INDEX IF NOT EXISTS idx_user_recent_recos_user_id_ts ON user_recent_recommendations(user_id, recommended_at DESC);

-- 10. WISHLISTS (optional but useful)
CREATE TABLE IF NOT EXISTS wishlists (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL,
  product_id uuid NOT NULL REFERENCES products(id) ON DELETE CASCADE,
  added_at timestamptz DEFAULT now(),
  UNIQUE(user_id, product_id)
);

CREATE INDEX IF NOT EXISTS idx_wishlists_user_id ON wishlists(user_id);
