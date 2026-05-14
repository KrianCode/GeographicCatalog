-- Rename _dbo_kn_* tables to kn_* so the app can use short names
ALTER TABLE IF EXISTS public._dbo_kn_atedrnamebel RENAME TO kn_atedrnamebel;
ALTER TABLE IF EXISTS public._dbo_kn_atedrnamerus RENAME TO kn_atedrnamerus;
ALTER TABLE IF EXISTS public._dbo_kn_atevalue RENAME TO kn_atevalue;
ALTER TABLE IF EXISTS public._dbo_kn_category RENAME TO kn_category;
ALTER TABLE IF EXISTS public._dbo_kn_dbair RENAME TO kn_dbair;
ALTER TABLE IF EXISTS public._dbo_kn_dbate RENAME TO kn_dbate;
ALTER TABLE IF EXISTS public._dbo_kn_dbfgo RENAME TO kn_dbfgo;
ALTER TABLE IF EXISTS public._dbo_kn_dbfgo_nomenklat RENAME TO kn_dbfgo_nomenklat;
ALTER TABLE IF EXISTS public._dbo_kn_dbfgo_obl_ra RENAME TO kn_dbfgo_obl_ra;
ALTER TABLE IF EXISTS public._dbo_kn_dbrw RENAME TO kn_dbrw;
ALTER TABLE IF EXISTS public._dbo_kn_fgodrtnamebel RENAME TO kn_fgodrtnamebel;
ALTER TABLE IF EXISTS public._dbo_kn_fgodrtnamerus RENAME TO kn_fgodrtnamerus;
ALTER TABLE IF EXISTS public._dbo_kn_hchangeair RENAME TO kn_hchangeair;
ALTER TABLE IF EXISTS public._dbo_kn_hchangeate RENAME TO kn_hchangeate;
ALTER TABLE IF EXISTS public._dbo_kn_hchangefgo RENAME TO kn_hchangefgo;
ALTER TABLE IF EXISTS public._dbo_kn_hchangerw RENAME TO kn_hchangerw;
ALTER TABLE IF EXISTS public._dbo_kn_hpopular RENAME TO kn_hpopular;
ALTER TABLE IF EXISTS public._dbo_kn_nod RENAME TO kn_nod;
ALTER TABLE IF EXISTS public._dbo_kn_obl RENAME TO kn_obl;
ALTER TABLE IF EXISTS public._dbo_kn_ra RENAME TO kn_ra;
ALTER TABLE IF EXISTS public._dbo_kn_rodate RENAME TO kn_rodate;
ALTER TABLE IF EXISTS public._dbo_kn_rodfgo RENAME TO kn_rodfgo;
ALTER TABLE IF EXISTS public._dbo_kn_sinfo RENAME TO kn_sinfo;

-- Grant usage for app (postgres user already has access)
GRANT USAGE ON SCHEMA public TO rebasedata;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO rebasedata;
