-- Rename all mixed-case columns to lowercase so unquoted identifiers in app work
DO $$
DECLARE
  rec RECORD;
BEGIN
  FOR rec IN
    SELECT c.relname AS tablename, a.attname AS columnname
    FROM pg_attribute a
    JOIN pg_class c ON a.attrelid = c.oid
    JOIN pg_namespace n ON c.relnamespace = n.oid
    WHERE n.nspname = 'public'
      AND c.relkind = 'r'
      AND c.relname LIKE 'kn_%'
      AND a.attnum > 0
      AND NOT a.attisdropped
      AND a.attname != lower(a.attname)
  LOOP
    EXECUTE format('ALTER TABLE %I RENAME COLUMN %I TO %I',
      rec.tablename, rec.columnname, lower(rec.columnname));
  END LOOP;
END $$;
