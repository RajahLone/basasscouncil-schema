CREATE TABLE IF NOT EXISTS badasscouncil.images
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    image_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enabled boolean DEFAULT true,

    message_id integer NOT NULL,
    user_id integer NOT NULL, -- owner
    ip_address inet NOT NULL,
    dest_id integer,

    file_name character varying(1024) COLLATE pg_catalog."default",
    thumbnail bytea,
    data bytea,
    
    CONSTRAINT fk_message_id_id_images FOREIGN KEY(message_id) REFERENCES badasscouncil.messages(message_id),
    CONSTRAINT fk_user_id_images FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id),
    CONSTRAINT fk_dest_id_images FOREIGN KEY(dest_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.images OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_images_message_id ON badasscouncil.images USING btree (message_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_images_user_id ON badasscouncil.images USING btree (user_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_images_dest_id ON badasscouncil.images USING btree (dest_id) TABLESPACE badasscouncil;
