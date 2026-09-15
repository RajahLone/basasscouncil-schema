CREATE TABLE IF NOT EXISTS badasscouncil.images
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    image_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enabled boolean DEFAULT true,

    user_id integer NOT NULL, -- owner
    ip_address inet NOT NULL,

    thumbnail bytea,
    data bytea,
    
    CONSTRAINT fk_user_id_attachments FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE vote;
ALTER TABLE IF EXISTS vote.productions OWNER to vote;

CREATE INDEX IF NOT EXISTS ix_images_user_id ON badasscouncil.images USING btree (user_id) TABLESPACE badasscouncil;
