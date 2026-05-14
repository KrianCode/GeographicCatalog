-- Create user rebasedata (referenced in init.sql as table owner)
DO
$$
BEGIN
  IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'rebasedata') THEN
    CREATE ROLE rebasedata WITH LOGIN PASSWORD 'rebasedata';
  END IF;
END
$$;
GRANT ALL PRIVILEGES ON DATABASE geographiccatalog TO rebasedata;
