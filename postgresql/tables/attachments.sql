
CREATE TABLE IF NOT EXISTS badasscouncil.attachments
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    file_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enabled boolean DEFAULT true,
    
    user_id integer NOT NULL, -- owner
    ip_address inet NOT NULL,
    
    comments_public text,
    comments_private text,
    
    archive_name character varying(1024) COLLATE pg_catalog."default",
    local_name character varying(1024) COLLATE pg_catalog."default",
    version_number integer DEFAULT 1,

    dest_id integer, -- pending owner
    shared boolean DEFAULT false,
    life_span integer DEFAULT 0, -- days before purged, if 0 then infinite

    CONSTRAINT fk_user_id_attachments FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id),
    CONSTRAINT fk_dest_id_attachments FOREIGN KEY(dest_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.attachments OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_attachments_user_id ON badasscouncil.attachments USING btree (user_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_attachments_dest_id ON badasscouncil.attachments USING btree (dest_id) TABLESPACE badasscouncil;

CREATE FUNCTION badasscouncil.attachmentUpdated() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_on = now();
  return NEW;
END;
$$ LANGUAGE 'plpgsql';
ALTER FUNCTION badasscouncil.attachmentUpdated() OWNER TO badasscouncil;

CREATE OR REPLACE TRIGGER attachmentUpdated BEFORE UPDATE ON badasscouncil.attachments FOR EACH ROW EXECUTE FUNCTION badasscouncil.attachmentUpdated();
