
-- DROP ROLE IF EXISTS badasscouncil;
CREATE ROLE badasscouncil WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  NOCREATEDB
  NOCREATEROLE
  NOREPLICATION
  NOBYPASSRLS
  ENCRYPTED PASSWORD 'pharmago$2024';

-- DROP TABLESPACE IF EXISTS badasscouncil;
CREATE TABLESPACE badasscouncil OWNER badasscouncil LOCATION '/Users/Rajah/Documents/www.triplea.fr/vote/badasscouncil-base';
ALTER TABLESPACE badasscouncil OWNER TO badasscouncil;

-- DROP DATABASE IF EXISTS badasscouncil;
CREATE DATABASE badasscouncil WITH
    OWNER = badasscouncil
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'fr_FR.UTF-8'
    LC_CTYPE = 'fr_FR.UTF-8'
    TABLESPACE = badasscouncil
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\c badasscouncil

-- DROP SCHEMA IF EXISTS badasscouncil ;
CREATE SCHEMA IF NOT EXISTS badasscouncil AUTHORIZATION badasscouncil;

\ir ./tables/variables.sql
\ir ./tables/roles.sql
\ir ./tables/users.sql
\ir ./tables/users_roles.sql
\ir ./tables/refreshtoken.sql
\ir ./tables/preferences.sql
\ir ./tables/rooms.sql
\ir ./tables/messages.sql
\ir ./tables/attachments.sql
