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
