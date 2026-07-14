CREATE TABLE IF NOT EXISTS badasscouncil.messages
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    room_id integer NOT NULL,
    message_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id integer NOT NULL,
    dest_id integer,
    content character varying(4000) COLLATE pg_catalog."default",
    CONSTRAINT fk_room_id_messages FOREIGN KEY(room_id) REFERENCES badasscouncil.rooms(room_id),
    CONSTRAINT fk_user_id_messages FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id),
    CONSTRAINT fk_dest_id_messages FOREIGN KEY(dest_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.messages OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_messages_room_id ON badasscouncil.messages USING btree (room_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_messages_user_id ON badasscouncil.messages USING btree (user_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_messages_dest_id ON badasscouncil.messages USING btree (dest_id) TABLESPACE badasscouncil;
