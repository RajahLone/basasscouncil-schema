CREATE TABLE IF NOT EXISTS badasscouncil.variables
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    var_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    family character varying(64) COLLATE pg_catalog."default" NOT NULL,
    code character varying(64) COLLATE pg_catalog."default" NOT NULL,
    content character varying(4000) COLLATE pg_catalog."default" NOT NULL,
    notes character varying(4000) COLLATE pg_catalog."default"
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.variables OWNER to badasscouncil;
