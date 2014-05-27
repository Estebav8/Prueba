/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     24/05/2014 12:30:03 p.m.                     */
/*==============================================================*/



if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ALQUILER') and o.name = 'FK_ALQUILER_USUARIO')
alter table ALQUILER
   drop constraint FK_ALQUILER_USUARIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('ALQUILER') and o.name = 'FK_ALQUILER_PRODUCTO')
alter table ALQUILER
   drop constraint FK_ALQUILER_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPRAVENTA') and o.name = 'FK_COMPRAVE_PRODUCTO')
alter table COMPRAVENTA
   drop constraint FK_COMPRAVE_PRODUCTO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('COMPRAVENTA') and o.name = 'FK_COMPRA_USUARIO')
alter table COMPRAVENTA
   drop constraint FK_COMPRA_USUARIO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTO') and o.name = 'FK_PRODUCTO_TIPOACCI')
alter table PRODUCTO
   drop constraint FK_PRODUCTO_TIPOACCI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTO') and o.name = 'FK_PRODUCTO_DETALLE')
alter table PRODUCTO
   drop constraint FK_PRODUCTO_DETALLE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTO') and o.name = 'FK_PRODUCTO_CATALOGO')
alter table PRODUCTO
   drop constraint FK_PRODUCTO_CATALOGO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PRODUCTO') and o.name = 'FK_PRODUCTO_USUARIO')
alter table PRODUCTO
   drop constraint FK_PRODUCTO_USUARIO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('ALQUILER')
            and   type = 'U')
   drop table ALQUILER
go

if exists (select 1
            from  sysobjects
           where  id = object_id('COMPRAVENTA')
            and   type = 'U')
   drop table COMPRAVENTA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DETALLE')
            and   type = 'U')
   drop table DETALLE
go

if exists (select 1
            from  sysobjects
           where  id = object_id('INSTALACION')
            and   type = 'U')
   drop table INSTALACION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PRODUCTO')
            and   type = 'U')
   drop table PRODUCTO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('TIPOACCION')
            and   type = 'U')
   drop table TIPOACCION
go

if exists (select 1
            from  sysobjects
           where  id = object_id('USUARIO')
            and   type = 'U')
   drop table USUARIO
go

/*==============================================================*/
/* Table: ALQUILER                                              */
/*==============================================================*/
create table ALQUILER (
   ID_USUARIO           numeric              not null,
   ID_PRODUCTO          numeric              not null,
   ANTICIPO             numeric              null,
   FECHAINICIOALQUILER  date                 null,
   constraint PK_ALQUILER primary key (ID_USUARIO, ID_PRODUCTO)
)
go

/*==============================================================*/
/* Table: COMPRAVENTA                                           */
/*==============================================================*/
create table COMPRAVENTA (
   ID_USUARIO           numeric              not null,
   ID_PRODUCTO          numeric              not null,
   FECHADEOFERTA        date                 null,
   constraint PK_COMPRAVENTA primary key (ID_USUARIO, ID_PRODUCTO)
)
go

/*==============================================================*/
/* Table: DETALLE                                               */
/*==============================================================*/
create table DETALLE (
   ID_DETALLE           numeric              not null,
   CUARTOS              numeric              null,
   BANOS                numeric              null,
   ESTACIONAMIENTO      numeric              null,
   constraint PK_DETALLE primary key (ID_DETALLE)
)
go

/*==============================================================*/
/* Table: INSTALACION                                           */
/*==============================================================*/
create table INSTALACION (
   OFICINA              numeric              not null,
   TIPOINSTALACION      numeric(10)          null,
   constraint PK_INSTALACION primary key (OFICINA)
)
go

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_PRODUCTO          numeric              not null,
   ID_DETALLE           numeric              not null,
   ID_USUARIO           numeric              not null,
   OFICINA              numeric              null,
   ID_ACCION            numeric              null,
   COORDENADA           varchar              null,
   DESCRIPCION          varchar              null,
   MTSCONSTRUCCION      numeric              null,
   MTSTERRENOS          numeric              null,
   PRECIO               numeric              null,
   FECHAPUBLICACION     date                 null,
   constraint PK_PRODUCTO primary key (ID_PRODUCTO)
)
go

/*==============================================================*/
/* Table: TIPOACCION                                            */
/*==============================================================*/
create table TIPOACCION (
   ID_ACCION            numeric              not null,
   TIPOACCION           numeric(10)          null,
   constraint PK_TIPOACCION primary key (ID_ACCION)
)
go

/*==============================================================*/
/* Table: USUARIO                                               */
/*==============================================================*/
create table USUARIO (
   ID_USUARIO           numeric              not null,
   NOMBRE               varchar              null,
   CONTRASENA           varbinary            null,
   CORREO               varchar              null,
   TELEFONO             numeric              null,
   DIRECCION            varchar              null,
   constraint PK_USUARIO primary key (ID_USUARIO)
)
go

alter table ALQUILER
   add constraint FK_ALQUILER_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
go

alter table ALQUILER
   add constraint FK_ALQUILER_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
go

alter table COMPRAVENTA
   add constraint FK_COMPRAVE_PRODUCTO foreign key (ID_PRODUCTO)
      references PRODUCTO (ID_PRODUCTO)
go

alter table COMPRAVENTA
   add constraint FK_COMPRA_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
go

alter table PRODUCTO
   add constraint FK_PRODUCTO_TIPOACCI foreign key (ID_ACCION)
      references TIPOACCION (ID_ACCION)
go

alter table PRODUCTO
   add constraint FK_PRODUCTO_DETALLE foreign key (ID_DETALLE)
      references DETALLE (ID_DETALLE)
go

alter table PRODUCTO
   add constraint FK_PRODUCTO_CATALOGO foreign key (OFICINA)
      references INSTALACION (OFICINA)
go

alter table PRODUCTO
   add constraint FK_PRODUCTO_USUARIO foreign key (ID_USUARIO)
      references USUARIO (ID_USUARIO)
go

