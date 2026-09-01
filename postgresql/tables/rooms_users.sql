CREATE TABLE IF NOT EXISTS badasscouncil.rooms_allowed_users
(
    room_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT fk_room_id_rooms FOREIGN KEY(room_id) REFERENCES badasscouncil.rooms(room_id),
    CONSTRAINT fk_user_id_users FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.rooms_allowed_users OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_rooms_allowed_rooms_users ON badasscouncil.rooms_allowed_users USING btree (room_id, user_id) TABLESPACE badasscouncil;


CREATE TABLE IF NOT EXISTS badasscouncil.rooms_disallowed_users
(
    room_id integer NOT NULL,
    user_id integer NOT NULL,
    CONSTRAINT fk_room_id_rooms FOREIGN KEY(room_id) REFERENCES badasscouncil.rooms(room_id),
    CONSTRAINT fk_user_id_users FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.rooms_disallowed_users OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_rooms_disallowed_rooms_users ON badasscouncil.rooms_disallowed_users USING btree (room_id, user_id) TABLESPACE badasscouncil;
