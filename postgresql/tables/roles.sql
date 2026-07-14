CREATE TABLE IF NOT EXISTS badasscouncil.roles
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    role_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enabled boolean DEFAULT true,
    label character varying(64) COLLATE pg_catalog."default" NOT NULL
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.roles OWNER to badasscouncil;

CREATE FUNCTION badasscouncil.roleUpdated() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_on = now();
  return NEW;
END;
$$ LANGUAGE 'plpgsql';
ALTER FUNCTION badasscouncil.roleUpdated() OWNER TO badasscouncil;

CREATE OR REPLACE TRIGGER roleUpdated BEFORE UPDATE ON badasscouncil.roles FOR EACH ROW EXECUTE FUNCTION badasscouncil.roleUpdated();
