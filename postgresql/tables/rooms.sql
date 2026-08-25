CREATE TYPE badasscouncil.room_state AS ENUM('ACTIVE', 'LOCKED', 'TRASHED');
CREATE TYPE badasscouncil.room_purge_type AS ENUM('NEVER', 'MESSAGES_LIMITED', 'TIME_LIMITED');

CREATE CAST (varchar AS badasscouncil.room_state) WITH INOUT AS IMPLICIT;
CREATE CAST (varchar AS badasscouncil.room_purge_type) WITH INOUT AS IMPLICIT;

CREATE TABLE IF NOT EXISTS badasscouncil.rooms
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    room_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id integer NOT NULL, -- owner
    enabled boolean DEFAULT true,
    
    state badasscouncil.room_state DEFAULT 'ACTIVE',

    name character varying(128) COLLATE pg_catalog."default" NOT NULL DEFAULT '',
    
    password_hash character varying(256) COLLATE pg_catalog."default" DEFAULT NULL, -- in case owner wants to restrict access
    
    topic character varying(512) COLLATE pg_catalog."default" DEFAULT '',

    notes character varying(4000) COLLATE pg_catalog."default" DEFAULT '',

    purge_type badasscouncil.room_purge_type DEFAULT 'NEVER', -- messages purge type  
    messages_limit integer DEFAULT 1000,  -- number of remaining messages
    time_duration integer DEFAULT 1440,   -- minutes living before deleting old messages

    CONSTRAINT fk_user_id_users FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.rooms OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_rooms_user_id ON badasscouncil.rooms USING btree (user_id) TABLESPACE badasscouncil;

CREATE FUNCTION badasscouncil.roomUpdated() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_on = now();
  return NEW;
END;
$$ LANGUAGE 'plpgsql';
ALTER FUNCTION badasscouncil.roomUpdated() OWNER TO badasscouncil;

CREATE OR REPLACE TRIGGER roomUpdated BEFORE UPDATE ON badasscouncil.rooms FOR EACH ROW EXECUTE FUNCTION badasscouncil.roomUpdated();
