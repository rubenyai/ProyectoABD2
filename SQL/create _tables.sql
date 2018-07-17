DROP TABLESPACE tbp_tabla INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE tbp_indice INCLUDING CONTENTS AND DATAFILES;
create tablespace tbp_tabla  datafile ‘df1_rr.dbf’ size 50M;
create tablespace tbp_indice datafile ‘df2_rr.dbf’ size 50M;

DROP USER repositorio CASCADE;
DROP USER administra CASCADE;
DROP USER modera CASCADE;
DROP USER registra CASCADE;
DROP ROLE administrador CASCADE;
DROP ROLE registrador CASCADE;
DROP ROLE moderador CASCADE;
CREATE USER repositorio IDENTIFIED BY 12345;
grant create table, create trigger, create user, create role to repositorio;
ALTER USER repositorio QUOTA UNLIMITED ON tbp_tabla;
ALTER USER repositorio QUOTA UNLIMITED ON tbp_indice;

create user registra identified by 12345 default tablespace tbp_tabla;
create user modera identified by 12345 default tablespace tbp_tabla;
create user administra identified by 12345 default tablespace tbp_tabla;
grant create session to registra;
grant create session to administra;
grant create session to modera;

create table entrenadores(
  id_entrenador number,
  id_ciudad number,
  fecha_nacimiento date,
  nombre varchar2(50) not null,
  apellido varchar2(50),
  correo varchar2(50),
  sexo varchar2(15) check (sexo in ('hombre','mujer'))
) tablespace tbp_tabla;

create unique index entrenadores_id_PK_indx
  on entrenadores(id_entrenador)
  tablespace tbp_indice;

create index entrenadores_nombre_indx
  on entrenadores(nombre)
  tablespace tbp_indice;

alter table entrenadores add primary key (id_entrenador);

create table ciudades(
  id_ciudad number,
  pais varchar2(50) not null,
  nombre_spa varchar2(50) not null,
  nombre_eng varchar2(50) not null,
  cod_postal varchar2(50)
) tablespace tbp_tabla;

create unique index ciudades_id_PK_indx
  on ciudades (id_ciudad)
  tablespace tbp_indice;

create index ciudades_nombre_spa_indx
  on ciudades (nombre_spa)
  tablespace tbp_indice;

create index ciudades_nombre_eng_indx
  on ciudades (nombre_eng)
  tablespace tbp_indice;

create index ciudades_pais_indx
  on ciudades (pais)
  tablespace tbp_indice;

alter table ciudades add primary key (id_ciudad);

create table digimons(
  id_digimon number,
  id_entrenador number,
  id_naturaleza number,
  id_tipo number,
  nombre varchar2(50) not null,
  genero varchar2(50) check (genero in ('masculino','femenino')),
  forma varchar2(50) check (forma in ('in training','rookie','champion','ultra','mega','brust','armor','matrix','spirit')),
  fecha_liberacion date,
  vida number check (vida >=0 and vida <=9999),
  ataque number check (ataque >=0 and ataque <=9999),
  defensa number check (defensa>=0 and defensa <=9999),
  defensa_especial number check (defensa_especial >=0 and defensa_especial <=9999),
  velocidad number check (velocidad >=0 and velocidad <=9999)
) tablespace tbp_tabla;

create unique index digimons_id_PK_indx
  on digimons (id_digimon)
  tablespace tbp_indice;

create index digimons_nombre_indx
  on digimons (nombre)
  tablespace tbp_indice;

alter table digimons add primary key (id_digimon);

create table naturalezas(
  id_naturaleza number,
  nombre varchar2(50) not null,
  beneficio varchar2(50),
  desventaja varchar2(50),
  porcentaje number,
  descripcion varchar2(50)
) tablespace tbp_tabla;

create unique index naturalezas_id_PK_indx
  on naturalezas(id_naturaleza)
  tablespace tbp_indice;

create index naturalezas_nombre_indx
  on naturalezas(nombre)
  tablespace tbp_indice;

alter table naturalezas add primary key (id_naturaleza);

create table habilidades(
  id_habilidad number,
  id_digimon number,
  id_evolucion number,
  nombre varchar2(50) not null,
  descripcion varchar2(100)
) tablespace tbp_tabla;

create unique index habilidades_id_PK_indx
  on habilidades (id_habilidad)
  tablespace tbp_indice;

create index habilidades_nombre_indx
  on habilidades (nombre)
  tablespace tbp_indice;

alter table habilidades add primary key (id_habilidad);

create table evoluciones(
  id_evolucion number,
  id_digimon number,
  nombre varchar2(50) not null,
  tipo_evolucion varchar2(50) check (tipo_evolucion in ('por entrenamiento','por emblema','por estadistica','por ambiente','por emociones')),
  forma varchar2(50) check (forma in ('in training','rookie','champion','ultra','mega','brust','armor','matrix','spirit')),
  vida number check (vida >=0 and vida <=9999),
  ataque number check (ataque >=0 and ataque <=9999),
  defensa number check (defensa>=0 and defensa <=9999),
  defensa_especial number check (defensa_especial >=0 and defensa_especial <=9999),
  velocidad number check (velocidad >=0 and velocidad <=9999)
) tablespace tbp_tabla;

create unique index evoluciones_id_PK_indx
  on evoluciones (id_evolucion)
  tablespace tbp_indice;

create index evoluciones_nombre_indx
  on evoluciones (nombre)
  tablespace tbp_indice;

alter table evoluciones add primary key (id_evolucion);

create table tipos(
  id_tipo number,
  nombre varchar2(50) check (nombre in ('agua','fuego','viento','naturaleza','tierra','luz','oscuridad')),
  descripcion varchar2 (100)
) tablespace tbp_tabla;

create unique index tipos_id_PK_indx
  on tipos (id_tipo)
  tablespace tbp_indice;

create index tipos_nombre_indx
  on tipos (nombre)
  tablespace tbp_indice;

alter table tipos add primary key (id_tipo);

create role registrador;
grant insert, update, delete on entrenadores to registrador;
grant insert, update, delete on ciudades to registrador;
grant insert, update, delete on digimons to registrador;
grant insert, update, delete on naturalezas to registrador;
grant insert, update, delete on habilidades to registrador;
grant insert, update, delete on evoluciones to registrador;
grant insert, update, delete on tipos to registrador;

create role moderador;
grant select on entrenadores to moderador;
grant select on ciudades to moderador;
grant select on digimons to moderador;
grant select on naturalezas to moderador;
grant select on habilidades to moderador;
grant select on evoluciones to moderador;
grant select on tipos to moderador;

create role administrador;
grant select, insert, update, delete on entrenadores to administrador with grant option;
grant select, insert, update, delete on ciudades to administrador;
grant select, insert, update, delete on digimons to administrador;
grant select, insert, update, delete on naturalezas to administrador;
grant select, insert, update, delete on habilidades to administrador;
grant select, insert, update, delete on evoluciones to administrador;
grant select, insert, update, delete on tipos to administrador;

grant moderador to modera;
grant administrador to administra;
grant registrador to registra;
