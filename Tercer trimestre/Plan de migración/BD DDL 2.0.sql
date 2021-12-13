create database pmaemarket;
\c pmaemarket

create table persona(
tipo_documento character(3) not null,
n_documento bigint not null,
p_nombre character varying(25) not null,
s_nombre character varying(25) null,
p_apellido character varying(25) not null,
s_apellido character varying(25) null,
direccion character varying(40) not null,
telefono bigint not null,
correo character varying(50) not null, 
primary key(n_documento)
);

create table t_documento(
id_t_documento character(3) not null,
descripcion character(25) not null, 
primary key(id_t_documento)
);

create table roles(
id_rol character(5) not null,
descripcion_rol character(15) not null,
primary key(id_rol)
);

create table contratacion(
fecha_contratacion date not null,
cargo character(10) not null,
descripcion text null,
persona_id_contratacion bigint not null,
primary key(persona_id_contratacion)
);

create table factura(
n_factura character(10) not null,
fecha_factura date not null,
subtotal real not null,
iva real not null, 
recargo_domicilio real not null, 
total_factura real not null, 
forma_de_pago_factura character(10) not null,
forma_de_entrega_factura character(15) not null,
estado_factura character(10) not null,
persona_rol_factura bigint not null, 
primary key (n_factura, persona_rol_factura)
);

create table estado_(
id_estado_factura character(5) not null,
descripcion_estado_f character(15) not null,
primary key (id_estado_factura)
); 

create table forma_de_pago(
id_forma_pago character(5) not null, 
descripcion text not null, 
primary key (id_forma_pago)
);

create table forma_de_entrega(
id_forma_entrega character(6) not null,
descripcion text not null, 
primary key (id_forma_entrega)
);

create table productos(
cod_producto character(10) not null,
n_producto character varying(25) not null, 
descripcion text not null,
precio_unitario real not null,
stock bigint not null,  
categoria_id_categoria character(8) not null, 
primary key(cod_producto)
);

create table ingresos(
id_ingresos character(7) not null,
fecha_ingresos date not null,
primary key (id_ingresos)
);

create table lote(
id_lote character(5) not null,
fecha_vencimiento date not null,
estado_lote character(10) not null, 
primary key(id_lote)
); 
 
create table estado(
id_estado_lote character(5) not null,
descripcion_estado_l character(15) not null,
primary key(id_estado_lote)
); 

create table categorias(
id_categoria character(8) not null,
categoria character varying(30) not null,
primary key (id_categoria)
);

create table relacion_productos_ingresos(
producto_cod_producto character(10) not null, 
ingreso_id_ingresos character(7) not null, 
cantidad bigint not null, 
primary key(producto_cod_producto, ingreso_id_ingresos)
);

create table relacion_lote_producto(
lote_id_lote character(5) not null, 
lote_cod_producto character(10) not null, 
cantidad bigint not null, 
primary key(lote_id_lote, lote_cod_producto)
);

create table relacion_persona_rol(
persona_n_persona bigint not null, 
rol_id_rol character(5) not null, 
estado boolean not null, 
primary key (persona_n_persona,rol_id_rol)
);

create table detalle_factura(
factura_n_factura character(10) not null,
cod_producto_detalle character(10) not null,
cantidad bigint not null,
valor_total real not null,
sub_total real not null,
primary key (factura_n_factura,cod_producto_detalle)
);

alter table persona add
foreign key (tipo_documento)
references t_documento(id_t_documento);

alter table factura add
foreign key (forma_de_entrega_factura)
references forma_de_entrega(id_forma_entrega);

alter table factura add
foreign key (forma_de_pago_factura)
references forma_de_pago(id_forma_pago);

alter table factura add
unique (n_factura);

alter table detalle_factura add
foreign key (factura_n_factura)
references factura(n_factura);

alter table detalle_factura add
foreign key(cod_producto_detalle)
references productos(cod_producto);

alter table relacion_persona_rol add
foreign key (rol_id_rol)
references roles(id_rol);

alter table relacion_persona_rol add
foreign key (persona_n_persona)
references persona(n_documento);

alter table factura add
foreign key (persona_rol_factura)
references relacion_persona_rol(persona_n_persona);

alter table relacion_persona_rol add
unique (persona_n_persona); 

alter table productos add
foreign key (categoria_id_categoria)
references categorias(id_categoria);

alter table contratacion add
foreign key (persona_id_contratacion)
references persona(n_documento);

alter table relacion_productos_ingresos add
foreign key (producto_cod_producto)
references productos(cod_producto);

alter table relacion_productos_ingresos add
foreign key (ingreso_id_ingresos)
references ingresos(id_ingresos); 

alter table relacion_lote_producto add
foreign key (lote_id_lote)
references lote(id_lote);

alter table relacion_lote_producto add
foreign key(lote_cod_producto)
references productos(cod_producto); 

alter table factura add
foreign key(estado_factura)
references estado_(id_estado_factura); 

alter table lote add
foreign key(estado_lote)
references estado(id_estado_lote); 