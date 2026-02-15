-- ============================================
-- RECOMMENDATION ENGINE - 100% SQL RPC FUNCTIONS
-- (No TypeScript Edge Functions needed)
-- ============================================

-- RPC Function: Get home recommendations
CREATE OR REPLACE FUNCTION get_home_recommendations(
  p_user_id uuid DEFAULT NULL,
  p_country text DEFAULT 'US',
  p_city text DEFAULT NULL,
  p_limit int DEFAULT 20
)
RETURNS TABLE (
  section text,
  product_id uuid,
  title text,
  brand text,
  price numeric,
  image_url text,
  score numeric,
  reason text
) AS $$
BEGIN
  -- Get trending products
  RETURN QUERY
  SELECT
    'trending'::text as section,
    tp.product_id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    tp.score,
    'Trending now'::text as reason
  FROM trending_products tp
  JOIN products p ON p.id = tp.product_id
  WHERE tp.country = p_country
    AND (p_city IS NULL OR tp.city = p_city)
    AND p.active = true
    AND p.stock > 0
  ORDER BY tp.score DESC
  LIMIT p_limit;

  -- Get new arrivals
  RETURN QUERY
  SELECT
    'new_arrivals'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.85::numeric as score,
    'Just arrived'::text as reason
  FROM products p
  WHERE p.active = true
    AND p.stock > 0
    AND p.created_at > now() - interval '30 days'
  ORDER BY p.created_at DESC
  LIMIT p_limit;

  -- Get for_you (if user exists)
  IF p_user_id IS NOT NULL THEN
    RETURN QUERY
    SELECT
      'for_you'::text as section,
      p.id,
      p.title,
      p.brand,
      p.price,
      p.image_url,
      0.80::numeric as score,
      'Personalized for you'::text as reason
    FROM products p
    WHERE p.active = true
      AND p.stock > 0
    ORDER BY p.created_at DESC
    LIMIT p_limit;
  END IF;

  -- Get explore (random)
  RETURN QUERY
  SELECT
    'explore'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.60::numeric as score,
    'Explore'::text as reason
  FROM products p
  WHERE p.active = true
    AND p.stock > 0
  ORDER BY random()
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Get product recommendations
CREATE OR REPLACE FUNCTION get_product_recommendations(
  p_product_id uuid,
  p_user_id uuid DEFAULT NULL,
  p_country text DEFAULT 'US',
  p_limit int DEFAULT 20
)
RETURNS TABLE (
  section text,
  product_id uuid,
  title text,
  brand text,
  price numeric,
  image_url text,
  score numeric,
  reason text
) AS $$
DECLARE
  v_category_id uuid;
BEGIN
  -- Get source product category
  SELECT category_id INTO v_category_id FROM products WHERE id = p_product_id;

  -- Similar products
  RETURN QUERY
  SELECT
    'similar'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.80::numeric as score,
    'Similar product'::text as reason
  FROM products p
  WHERE p.category_id = v_category_id
    AND p.id != p_product_id
    AND p.active = true
    AND p.stock > 0
  ORDER BY p.created_at DESC
  LIMIT p_limit;

  -- Accessories (via affinities)
  RETURN QUERY
  SELECT
    'accessories'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.90::numeric as score,
    'Perfect accessory'::text as reason
  FROM product_affinities pa
  JOIN products p ON p.id = pa.target_product_id
  WHERE pa.source_product_id = p_product_id
    AND pa.reason = 'accessory'
    AND pa.active = true
    AND p.active = true
    AND p.stock > 0
  ORDER BY pa.strength DESC
  LIMIT p_limit;

  -- Trending in category
  RETURN QUERY
  SELECT
    'trending_in_category'::text as section,
    tp.product_id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    tp.score,
    'Trending in category'::text as reason
  FROM trending_products tp
  JOIN products p ON p.id = tp.product_id
  WHERE tp.category_id = v_category_id
    AND tp.country = p_country
    AND tp.product_id != p_product_id
    AND p.active = true
    AND p.stock > 0
  ORDER BY tp.score DESC
  LIMIT p_limit;

  -- Explore
  RETURN QUERY
  SELECT
    'explore'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.60::numeric as score,
    'Explore'::text as reason
  FROM products p
  WHERE p.category_id != v_category_id
    AND p.id != p_product_id
    AND p.active = true
    AND p.stock > 0
  ORDER BY random()
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Get cart recommendations
CREATE OR REPLACE FUNCTION get_cart_recommendations(
  p_user_id uuid DEFAULT NULL,
  p_country text DEFAULT 'US',
  p_limit int DEFAULT 20
)
RETURNS TABLE (
  section text,
  product_id uuid,
  title text,
  brand text,
  price numeric,
  image_url text,
  score numeric,
  reason text
) AS $$
DECLARE
  v_budget_median numeric;
BEGIN
  -- Get user budget
  SELECT budget_median INTO v_budget_median
  FROM user_profiles
  WHERE user_id = p_user_id;

  -- Budget alternatives (cheap)
  IF v_budget_median IS NOT NULL THEN
    RETURN QUERY
    SELECT
      'alternatives_budget'::text as section,
      p.id,
      p.title,
      p.brand,
      p.price,
      p.image_url,
      0.70::numeric as score,
      'Budget option'::text as reason
    FROM products p
    WHERE p.price BETWEEN v_budget_median * 0.5 AND v_budget_median * 0.7
      AND p.active = true
      AND p.stock > 0
    ORDER BY p.created_at DESC
    LIMIT p_limit;

    -- Premium alternatives (upsell)
    RETURN QUERY
    SELECT
      'alternatives_premium'::text as section,
      p.id,
      p.title,
      p.brand,
      p.price,
      p.image_url,
      0.75::numeric as score,
      'Premium upgrade'::text as reason
    FROM products p
    WHERE p.price > v_budget_median * 1.3
      AND p.active = true
      AND p.stock > 0
    ORDER BY p.created_at DESC
    LIMIT p_limit;
  END IF;

  -- Complete your cart (popular)
  RETURN QUERY
  SELECT
    'complete_your_cart'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.80::numeric as score,
    'Complete order'::text as reason
  FROM products p
  WHERE p.active = true
    AND p.stock > 0
  ORDER BY p.created_at DESC
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Search recommendations
CREATE OR REPLACE FUNCTION search_recommendations(
  p_query text DEFAULT '',
  p_user_id uuid DEFAULT NULL,
  p_limit int DEFAULT 20
)
RETURNS TABLE (
  section text,
  product_id uuid,
  title text,
  brand text,
  price numeric,
  image_url text,
  score numeric,
  reason text
) AS $$
BEGIN
  IF p_query = '' OR p_query IS NULL THEN
    RETURN;
  END IF;

  -- Best match (title search)
  RETURN QUERY
  SELECT
    'best_match'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.90::numeric as score,
    ('Matches "' || p_query || '"')::text as reason
  FROM products p
  WHERE p.title ILIKE '%' || p_query || '%'
    AND p.active = true
    AND p.stock > 0
  ORDER BY p.created_at DESC
  LIMIT p_limit;

  -- Explore related
  RETURN QUERY
  SELECT
    'explore'::text as section,
    p.id,
    p.title,
    p.brand,
    p.price,
    p.image_url,
    0.60::numeric as score,
    'Related to search'::text as reason
  FROM products p
  WHERE p.active = true
    AND p.stock > 0
  ORDER BY random()
  LIMIT p_limit;
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Record event
CREATE OR REPLACE FUNCTION record_event(
  p_user_id uuid DEFAULT NULL,
  p_session_id text DEFAULT NULL,
  p_event_type text DEFAULT 'view',
  p_product_id uuid DEFAULT NULL,
  p_query text DEFAULT NULL,
  p_dwell_ms int DEFAULT 0,
  p_country text DEFAULT 'US',
  p_city text DEFAULT NULL
)
RETURNS void AS $$
BEGIN
  IF p_event_type IS NULL OR p_event_type = '' THEN
    RETURN;
  END IF;

  INSERT INTO events (
    user_id,
    session_id,
    event_type,
    product_id,
    query,
    dwell_ms,
    meta
  ) VALUES (
    p_user_id,
    p_session_id,
    p_event_type,
    p_product_id,
    p_query,
    p_dwell_ms,
    jsonb_build_object(
      'country', p_country,
      'city', p_city,
      'device', 'mobile',
      'app_version', '1.0.0'
    )
  );
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Get trending (for batch job)
CREATE OR REPLACE FUNCTION calculate_trending_scores(p_days int DEFAULT 30)
RETURNS TABLE (
  country text,
  city text,
  category_id uuid,
  product_id uuid,
  score numeric,
  updated_at timestamptz
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    (e.meta->>'country')::text,
    (e.meta->>'city')::text,
    p.category_id,
    e.product_id,
    SUM(
      (
        CASE
          WHEN e.event_type = 'purchase' THEN 10
          WHEN e.event_type = 'wishlist' THEN 3
          WHEN e.event_type = 'add_to_cart' THEN 4
          WHEN e.event_type = 'dwell' THEN COALESCE(e.dwell_ms, 0)::numeric / 500
          WHEN e.event_type = 'view' THEN 1
          ELSE 0
        END
      ) * exp(-extract(epoch from (now() - e.ts)) / (p_days * 86400))
    )::numeric as decay_score,
    now()::timestamptz
  FROM events e
  JOIN products p ON p.id = e.product_id
  WHERE e.ts > now() - (p_days || ' days')::interval
    AND e.product_id IS NOT NULL
  GROUP BY
    e.meta->>'country',
    e.meta->>'city',
    p.category_id,
    e.product_id;
END;
$$ LANGUAGE plpgsql;

-- RPC Function: Update user profile
CREATE OR REPLACE FUNCTION update_user_profile(p_user_id uuid DEFAULT NULL)
RETURNS void AS $$
BEGIN
  IF p_user_id IS NULL THEN
    RETURN;
  END IF;

  -- Get budget from purchases
  WITH user_orders AS (
    SELECT price_at_purchase
    FROM order_items oi
    JOIN orders o ON o.id = oi.order_id
    WHERE o.user_id = p_user_id AND o.status = 'completed'
  )
  INSERT INTO user_profiles (
    user_id,
    budget_median,
    budget_p95,
    updated_at
  ) SELECT
    p_user_id,
    percentile_cont(0.5) WITHIN GROUP (ORDER BY price_at_purchase),
    percentile_cont(0.95) WITHIN GROUP (ORDER BY price_at_purchase),
    now()
  FROM user_orders
  ON CONFLICT (user_id) DO UPDATE SET
    budget_median = EXCLUDED.budget_median,
    budget_p95 = EXCLUDED.budget_p95,
    updated_at = now();
END;
$$ LANGUAGE plpgsql;

-- Indexes for RPC performance
-- Check if 'active' column exists before creating indexes
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='products' AND column_name='active') THEN
    CREATE INDEX IF NOT EXISTS idx_products_category_active_stock ON products(category_id, active, stock) WHERE active = true AND stock > 0;
    CREATE INDEX IF NOT EXISTS idx_products_title_active ON products(title, active) WHERE active = true;
  END IF;

  IF EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name='product_affinities' AND column_name='active') THEN
    CREATE INDEX IF NOT EXISTS idx_affinity_source_reason ON product_affinities(source_product_id, reason, active) WHERE active = true;
  END IF;
END
$$;

CREATE INDEX IF NOT EXISTS idx_trending_products_country_score ON trending_products(country, score DESC);
CREATE INDEX IF NOT EXISTS idx_trending_products_country_city_score ON trending_products(country, city, score DESC);
CREATE INDEX IF NOT EXISTS idx_events_product_ts ON events(product_id, ts DESC) WHERE product_id IS NOT NULL;
