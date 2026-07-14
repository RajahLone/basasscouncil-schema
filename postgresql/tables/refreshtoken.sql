CREATE TABLE IF NOT EXISTS badasscouncil.refreshtoken
(
    id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id integer NOT NULL,
    token character varying(4000) NOT NULL COLLATE pg_catalog."default",
    expiry_date timestamp without time zone NOT NULL,
    CONSTRAINT fk_user_id_refreshtoken FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.refreshtoken OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_refreshtoken_user_id ON badasscouncil.refreshtoken USING btree (user_id) TABLESPACE badasscouncil;
