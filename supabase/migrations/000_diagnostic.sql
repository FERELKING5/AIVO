-- ============================================
-- DIAGNOSTIC: Vérifier que les tables existent
-- ============================================
-- Copie/colle ce SQL dans Supabase SQL Editor et exécute-le

-- 1. Vérifier TOUTES les tables créées
SELECT
  table_name,
  table_schema
FROM information_schema.tables
WHERE table_schema = 'public'
ORDER BY table_name;

-- 2. Vérifier les colonnes de 'products' si elle existe
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'products'
ORDER BY ordinal_position;

-- 3. Vérifier si 'trending_products' existe
SELECT EXISTS (
  SELECT FROM information_schema.tables
  WHERE table_schema = 'public'
  AND table_name = 'trending_products'
) as "trending_products_exists";

-- 4. Vérifier touts les indexes
SELECT indexname, tablename
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;
