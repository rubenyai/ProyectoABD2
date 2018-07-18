DROP USER repositorio CASCADE;
DROP USER administra CASCADE;
DROP USER modera CASCADE;
DROP USER registra CASCADE;
DROP ROLE administrador CASCADE;
DROP ROLE registrador CASCADE;
DROP ROLE moderador CASCADE;
DROP TABLESPACE tbp_tabla INCLUDING CONTENTS AND DATAFILES;
DROP TABLESPACE tbp_indice INCLUDING CONTENTS AND DATAFILES;
create tablespace tbp_tabla  datafile ‘df1_rr.dbf’ size 50M;
create tablespace tbp_indice datafile ‘df2_rr.dbf’ size 50M;

CREATE USER repositorio IDENTIFIED BY 12345;
ALTER USER repositorio QUOTA UNLIMITED ON tbp_tabla;
ALTER USER repositorio QUOTA UNLIMITED ON tbp_indice;
grant create table, create view to repositorio with admin option;

create table repositorio.entrenadores(
  id_entrenador number,
  id_ciudad number,
  fecha_nacimiento date,
  nombre varchar2(50) not null,
  apellido varchar2(50),
  correo varchar2(50),
  sexo varchar2(15)
) tablespace tbp_tabla;

create unique index entrenadores_id_PK_indx
  on repositorio.entrenadores(id_entrenador)
  tablespace tbp_indice;

create index entrenadores_nombre_indx
  on repositorio.entrenadores(nombre)
  tablespace tbp_indice;

alter table repositorio.entrenadores add primary key (id_entrenador);
alter table repositorio.entrenadores add constraint email_chk check (correo like '%_@__%.__%');
alter table repositorio.entrenadores add constraint sexo_chk check (sexo in ('hombre','mujer'));

create table repositorio.paises(
  id_pais number,
  nombre_spa varchar2(50) not null,
  nombre_eng varchar2(50) not null,
  cod_area varchar2(50)
) tablespace tbp_tabla;

create unique index paises_id_PK_indx
  on repositorio.paises (id_pais)
  tablespace tbp_indice;

create index paises_nombre_spa_indx
  on repositorio.paises (nombre_spa)
  tablespace tbp_indice;

create index paises_nombre_eng_indx
  on repositorio.paises (nombre_eng)
  tablespace tbp_indice;

alter table repositorio.paises add primary key (id_pais);

create table repositorio.ciudades(
  id_ciudad number,
  id_pais number,
  nombre_spa varchar2(50) not null,
  nombre_eng varchar2(50) not null,
  cod_postal varchar2(50)
) tablespace tbp_tabla;

create unique index ciudades_id_PK_indx
  on repositorio.ciudades (id_ciudad)
  tablespace tbp_indice;

create index ciudades_nombre_spa_indx
  on repositorio.ciudades (nombre_spa)
  tablespace tbp_indice;

create index ciudades_nombre_eng_indx
  on repositorio.ciudades (nombre_eng)
  tablespace tbp_indice;

alter table repositorio.ciudades add primary key (id_ciudad);
alter table repositorio.entrenadores add foreign key (id_ciudad) references repositorio.ciudades (id_ciudad);
alter table repositorio.ciudades add foreign key (id_pais) references repositorio.paises(id_pais);

create table repositorio.digimons(
  id_digimon number,
  id_entrenador number,
  id_naturaleza number,
  id_tipo number,
  nombre varchar2(50) not null,
  genero varchar2(50),
  forma varchar2(50),
  fecha_liberacion date,
  vida number,
  ataque number,
  defensa number,
  defensa_especial number,
  velocidad number
) tablespace tbp_tabla;

create unique index digimons_id_PK_indx
  on repositorio.digimons (id_digimon)
  tablespace tbp_indice;

create index digimons_nombre_indx
  on repositorio.digimons (nombre)
  tablespace tbp_indice;

alter table repositorio.digimons add primary key (id_digimon);
alter table repositorio.digimons add foreign key(id_entrenador) references repositorio.entrenadores (id_entrenador);
alter table repositorio.digimons add constraint genero_chk check (genero in ('masculino','femenino'));
alter table repositorio.digimons add constraint formas_chk check (forma in ('in training','rookie','champion','ultra','mega','brust','armor','matrix','spirit'));
alter table repositorio.digimons add constraint vida_chk check (vida >=0 and vida <=9999);
alter table repositorio.digimons add constraint ataque_chk check (ataque >=0 and ataque <=9999);
alter table repositorio.digimons add constraint defensa_chk check (defensa >=0 and defensa <=9999);
alter table repositorio.digimons add constraint defensaespecial_chk check (defensa_especial >=0 and defensa_especial <=9999);
alter table repositorio.digimons add constraint velocidad_chk check (velocidad >=0 and velocidad <=9999);

create table repositorio.naturalezas(
  id_naturaleza number,
  nombre varchar2(50) not null,
  beneficio varchar2(50),
  desventaja varchar2(50),
  porcentaje number,
  descripcion varchar2(50)
) tablespace tbp_tabla;

create unique index naturalezas_id_PK_indx
  on repositorio.naturalezas(id_naturaleza)
  tablespace tbp_indice;

create index naturalezas_nombre_indx
  on repositorio.naturalezas(nombre)
  tablespace tbp_indice;

alter table repositorio.naturalezas add primary key (id_naturaleza);
alter table repositorio.digimons add foreign key(id_naturaleza) references repositorio.naturalezas (id_naturaleza);

create table repositorio.habilidades(
  id_habilidad number,
  id_digimon number,
  id_evolucion number,
  nombre varchar2(50) not null,
  descripcion varchar2(100)
) tablespace tbp_tabla;

create unique index habilidades_id_PK_indx
  on repositorio.habilidades (id_habilidad)
  tablespace tbp_indice;

create index habilidades_nombre_indx
  on repositorio.habilidades (nombre)
  tablespace tbp_indice;

alter table repositorio.habilidades add primary key (id_habilidad);
alter table repositorio.habilidades add foreign key(id_digimon) references repositorio.digimons (id_digimon);


create table repositorio.evoluciones(
  id_evolucion number,
  id_digimon number,
  nombre varchar2(50) not null,
  tipo_evolucion varchar2(50),
  forma varchar2(50),
  vida number,
  ataque number,
  defensa number,
  defensa_especial number,
  velocidad number
) tablespace tbp_tabla;

create unique index evoluciones_id_PK_indx
  on repositorio.evoluciones (id_evolucion)
  tablespace tbp_indice;

create index evoluciones_nombre_indx
  on repositorio.evoluciones (nombre)
  tablespace tbp_indice;

alter table repositorio.evoluciones add primary key (id_evolucion);
alter table repositorio.evoluciones add foreign key(id_digimon) references repositorio.digimons (id_digimon);
alter table repositorio.evoluciones add constraint formas2_chk check (forma in ('in training','rookie','champion','ultra','mega','brust','armor','matrix','spirit'));
alter table repositorio.evoluciones add constraint tipoevolucion_chk check (tipo_evolucion in ('por entrenamiento','por emblema','por estadistica','por ambiente','por emociones'));
alter table repositorio.evoluciones add constraint vida2_chk check (vida >=0 and vida <=9999);
alter table repositorio.evoluciones add constraint ataque2_chk check (ataque >=0 and ataque <=9999);
alter table repositorio.evoluciones add constraint defensa2_chk check (defensa >=0 and defensa <=9999);
alter table repositorio.evoluciones add constraint defensaespecial2_chk check (defensa_especial >=0 and defensa_especial <=9999);
alter table repositorio.evoluciones add constraint velocidad2_chk check (velocidad >=0 and velocidad <=9999);

create table repositorio.tipos(
  id_tipo number,
  nombre varchar2(50),
  descripcion varchar2 (100)
) tablespace tbp_tabla;

create unique index tipos_id_PK_indx
  on repositorio.tipos (id_tipo)
  tablespace tbp_indice;

create index tipos_nombre_indx
  on repositorio.tipos (nombre)
  tablespace tbp_indice;

alter table repositorio.tipos add primary key (id_tipo);
alter table repositorio.digimons add foreign key(id_tipo) references repositorio.tipos (id_tipo);
alter table repositorio.tipos add constraint tiposnombre_chk check (nombre in ('agua','fuego','viento','naturaleza','tierra','luz','oscuridad'));


create role registrador;
grant insert, update on repositorio.entrenadores to registrador;
grant insert, update on repositorio.paises to registrador;
grant insert, update on repositorio.ciudades to registrador;
grant insert, update on repositorio.digimons to registrador;
grant insert, update on repositorio.naturalezas to registrador;
grant insert, update on repositorio.habilidades to registrador;
grant insert, update on repositorio.evoluciones to registrador;
grant insert, update on repositorio.tipos to registrador;

create role moderador;
grant select on repositorio.entrenadores to moderador;
grant select on repositorio.paises to moderador;
grant select on repositorio.ciudades to moderador;
grant select on repositorio.digimons to moderador;
grant select on repositorio.naturalezas to moderador;
grant select on repositorio.habilidades to moderador;
grant select on repositorio.evoluciones to moderador;
grant select on repositorio.tipos to moderador;

create role administrador;
grant select, insert, update, delete on repositorio.entrenadores to administrador;
grant select, insert, update, delete on repositorio.paises to administrador;
grant select, insert, update, delete on repositorio.ciudades to administrador;
grant select, insert, update, delete on repositorio.digimons to administrador;
grant select, insert, update, delete on repositorio.naturalezas to administrador;
grant select, insert, update, delete on repositorio.habilidades to administrador;
grant select, insert, update, delete on repositorio.evoluciones to administrador;
grant select, insert, update, delete on repositorio.tipos to administrador;

create user registra identified by 12345 default tablespace tbp_tabla;
create user modera identified by 12345 default tablespace tbp_tabla;
create user administra identified by 12345 default tablespace tbp_tabla;

grant create session, create view to registra with admin option;
grant create session, create view to administra with admin option;
grant create session, create view to modera with admin option;

grant moderador to modera;
grant administrador to administra;
grant registrador to registra;
