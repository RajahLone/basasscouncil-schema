CREATE TABLE IF NOT EXISTS badasscouncil.quotes
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    quote_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    content character varying(4000) COLLATE pg_catalog."default" NOT NULL
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.quotes OWNER to badasscouncil;
