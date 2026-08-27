CREATE TABLE IF NOT EXISTS badasscouncil.preferences
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    preference_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id integer NOT NULL,
    action_id integer NOT NULL,
    parameters character varying(4000) COLLATE pg_catalog."default",
    CONSTRAINT fk_user_id_preferences FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.preferences OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_preferences_user_id ON badasscouncil.preferences USING btree (user_id) TABLESPACE badasscouncil;
