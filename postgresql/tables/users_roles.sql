CREATE TABLE IF NOT EXISTS badasscouncil.users_roles
(
    user_id integer NOT NULL,
    role_id integer NOT NULL,
    CONSTRAINT fk_user_id_users FOREIGN KEY(user_id) REFERENCES badasscouncil.users(user_id),
    CONSTRAINT fk_role_id_roles FOREIGN KEY(role_id) REFERENCES badasscouncil.roles(role_id)
)
TABLESPACE badasscouncil;
ALTER TABLE IF EXISTS badasscouncil.users_roles OWNER to badasscouncil;

CREATE INDEX IF NOT EXISTS ix_users_roles_user_id ON badasscouncil.users_roles USING btree (user_id) TABLESPACE badasscouncil;
CREATE INDEX IF NOT EXISTS ix_users_roles_role_id ON badasscouncil.users_roles USING btree (role_id) TABLESPACE badasscouncil;
