CREATE TABLE IF NOT EXISTS badasscouncil.quotes
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    quote_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    content character varying(4000) COLLATE pg_catalog."default" NOT NULL
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.quotes OWNER to badasscouncil;

CREATE FUNCTION badasscouncil.quoteUpdated() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_on = now();
  return NEW;
END;
$$ LANGUAGE 'plpgsql';
ALTER FUNCTION badasscouncil.quoteUpdated() OWNER TO badasscouncil;

CREATE OR REPLACE TRIGGER quoteUpdated BEFORE UPDATE ON badasscouncil.quotes FOR EACH ROW EXECUTE FUNCTION badasscouncil.quoteUpdated();
