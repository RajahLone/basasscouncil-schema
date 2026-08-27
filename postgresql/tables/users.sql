CREATE TYPE badasscouncil.user_status AS ENUM('ACTIVE', 'PENDING', 'LOCKED', 'BANNED', 'SLEEPING');

CREATE CAST (varchar AS badasscouncil.user_status) WITH INOUT AS IMPLICIT;

CREATE TABLE IF NOT EXISTS badasscouncil.users
(
    created_on timestamp without time zone NOT NULL DEFAULT now(),
    updated_on timestamp without time zone,
    user_id integer NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enabled boolean DEFAULT true,
    
    status badasscouncil.user_status DEFAULT 'LOCKED',
    login_name character varying(128) COLLATE pg_catalog."default" NOT NULL DEFAULT '',
    password_hash character varying(256) COLLATE pg_catalog."default" NOT NULL DEFAULT '',
    password_expired boolean DEFAULT false,
    expired_on timestamp without time zone DEFAULT NULL,
    last_activity_on timestamp without time zone DEFAULT NULL,
    session_timeout integer NOT NULL DEFAULT 15,
    
    subscribe_motive character varying(512) COLLATE pg_catalog."default" NOT NULL DEFAULT '',
    
    nick_name character varying(128) COLLATE pg_catalog."default" NOT NULL DEFAULT '',
    group_name character varying(128) COLLATE pg_catalog."default" DEFAULT '',
    first_name character varying(128) COLLATE pg_catalog."default" DEFAULT '',
    last_name character varying(128) COLLATE pg_catalog."default" DEFAULT '',

    display_contact_details boolean DEFAULT false,
    address character varying(256) COLLATE pg_catalog."default" DEFAULT '',
    zip_code character varying(16) COLLATE pg_catalog."default" DEFAULT '',
    town character varying(128) COLLATE pg_catalog."default" DEFAULT '',
    country character varying(128) COLLATE pg_catalog."default" DEFAULT '',
    phone character varying(32) COLLATE pg_catalog."default" DEFAULT '',
    email character varying(128) COLLATE pg_catalog."default" DEFAULT '',
    
    storage_limit integer DEFAULT 0 -- size limit for files storage. -1 = not allowed to upload, 0 = limited only by Quota FILES_PER_MEMBER * (MAX_)FILE_SIZE, > 0 = limit in GB
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.users OWNER to badasscouncil;

CREATE UNIQUE INDEX IF NOT EXISTS ix_users_login_name ON badasscouncil.users USING btree (login_name) TABLESPACE badasscouncil;
CREATE UNIQUE INDEX IF NOT EXISTS ix_users_nickgroup_name ON badasscouncil.users USING btree (nick_name, group_name) TABLESPACE badasscouncil;
