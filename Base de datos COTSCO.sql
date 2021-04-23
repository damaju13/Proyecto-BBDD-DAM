--Base de datos Proyecto
DROP TABLE DETALLE_COMPRA;
DROP TABLE DETALLE_PEDIDO;
DROP TABLE PEDIDO;
DROP TABLE COMPRA;
DROP TABLE CLIENTE;
DROP TABLE EMPLEADO;
DROP TABLE JEFE_DEPARTAMENTO;
DROP TABLE PRODUCTO;
DROP TABLE DEPARTAMENTO;
DROP TABLE ESTABLECIMIENTO;

DROP TABLE AUDITORIA_CLIENTE;
DROP TABLE AUDITORIA_COMPRA;
DROP TABLE AUDITORIA_DEPARTAMENTO;
DROP TABLE AUDITORIA_DETALLE_COMPRA;
DROP TABLE AUDITORIA_DETALLE_PEDIDO;
DROP TABLE AUDITORIA_EMPLEADO;
DROP TABLE AUDITORIA_ESTABLECIMIENTO;
DROP TABLE AUDITORIA_JEFE_DEPARTAMENTO;
DROP TABLE AUDITORIA_PEDIDO;
DROP TABLE AUDITORIA_PRODUCTO;

CREATE TABLE ESTABLECIMIENTO
(
    cod_establecimiento NUMBER(3) CONSTRAINT COD_EST_PK PRIMARY KEY,
    cod_postal NUMBER(5) CONSTRAINT COP_EST_NN NOT NULL,
    ciudad VARCHAR2 (10) CONSTRAINT CIU_EST_NN NOT NULL, 
    direccion VARCHAR(20) CONSTRAINT DIR_EST_NN NOT NULL,
    telefono VARCHAR2 (9) CONSTRAINT TEL_ESt_NN NOT NULL
);

CREATE TABLE DEPARTAMENTO
(
    cod_departamento NUMBER(3) CONSTRAINT COD_DEP_PK PRIMARY KEY,
    nombre VARCHAR2 (50) CONSTRAINT NOM_DEP_NN NOT NULL,
    cod_establecimiento NUMBER(3) CONSTRAINT CES_DEP_NN NOT NULL,
    CONSTRAINT COE_DEP_FK FOREIGN KEY (cod_establecimiento) REFERENCES ESTABLECIMIENTO
);

CREATE TABLE PRODUCTO
(
    cod_producto NUMBER(3),
    cod_departamento NUMBER(3),
    nombre VARCHAR2(40) CONSTRAINT NOM_PRO_NN NOT NULL,
    gama VARCHAR2(20) CONSTRAINT GAM_PRO_NN NOT NULL,
    descripcion VARCHAR2(100), 
    proovedor VARCHAR2(20) CONSTRAINT PRO_PRO_NN NOT NULL,
    cantidad_stock NUMBER(6),
    precio_venta NUMBER (5) CONSTRAINT PRV_PRO_NN NOT NULL,
    precio_proovedor NUMBER (5) CONSTRAINT PRP_PRO_NN NOT NULL,
    CONSTRAINT POD_PRO_FK FOREIGN KEY (cod_departamento) REFERENCES DEPARTAMENTO,
    CONSTRAINT CPD_PRO_PK PRIMARY KEY (cod_producto)
);

CREATE TABLE JEFE_DEPARTAMENTO
(
    cod_departamento NUMBER(3),
    nombre VARCHAR2 (50) CONSTRAINT NOM_JDE_NN NOT NULL,
    apellido1 VARCHAR2 (50) CONSTRAINT AP1_JDE_NN NOT NULL,
    apellido2 VARCHAR2 (50) CONSTRAINT AP2_JDE_NN NOT NULL,
    CONSTRAINT COD_JDE_FK FOREIGN KEY (cod_departamento) REFERENCES DEPARTAMENTO,
    CONSTRAINT COP_JDE_PK PRIMARY KEY (cod_departamento)
);

CREATE TABLE EMPLEADO
(
    cod_empleado NUMBER(3) CONSTRAINT COE_EMP_PK PRIMARY KEY, 
    cod_empleado_jefe NUMBER(3),
    cod_departamento NUMBER(3) CONSTRAINT COD_EMP_NN NOT NULL,
    nombre VARCHAR2 (50) CONSTRAINT NOM_EMP_NN NOT NULL,
    apellido1 VARCHAR2 (50) CONSTRAINT AP1_EMP_NN NOT NULL,
    apellido2 VARCHAR2 (50) CONSTRAINT AP2_EMP_NN NOT NULL,
    telefono VARCHAR2 (9) CONSTRAINT TEL_EMP_NN NOT NULL,
    pais VARCHAR2 (20) CONSTRAINT PAI_EMP_NN NOT NULL, 
    provincia VARCHAR2 (20) CONSTRAINT PRO_EMP_NN NOT NULL, 
    ciudad VARCHAR2 (20) CONSTRAINT CIU_EMP_NN NOT NULL, 
    dni VARCHAR2 (50) CONSTRAINT DNI_EMP_NN NOT NULL,
    salario NUMBER (12),
    CONSTRAINT COD_EMP_FK FOREIGN KEY (cod_departamento) REFERENCES DEPARTAMENTO,
    CONSTRAINT COJ_EMP_FK FOREIGN KEY (cod_empleado_jefe) REFERENCES EMPLEADO
);


CREATE TABLE CLIENTE
(
    cod_cliente NUMBER(3) CONSTRAINT COC_CLI_PK PRIMARY KEY,
    nombre VARCHAR2 (50) CONSTRAINT NOM_CLI_NN NOT NULL,
    apellido1 VARCHAR2 (50) CONSTRAINT AP1_CLI_NN NOT NULL,
    apellido2 VARCHAR2 (50),
    dni VARCHAR2 (50) CONSTRAINT DNI_CLI_NN NOT NULL,
    telefono VARCHAR2 (9) CONSTRAINT TEL_CLI_NN NOT NULL,
    cod_empleado_jefe NUMBER(3) CONSTRAINT COE_CLI_NN NOT NULL,
    CONSTRAINT CEJ_CLI_FK FOREIGN KEY (cod_empleado_jefe) REFERENCES EMPLEADO
);

CREATE TABLE COMPRA
(
    cod_compra NUMBER(3) CONSTRAINT COD_COM_PK PRIMARY KEY,
    cod_cliente NUMBER(3),
    fecha_compra DATE CONSTRAINT FEC_COM_NN NOT NULL,
    CONSTRAINT COD_COM_FK FOREIGN KEY (cod_cliente) REFERENCES CLIENTE
);

CREATE TABLE PEDIDO
(
    cod_pedido NUMBER(3) CONSTRAINT COD_PED_PK PRIMARY KEY,
    cod_cliente NUMBER(3),
    fecha_pedido DATE CONSTRAINT FEC_PED_NN NOT NULL,
    fecha_entrega DATE CONSTRAINT ENT_PED_NN NOT NULL,
    CONSTRAINT COD_PED_FK FOREIGN KEY (cod_cliente) REFERENCES CLIENTE
);

CREATE TABLE DETALLE_PEDIDO
(
    cod_pedido NUMBER(3),
    cod_producto NUMBER (3),
    cantidad NUMBER(6) CONSTRAINT CAN_DPE_NN NOT NULL,
    precio_unidad NUMBER(5) CONSTRAINT PRE_DPE_NN NOT NULL,
    CONSTRAINT CPE_DPE_FK FOREIGN KEY (cod_pedido) REFERENCES PEDIDO,
    CONSTRAINT CPR_DPE_FK FOREIGN KEY (cod_producto) REFERENCES PRODUCTO,
    CONSTRAINT CPP_DPE_FK PRIMARY KEY (cod_pedido, cod_producto)
);

CREATE TABLE DETALLE_COMPRA
(
    cod_compra NUMBER(3),
    cod_producto NUMBER (3),
    cantidad NUMBER(6) CONSTRAINT CAN_CMP_NN NOT NULL,
    precio_unidad NUMBER(5) CONSTRAINT PRE_CMP_NN NOT NULL,
    CONSTRAINT CPE_CMP_FK FOREIGN KEY (cod_compra) REFERENCES COMPRA,
    CONSTRAINT CPR_CMP_FK FOREIGN KEY (cod_producto) REFERENCES PRODUCTO,
    CONSTRAINT CPP_CMP_FK PRIMARY KEY (cod_compra, cod_producto)
);

CREATE TABLE AUDITORIA_CLIENTE
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);

CREATE TABLE AUDITORIA_COMPRA
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);

CREATE TABLE AUDITORIA_DEPARTAMENTO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_DETALLE_COMPRA
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_DETALLE_PEDIDO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_EMPLEADO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_ESTABLECIMIENTO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_JEFE_DEPARTAMENTO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_PEDIDO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);
CREATE TABLE AUDITORIA_PRODUCTO
(
    fecha DATE,
    usuario VARCHAR2(50),
    sentencia NUMBER(1),
    reg_old VARCHAR2(300),
    reg_new VARCHAR2(300)
);

--DATOS ESTABLECIMIENTO
INSERT INTO ESTABLECIMIENTO VALUES (001, 41002, 'Sevilla', 'C/ Colón 5', 955522326);
INSERT INTO ESTABLECIMIENTO VALUES (002, 08006, 'Barcelona', 'C/ Alcornoque 2', 955211229);
INSERT INTO ESTABLECIMIENTO VALUES (003, 28001, 'Madrid', 'C/ Morgado 10', 955324764);

--DATOS DEPARTAMENTO
INSERT INTO DEPARTAMENTO VALUES (001, 'Platos Preparados', 001);
INSERT INTO DEPARTAMENTO VALUES (002, 'Domótica', 001);
INSERT INTO DEPARTAMENTO VALUES (003, 'Hogar', 001);
INSERT INTO DEPARTAMENTO VALUES (004, 'Carnicería', 001);
INSERT INTO DEPARTAMENTO VALUES (005, 'Platos Preparados', 002);
INSERT INTO DEPARTAMENTO VALUES (006, 'Domótica', 002);
INSERT INTO DEPARTAMENTO VALUES (007, 'Hogar', 002);
INSERT INTO DEPARTAMENTO VALUES (008, 'Carnicería', 002);
INSERT INTO DEPARTAMENTO VALUES (009, 'Platos Preparados', 003);
INSERT INTO DEPARTAMENTO VALUES (010, 'Domótica', 003);
INSERT INTO DEPARTAMENTO VALUES (011, 'Hogar', 003);
INSERT INTO DEPARTAMENTO VALUES (012, 'Carnicería', 003);

--DATOS JEFE DEPARTAMENTO
INSERT INTO JEFE_DEPARTAMENTO VALUES (001, 'Jesús', 'Vázquez', 'Vela');
INSERT INTO JEFE_DEPARTAMENTO VALUES (002, 'Alejandro', 'Morgado', 'Obando');
INSERT INTO JEFE_DEPARTAMENTO VALUES (003, 'Jaime', 'Sánchez', 'García');
INSERT INTO JEFE_DEPARTAMENTO VALUES (004, 'Lucía', 'Martín', 'García');
INSERT INTO JEFE_DEPARTAMENTO VALUES (005, 'María', 'Rodríguez', 'Cospedal');
INSERT INTO JEFE_DEPARTAMENTO VALUES (006, 'Noelia', 'Angela', 'Barazar');
INSERT INTO JEFE_DEPARTAMENTO VALUES (007, 'Angela', 'García', 'Vela');
INSERT INTO JEFE_DEPARTAMENTO VALUES (008, 'Vladimir', 'García', 'Turín');
INSERT INTO JEFE_DEPARTAMENTO VALUES (009, 'Amadeo', 'Saboya', 'Vela');
INSERT INTO JEFE_DEPARTAMENTO VALUES (010, 'Felipe', 'Magrassi', 'Obando');
INSERT INTO JEFE_DEPARTAMENTO VALUES (011, 'David', 'Julián', 'Magrassi');
INSERT INTO JEFE_DEPARTAMENTO VALUES (012, 'Julio', 'Iglesias', 'Iglesias');

--DATOS EMPLEADO
INSERT INTO EMPLEADO VALUES (001, NULL, 002, 'Fran', 'Chico', 'del Olmo', 675262871, 'España', 'Sevilla', 'Sevilla', '12345678A', 2100);
INSERT INTO EMPLEADO VALUES (002, NULL, 003, 'Sheila', 'Oliver', 'Alonso', 675234592, 'EEUU', 'California', 'San Francisco', '12345678B', 2050);
INSERT INTO EMPLEADO VALUES (003, 001, 001, 'María', 'Sole', 'de la Cruz', 675459572, 'España', 'Sevilla', 'Utrera', '12345678C', 1020);
INSERT INTO EMPLEADO VALUES (004, 001, 001, 'Natalia', 'Maza', 'Perello', 675258976, 'España', 'Sevilla', 'Sevilla', '12345678D', 1060);
INSERT INTO EMPLEADO VALUES (005, 001, 002, 'Alonso', 'Borras', 'Sole', 675412897, 'España', 'Madrid', 'Madrid', '12345678E', 1200);
INSERT INTO EMPLEADO VALUES (006, 001, 002, 'Jesica', 'Rosello', 'Perello', 675528976, 'Italia', 'Lazio', 'Roma', '12345678F', 1120);
INSERT INTO EMPLEADO VALUES (007, 002, 003, 'Sira', 'Villena', 'Díez', 675458567, 'España', 'Sevilla', 'Sevilla', '12345678G', 980);
INSERT INTO EMPLEADO VALUES (008, 002, 003, 'Alejandra', 'Maza', 'Crespo', 675358976, 'España', 'Sevilla', 'Carmona', '12345678H', 540);
INSERT INTO EMPLEADO VALUES (009, 002, 004, 'Ignacio', 'Torre', 'de la Cruz', 675459967, 'España', 'Sevilla', 'Sevilla', '12345678I', 1000);
INSERT INTO EMPLEADO VALUES (011, 002, 004, 'Sergi', 'Manrique', 'Narvaez', 675288976, 'España', 'Sevilla', 'Dos Hermanas', '12345678J', 1260);

INSERT INTO EMPLEADO VALUES (012, NULL, 002, 'Feliciana', 'Arana', 'del Olmo', 67512346, 'España', 'Sevilla', 'Sevilla', '12345678K', 2300);
INSERT INTO EMPLEADO VALUES (013, NULL, 003, 'Alonso', 'Oliver', 'Queen', 67512347, 'EEUU', 'Ohio', 'Belmont', '12345678L', 2120);
INSERT INTO EMPLEADO VALUES (014, 012, 005, 'Jos', 'Barrio', 'de la Cruz', 67512348, 'Francia', 'Bretaña', 'Rennes', '12345678M', 1200);
INSERT INTO EMPLEADO VALUES (015, 012, 005, 'Eulalia', 'Robles', 'Perello', 675123459, 'España', 'Sevilla', 'Sevilla', '12345678N', 1230);
INSERT INTO EMPLEADO VALUES (016, 012, 006, 'Rosendo', 'Ramos', 'Sole', 675412197, 'España', 'Madrid', 'Madrid', '12345678O', 1200);
INSERT INTO EMPLEADO VALUES (017, 012, 006, 'Tamara', 'Casas', 'Perello', 675528916, 'Italia', 'Lazio', 'Roma', '12345678P',1020);
INSERT INTO EMPLEADO VALUES (018, 013, 007, 'Carmen', 'Mendoza', 'Díez', 67541567, 'España', 'Sevilla', 'Sevilla', '12345678Q', 1090);
INSERT INTO EMPLEADO VALUES (019, 013, 007, 'Yeray', 'del Castillo', 'Crespo', 675351976, 'España', 'Sevilla', 'Carmona', '12345678R', 950);
INSERT INTO EMPLEADO VALUES (020, 013, 008, 'Elizabeth', 'Camacho', 'de la Cruz', 675451967, 'España', 'Sevilla', 'Sevilla', '12345678S', 1060);
INSERT INTO EMPLEADO VALUES (021, 013, 008, 'Aurelio', 'Ledesma', 'Narvaez', 675188976, 'España', 'Sevilla', 'Dos Hermanas', '12345678T', 1140);

INSERT INTO EMPLEADO VALUES (022, NULL, 002, 'Julia', 'García', 'Baeza', 675262327, 'Francia', 'Borgoña', 'Dijon', '12345678U', 2500);
INSERT INTO EMPLEADO VALUES (023, NULL, 003, 'Jean', 'Chen', 'Lora', 675235529, 'Reino Unido', 'Londres', 'Londres', '12345678W', 2900);
INSERT INTO EMPLEADO VALUES (024, 022, 009, 'Coral', 'Pico', 'de la Cruz', 675455567, 'España', 'Murcia', 'Cartagena', '12345678X', 1200);
INSERT INTO EMPLEADO VALUES (025, 022, 009, 'Mario', 'Frances', 'Perello', 675258575, 'España', 'Guadalajara', 'Alovera', '12345678Y', 900);
INSERT INTO EMPLEADO VALUES (026, 022, 010, 'Asunción', 'Novoa', 'Sole', 675412857, 'España', 'Madrid', 'Madrid', '12345678Z', 600);
INSERT INTO EMPLEADO VALUES (027, 022, 010, 'Ricardo', 'Quiles', 'Perello', 675528576, 'Italia', 'Lazio', 'Roma', '87654321A', 1020);
INSERT INTO EMPLEADO VALUES (028, 023, 011, 'Reyes', 'Jiménez', 'Díez', 675558567, 'España', 'Sevilla', 'Sevilla', '87654321B', 1100);
INSERT INTO EMPLEADO VALUES (029, 023, 011, 'Vicenta', 'Goñi', 'Crespo', 675368976, 'España', 'Sevilla', 'Carmona', '87654321C', 1050);
INSERT INTO EMPLEADO VALUES (030, 023, 012, 'Blas', 'Prada', 'de la Cruz', 675459267, 'España', 'Sevilla', 'Sevilla', '87654321D', 1050);
INSERT INTO EMPLEADO VALUES (031, 023, 012, 'Jaime', 'Tamayo', 'Narvaez', 675289976, 'España', 'Sevilla', 'Dos Hermanas', '87654321E', 1060);

--DATOS CLIENTE
INSERT INTO CLIENTE VALUES (001, 'David', 'Pico', 'Crespo', '98765432A', 675987654, 001);
INSERT INTO CLIENTE VALUES (002, 'Mario', 'Novoa', 'del Olmo', '98765432B', 675987653, 001);
INSERT INTO CLIENTE VALUES (003, 'Ricardo', 'Torre', 'Díez', '98765431A', 675987654, 001);
INSERT INTO CLIENTE VALUES (004, 'Fernanda', 'Miralles', 'Ayala', '98765431B', 675987653, 001);
INSERT INTO CLIENTE VALUES (005, 'Martina', 'Cano', 'Cifuentes', '98765433A', 675987654, 001);
INSERT INTO CLIENTE VALUES (006, 'Amaya', 'Ceballos', 'Roig', '98765433B', 675987653, 001);

INSERT INTO CLIENTE VALUES (007, 'Izan', 'Quiñones', 'Hurtado', '12365432C', 675187652, 002);
INSERT INTO CLIENTE VALUES (008, 'David', 'Araujo', 'Muñoz', '12465432D', 675287651, 002);
INSERT INTO CLIENTE VALUES (009, 'Paola', 'Baeza', 'Fonseca', '15365432C', 675487650, 002);
INSERT INTO CLIENTE VALUES (010, 'Yeray', 'Medrano', 'Marcel', '16365432D', 675587649, 002);
INSERT INTO CLIENTE VALUES (011, 'Gines', 'Amores', 'Chen', '12365832C', 675687648, 002);
INSERT INTO CLIENTE VALUES (012, 'Alejandro', 'Gonzalo', 'Mariana', '10365432D', 675787647, 002);

INSERT INTO CLIENTE VALUES (013, 'Ana', 'Nuñez', 'Benito', '98735432E', 674982351, 012);
INSERT INTO CLIENTE VALUES (014, 'Uxue', 'Losada', 'Miguez', '98735432F', 674982342, 012);
INSERT INTO CLIENTE VALUES (015, 'Iman', 'Salvador', 'Anselmo', '98735432E', 675982350, 012);
INSERT INTO CLIENTE VALUES (016, 'Nelson', 'Palacios', 'Crespo', '98735432F', 675927334, 012);
INSERT INTO CLIENTE VALUES (017, 'Trinidad', 'Serna', 'Feijoo', '98735432E', 673982352, 012);
INSERT INTO CLIENTE VALUES (018, 'Homer', 'Simpson', 'Llopis', '98735432F', 673982349, 012);

INSERT INTO CLIENTE VALUES (019, 'Hipolito', 'Peña', 'Filomena', '98765432G', 671987634, 013);
INSERT INTO CLIENTE VALUES (020, 'Paulo', 'Vergara', 'Vela', '98765432H', 672987624, 013);
INSERT INTO CLIENTE VALUES (021, 'Ana Belén', 'Roldan', 'Enriqueta', '98765432I', 673987634, 013);
INSERT INTO CLIENTE VALUES (022, 'Pol', 'Acantara', 'Sales', '98765432J', 674987624, 013);
INSERT INTO CLIENTE VALUES (023, 'Thais', 'Catalayud', 'Edgar', '98765432K', 675987634, 013);
INSERT INTO CLIENTE VALUES (024, 'Judit', 'Lujan', 'de la Cruz', '98765432L', 676987624, 013);

INSERT INTO CLIENTE VALUES (025, 'Aday', 'Rebollo', NULL,'98265432I', 975987614, 022);
INSERT INTO CLIENTE VALUES (026, 'Aquilino', 'Ocaña', NULL,'98265432J', 955987604, 022);
INSERT INTO CLIENTE VALUES (027, 'Elisenda', 'Cantos', NULL,'98265432K', 945987614, 022);
INSERT INTO CLIENTE VALUES (028, 'Ayoub', 'Rosa', NULL,'98265432L', 965987604, 022);
INSERT INTO CLIENTE VALUES (029, 'Dionisio', 'Aroca', NULL,'98265432M', 925987614, 022);
INSERT INTO CLIENTE VALUES (030, 'Isaias', 'Campoy', NULL,'98265432N', 915987604, 022);

INSERT INTO CLIENTE VALUES (031, 'Milagros','Pico', NULL,'18765432K', 675987554, 023);
INSERT INTO CLIENTE VALUES (032, 'Yoel', 'Padrón', NULL,'18765432L', 675987454, 023);
INSERT INTO CLIENTE VALUES (033, 'Consuelo', 'Torre', NULL,'28765432K', 675987554, 023);
INSERT INTO CLIENTE VALUES (034, 'Fran', 'Alcalde', NULL,'28765432L', 675987454, 023);
INSERT INTO CLIENTE VALUES (035, 'Noemi', 'Ramon', NULL,'08765432K', 675987554, 023);
INSERT INTO CLIENTE VALUES (036, 'Magdalena', 'Barbero', NULL,'08765432L', 675987454, 023);

--DATOS PRODUCTO
--1er establecimiento
INSERT INTO PRODUCTO VALUES (101, 001, 'Espaguetis a la carbonara', 'Pastas', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'Mr. Food', 200, 3, 1.5);
INSERT INTO PRODUCTO VALUES (102, 001, 'Espaguetis a la boloñesa', 'Pastas', 'Deliciosos espaguetis preparados a la boloñesa con ternera', 'Mr. Food', 200, 2.95, 1.5);
INSERT INTO PRODUCTO VALUES (103, 001, 'Macarrones al Roquefort', 'Pastas', 'Deliciosos macarrones preparados al roquefort', 'Mr. Food', 200, 2.55, 1);
INSERT INTO PRODUCTO VALUES (104, 001, 'Carrillada ibérica', 'Carnes', 'Deliciosa carrillada de la península ibérica con salsa', 'Mr. Food', 50, 4.99, 3);
INSERT INTO PRODUCTO VALUES (105, 001, 'Entrecot de ternera', 'Carnes', 'Delicioso entrecot de ternera', 'Mr. Food', 50, 12, 6);
INSERT INTO PRODUCTO VALUES (106, 001, 'Heura con verduras', 'Vegetal', 'Deliciosa carne sintética con sabor a pollo y variado de verduras', 'Heura Food', 75, 7, 3.5);
INSERT INTO PRODUCTO VALUES (107, 001, 'Tortilla de patatas', 'Huevo', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 300, 3, 1.5);
INSERT INTO PRODUCTO VALUES (108, 001, 'Lasaña a la boloñesa', 'Pastas', 'Deliciosa lasaña a la boloñesa', 'La abuela', 300, 3, 1.5);
INSERT INTO PRODUCTO VALUES (109, 001, 'Pizza BBQ medio metro', 'Pizzas', 'Increíble pizza preparada de medio metro BBQ', 'Los pizzeros', 40, 12, 7);
INSERT INTO PRODUCTO VALUES (110, 001, 'Calzone de jamón york y queso', 'Pizzas', 'Calzone al estilo italiano preparado para nuestros clientes más italianos', 'Los pizzeros', 50, 3, 1.5);
INSERT INTO PRODUCTO VALUES (111, 001, 'Gazpacho', 'Vegetal', 'Gran gazpacho andaluz de calidad', 'La abuela', 120, 4, 2);
INSERT INTO PRODUCTO VALUES (112, 001, 'Salmorejo', 'Vegetal', 'Gran salmorejo andaluz de calidad', 'La abuela', 140, 4, 2);
INSERT INTO PRODUCTO VALUES (113, 001, 'Paella', 'Arroz', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 200, 3, 1.5);

INSERT INTO PRODUCTO VALUES (114, 002, 'Alexa', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Amazon', 300, 79.99, 40);
INSERT INTO PRODUCTO VALUES (115, 002, 'Google Home', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Google', 520, 64.99, 36);
INSERT INTO PRODUCTO VALUES (116, 002, 'FIBARO Smart Implant Z-Wave+', 'Sensor', 'Sensor que permite mejorar la funcionalidad de los sensores cableados y otros dispositivos', 'Fibaro', 100, 44.99, 23);
INSERT INTO PRODUCTO VALUES (117, 002, 'IP POE AVTECH DGM1105QS', 'Cámara', 'Cámara IP POE de tipo Bullet (tubular) con visión nocturna de 25m, funcionalidad P2P', 'Avtech', 120, 149.99, 80);
INSERT INTO PRODUCTO VALUES (118, 002, 'IP Home Center 3 de Fibaro Z-Wave', 'Controlador', 'Controlador domótico para la automatización del hogar', 'Fibaro', 50, 599.99, 300);

INSERT INTO PRODUCTO VALUES (119, 003, 'Lirio de la Paz', 'Planta', 'Planta que purifica de forma natural y que desprende elegancia', 'FloraQueen', 80, 39.99, 16);
INSERT INTO PRODUCTO VALUES (120, 003, 'Lengua de Suegra', 'Planta', 'Planta de forma alargada y sus hojas bicolor en forma de espada', 'FloraQueen', 80, 34.99, 12);
INSERT INTO PRODUCTO VALUES (121, 003, 'Árbol de Jade', 'Planta', 'Planta de hojas carnosas y de forma de pequeño arbolito', 'Gardens4you', 90, 13, 5);
INSERT INTO PRODUCTO VALUES (122, 003, 'Anturio rojo', 'Planta', 'Planta muy vista en los hogares para aquellos a quienes les gusta tener flores y color', 'Gardens4you', 60, 34.99, 13);
INSERT INTO PRODUCTO VALUES (123, 003, 'Ficus', 'Planta', 'Planta de las más reconocidas y agradecidas en interiores', 'Gardens4you', 200, 13, 5);

INSERT INTO PRODUCTO VALUES (124, 004, 'Carne picada de ternera', 'Carne para guisar', 'Carne de ternera picada sin especias preparada para guisar', 'MasMit', 40, 9, 5);
INSERT INTO PRODUCTO VALUES (125, 004, 'Rabo de ternera', 'Carne para guisar', 'Rabo de ternera troceado para guisar', 'MasMit', 45, 11.50, 7);
INSERT INTO PRODUCTO VALUES (126, 004, 'Rabillo de ternera', 'Carne para asar', 'Rabillo de ternera preparado para asar', 'MasMit', 50, 12, 6);
INSERT INTO PRODUCTO VALUES (127, 004, 'Morcilla de arroz', 'Carne para BBQ', '3 unidades de morcilla', 'MasMit', 60, 5.9, 3);
INSERT INTO PRODUCTO VALUES (128, 004, 'Muslos de pollo', 'Carne para BBQ', '1 Kg de muslos de pollo', 'MasMit', 60, 6, 3);
INSERT INTO PRODUCTO VALUES (129, 004, 'Chorizo criollo', 'Carne para BBQ', '1 Kg de chorizo criollo', 'MasMit', 60, 8, 3.5);
--2do establecimiento
INSERT INTO PRODUCTO VALUES (201, 005, 'Espaguetis a la carbonara', 'Pastas', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'Mr. Food', 120, 4, 1.5);
INSERT INTO PRODUCTO VALUES (202, 005, 'Espaguetis a la boloñesa', 'Pastas', 'Deliciosos espaguetis preparados a la boloñesa con ternera', 'Mr. Food', 180, 3.25, 1.5);
INSERT INTO PRODUCTO VALUES (203, 005, 'Macarrones al Roquefort', 'Pastas', 'Deliciosos macarrones preparados al roquefort', 'Mr. Food', 160, 3, 1.25);
INSERT INTO PRODUCTO VALUES (204, 005, 'Carrillada ibérica', 'Carnes', 'Deliciosa carrillada de la península ibérica con salsa', 'Mr. Food', 70, 5.1, 2.90);
INSERT INTO PRODUCTO VALUES (205, 005, 'Entrecot de ternera', 'Carnes', 'Delicioso entrecot de ternera', 'Mr. Food', 50, 10, 5);
INSERT INTO PRODUCTO VALUES (206, 005, 'Heura con verduras', 'Vegetal', 'Deliciosa carne sintética con sabor a pollo y variado de verduras', 'Heura Food', 75, 8, 4.5);
INSERT INTO PRODUCTO VALUES (207, 005, 'Tortilla de patatas', 'Huevo', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 300, 4.5, 2.5);
INSERT INTO PRODUCTO VALUES (208, 005, 'Lasaña a la boloñesa', 'Pastas', 'Deliciosa lasaña a la boloñesa', 'La abuela', 300, 3, 1.2);
INSERT INTO PRODUCTO VALUES (209, 005, 'Pizza BBQ medio metro', 'Pizzas', 'Increíble pizza preparada de medio metro BBQ', 'Los pizzeros', 40, 10, 7);
INSERT INTO PRODUCTO VALUES (210, 005, 'Calzone de jamón york y queso', 'Pizzas', 'Calzone al estilo italiano preparado para nuestros clientes más italianos', 'Los pizzeros', 50, 4, 1.5);
INSERT INTO PRODUCTO VALUES (211, 005, 'Gazpacho', 'Vegetal', 'Gran gazpacho andaluz de calidad', 'La abuela', 120, 4, 2);
INSERT INTO PRODUCTO VALUES (212, 005, 'Salmorejo', 'Vegetal', 'Gran salmorejo andaluz de calidad', 'La abuela', 140, 4, 2);
INSERT INTO PRODUCTO VALUES (213, 005, 'Paella', 'Arroz', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 200, 3, 1.5);

INSERT INTO PRODUCTO VALUES (214, 006, 'Alexa', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Amazon', 400, 90, 40);
INSERT INTO PRODUCTO VALUES (215, 006, 'Google Home', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Google', 520, 80, 36);
INSERT INTO PRODUCTO VALUES (216, 006, 'FIBARO Smart Implant Z-Wave+', 'Sensor', 'Sensor que permite mejorar la funcionalidad de los sensores cableados y otros dispositivos', 'Fibaro', 100, 44.99, 23);
INSERT INTO PRODUCTO VALUES (217, 006, 'IP POE AVTECH DGM1105QS', 'Cámara', 'Cámara IP POE de tipo Bullet (tubular) con visión nocturna de 25m, funcionalidad P2P', 'Avtech', 140, 149.99, 80);
INSERT INTO PRODUCTO VALUES (218, 006, 'IP Home Center 3 de Fibaro Z-Wave', 'Controlador', 'Controlador domótico para la automatización del hogar', 'Fibaro', 70, 599.99, 300);

INSERT INTO PRODUCTO VALUES (219, 007, 'Lirio de la Paz', 'Planta', 'Planta que purifica de forma natural y que desprende elegancia', 'FloraQueen', 30, 39.99, 16);
INSERT INTO PRODUCTO VALUES (220, 007, 'Lengua de Suegra', 'Planta', 'Planta de forma alargada y sus hojas bicolor en forma de espada', 'FloraQueen', 30, 34.99, 12);
INSERT INTO PRODUCTO VALUES (221, 007, 'Árbol de Jade', 'Planta', 'Planta de hojas carnosas y de forma de pequeño arbolito', 'Gardens4you', 30, 13, 5);
INSERT INTO PRODUCTO VALUES (222, 007, 'Anturio rojo', 'Planta', 'Planta muy vista en los hogares para aquellos a quienes les gusta tener flores y color', 'Gardens4you', 30, 34.99, 13);
INSERT INTO PRODUCTO VALUES (223, 007, 'Ficus', 'Planta', 'Planta de las más reconocidas y agradecidas en interiores', 'Gardens4you', 30, 13, 5);

INSERT INTO PRODUCTO VALUES (224, 008, 'Carne picada de ternera', 'Carne para guisar', 'Carne de ternera picada sin especias preparada para guisar', 'MasMit', 40, 9, 4);
INSERT INTO PRODUCTO VALUES (225, 008, 'Rabo de ternera', 'Carne para guisar', 'Rabo de ternera troceado para guisar', 'MasMit', 45, 11.50, 5);
INSERT INTO PRODUCTO VALUES (226, 008, 'Rabillo de ternera', 'Carne para asar', 'Rabillo de ternera preparado para asar', 'MasMit', 50, 12, 3);
INSERT INTO PRODUCTO VALUES (227, 008, 'Morcilla de arroz', 'Carne para BBQ', '3 unidades de morcilla', 'MasMit', 60, 5.9, 3);
INSERT INTO PRODUCTO VALUES (228, 008, 'Muslos de pollo', 'Carne para BBQ', '1 Kg de muslos de pollo', 'MasMit', 60, 6, 3);
INSERT INTO PRODUCTO VALUES (229, 008, 'Chorizo criollo', 'Carne para BBQ', '1 Kg de chorizo criollo', 'MasMit', 60, 8, 3.5);
--3er establecimiento
INSERT INTO PRODUCTO VALUES (301, 009, 'Espaguetis a la carbonara', 'Pastas', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'Mr. Food', 100, 3, 1.5);
INSERT INTO PRODUCTO VALUES (302, 009, 'Espaguetis a la boloñesa', 'Pastas', 'Deliciosos espaguetis preparados a la boloñesa con ternera', 'Mr. Food', 100, 2.95, 1.5);
INSERT INTO PRODUCTO VALUES (303, 009, 'Macarrones al Roquefort', 'Pastas', 'Deliciosos macarrones preparados al roquefort', 'Mr. Food', 100, 2.55, 2);
INSERT INTO PRODUCTO VALUES (304, 009, 'Carrillada ibérica', 'Carnes', 'Deliciosa carrillada de la península ibérica con salsa', 'Mr. Food', 50, 4.99, 3);
INSERT INTO PRODUCTO VALUES (305, 009, 'Entrecot de ternera', 'Carnes', 'Delicioso entrecot de ternera', 'Mr. Food', 50, 12, 8);
INSERT INTO PRODUCTO VALUES (306, 009, 'Heura con verduras', 'Vegetal', 'Deliciosa carne sintética con sabor a pollo y variado de verduras', 'Heura Food', 75, 7, 4);
INSERT INTO PRODUCTO VALUES (307, 009, 'Tortilla de patatas', 'Huevo', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 100, 3, 1.5);
INSERT INTO PRODUCTO VALUES (308, 009, 'Lasaña a la boloñesa', 'Pastas', 'Deliciosa lasaña a la boloñesa', 'La abuela', 300, 3, 1.5);
INSERT INTO PRODUCTO VALUES (309, 009, 'Pizza BBQ medio metro', 'Pizzas', 'Increíble pizza preparada de medio metro BBQ', 'Los pizzeros', 40, 12, 7);
INSERT INTO PRODUCTO VALUES (310, 009, 'Calzone de jamón york y queso', 'Pizzas', 'Calzone al estilo italiano preparado para nuestros clientes más italianos', 'Los pizzeros', 50, 3, 1.75);
INSERT INTO PRODUCTO VALUES (311, 009, 'Gazpacho', 'Vegetal', 'Gran gazpacho andaluz de calidad', 'La abuela', 120, 4, 2);
INSERT INTO PRODUCTO VALUES (312, 009, 'Salmorejo', 'Vegetal', 'Gran salmorejo andaluz de calidad', 'La abuela', 140, 4, 2);
INSERT INTO PRODUCTO VALUES (313, 009, 'Paella', 'Arroz', 'Deliciosos espaguetis preparados a la carbonara con bacon', 'La abuela', 200, 3, 1.5);

INSERT INTO PRODUCTO VALUES (314, 010, 'Alexa', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Amazon', 150, 60.99, 20);
INSERT INTO PRODUCTO VALUES (315, 010, 'Google Home', 'Robot', 'Robot que funciona por reconocimiento de voz', 'Google', 120, 54.99, 26);
INSERT INTO PRODUCTO VALUES (316, 010, 'FIBARO Smart Implant Z-Wave+', 'Sensor', 'Sensor que permite mejorar la funcionalidad de los sensores cableados y otros dispositivos', 'Fibaro', 100, 44.99, 23);
INSERT INTO PRODUCTO VALUES (317, 010, 'IP POE AVTECH DGM1105QS', 'Cámara', 'Cámara IP POE de tipo Bullet (tubular) con visión nocturna de 25m, funcionalidad P2P', 'Avtech', 120, 149.99, 80);
INSERT INTO PRODUCTO VALUES (318, 010, 'IP Home Center 3 de Fibaro Z-Wave', 'Controlador', 'Controlador domótico para la automatización del hogar', 'Fibaro', 50, 599.99, 300);

INSERT INTO PRODUCTO VALUES (319, 011, 'Lirio de la Paz', 'Planta', 'Planta que purifica de forma natural y que desprende elegancia', 'FloraQueen', 100, 39.99, 10);
INSERT INTO PRODUCTO VALUES (320, 011, 'Lengua de Suegra', 'Planta', 'Planta de forma alargada y sus hojas bicolor en forma de espada', 'FloraQueen', 180, 34.99, 10);
INSERT INTO PRODUCTO VALUES (321, 011, 'Árbol de Jade', 'Planta', 'Planta de hojas carnosas y de forma de pequeño arbolito', 'Gardens4you', 120, 13, 5);
INSERT INTO PRODUCTO VALUES (322, 011, 'Anturio rojo', 'Planta', 'Planta muy vista en los hogares para aquellos a quienes les gusta tener flores y color', 'Gardens4you', 300, 34.99, 10);
INSERT INTO PRODUCTO VALUES (323, 011, 'Ficus', 'Planta', 'Planta de las más reconocidas y agradecidas en interiores', 'Gardens4you', 200, 13, 5);

INSERT INTO PRODUCTO VALUES (324, 012, 'Carne picada de ternera', 'Carne para guisar', 'Carne de ternera picada sin especias preparada para guisar', 'MasMit', 40, 9, 5);
INSERT INTO PRODUCTO VALUES (325, 012, 'Rabo de ternera', 'Carne para guisar', 'Rabo de ternera troceado para guisar', 'MasMit', 40, 13.50, 8);
INSERT INTO PRODUCTO VALUES (326, 012, 'Rabillo de ternera', 'Carne para asar', 'Rabillo de ternera preparado para asar', 'MasMit', 50, 12, 6);
INSERT INTO PRODUCTO VALUES (327, 012, 'Morcilla de arroz', 'Carne para BBQ', '3 unidades de morcilla', 'MasMit', 90, 5.9, 3);
INSERT INTO PRODUCTO VALUES (328, 012, 'Muslos de pollo', 'Carne para BBQ', '1 Kg de muslos de pollo', 'MasMit', 65, 6, 3);
INSERT INTO PRODUCTO VALUES (329, 012, 'Chorizo criollo', 'Carne para BBQ', '1 Kg de chorizo criollo', 'MasMit', 30, 8, 3.5);

--DATOS COMPRA
INSERT INTO COMPRA VALUES (001, 001, '20/10/2020');
INSERT INTO COMPRA VALUES (002, 001, '20/10/2020');
INSERT INTO COMPRA VALUES (003, 001, '2/11/2020');
INSERT INTO COMPRA VALUES (004, 002, '1/1/2020');
INSERT INTO COMPRA VALUES (005, 002, '5/6/2020');
INSERT INTO COMPRA VALUES (006, 005, '5/6/2020');
INSERT INTO COMPRA VALUES (007, 006, '10/2/2020');
INSERT INTO COMPRA VALUES (008, 006, '30/12/2020');
INSERT INTO COMPRA VALUES (009, 007, '5/8/2020');
INSERT INTO COMPRA VALUES (010, 009, '5/10/2021');
INSERT INTO COMPRA VALUES (011, 009, '22/2/2021');
INSERT INTO COMPRA VALUES (012, 010, '13/6/2021');
INSERT INTO COMPRA VALUES (013, 011, '8/5/2021');
INSERT INTO COMPRA VALUES (014, 012, '26/10/2021');
INSERT INTO COMPRA VALUES (015, 013, '19/1/2021');
INSERT INTO COMPRA VALUES (016, 015, '28/2/2021');
INSERT INTO COMPRA VALUES (017, 016, '1/12/2021');
INSERT INTO COMPRA VALUES (018, 016, '3/3/2021');
INSERT INTO COMPRA VALUES (019, 017, '17/4/2021');
INSERT INTO COMPRA VALUES (020, 018, '14/9/2021');
INSERT INTO COMPRA VALUES (021, 019, '24/8/2019');
INSERT INTO COMPRA VALUES (022, 020, '8/7/2019');
INSERT INTO COMPRA VALUES (023, 021, '6/4/2019');
INSERT INTO COMPRA VALUES (024, 022, '28/2/2019');
INSERT INTO COMPRA VALUES (025, 023, '25/1/2019');
INSERT INTO COMPRA VALUES (026, 024, '16/12/2019');
INSERT INTO COMPRA VALUES (027, 025, '21/3/2019');
INSERT INTO COMPRA VALUES (028, 025, '7/5/2019');
INSERT INTO COMPRA VALUES (029, 026, '2/4/2019');
INSERT INTO COMPRA VALUES (030, 027, '15/9/2019');
INSERT INTO COMPRA VALUES (031, 028, '17/10/2019');
INSERT INTO COMPRA VALUES (032, 029, '21/11/2019');
INSERT INTO COMPRA VALUES (033, 030, '24/5/2019');
INSERT INTO COMPRA VALUES (034, 032, '28/4/2019');
INSERT INTO COMPRA VALUES (035, 032, '11/11/2019');
INSERT INTO COMPRA VALUES (036, 033, '12/12/2019');
INSERT INTO COMPRA VALUES (037, 034, '9/1/2019');
INSERT INTO COMPRA VALUES (038, 034, '2/9/2018');
INSERT INTO COMPRA VALUES (039, 034, '6/8/2018');
INSERT INTO COMPRA VALUES (040, 034, '13/10/2018');
INSERT INTO COMPRA VALUES (041, 035, '20/4/2018');

--DATOS PEDIDO
INSERT INTO PEDIDO VALUES (001, 002, '2/1/2020', '5/1/2020');
INSERT INTO PEDIDO VALUES (002, 002, '10/11/2020', '15/11/2020');
INSERT INTO PEDIDO VALUES (003, 003, '20/7/2020', '22/8/2020');
INSERT INTO PEDIDO VALUES (004, 003, '10/6/2020', '11/6/2020');
INSERT INTO PEDIDO VALUES (005, 003, '4/8/2020', '6/8/2020');
INSERT INTO PEDIDO VALUES (006, 004, '10/12/2020', '12/11/2020');
INSERT INTO PEDIDO VALUES (007, 004, '11/2/2020', '12/2/2020');
INSERT INTO PEDIDO VALUES (008, 004, '20/12/2020', '22/12/2020');
INSERT INTO PEDIDO VALUES (009, 008, '2/8/2020', '9/8/2020');
INSERT INTO PEDIDO VALUES (010, 008, '5/10/2021', '12/10/2021');
INSERT INTO PEDIDO VALUES (011, 009, '22/2/2021', '9/3/2021');
INSERT INTO PEDIDO VALUES (012, 012, '3/6/2021', '6/6/2021');
INSERT INTO PEDIDO VALUES (013, 012, '4/6/2021', '9/6/2021');
INSERT INTO PEDIDO VALUES (014, 013, '24/1/2021', '29/1/2021');
INSERT INTO PEDIDO VALUES (015, 016, '20/8/2021', '21/8/2021');
INSERT INTO PEDIDO VALUES (016, 016, '28/7/2021', '4/8/2021');
INSERT INTO PEDIDO VALUES (017, 016, '1/9/2021', '4/9/2021');
INSERT INTO PEDIDO VALUES (018, 017, '13/11/2021', '14/11/2021');
INSERT INTO PEDIDO VALUES (019, 017, '7/12/2021', '9/12/2021');
INSERT INTO PEDIDO VALUES (020, 019, '4/11/2021', '9/11/2021');
INSERT INTO PEDIDO VALUES (021, 019, '24/4/2019', '26/5/2019');
INSERT INTO PEDIDO VALUES (022, 021, '18/3/2019', '1/4/2019');
INSERT INTO PEDIDO VALUES (023, 021, '16/7/2019', '20/7/2019');
INSERT INTO PEDIDO VALUES (024, 024, '19/3/2019', '22/3/2019');
INSERT INTO PEDIDO VALUES (025, 024, '5/5/2019', '15/5/2019');
INSERT INTO PEDIDO VALUES (026, 024, '6/12/2019', '9/12/2019');
INSERT INTO PEDIDO VALUES (027, 025, '11/5/2019', '11/5/2019');
INSERT INTO PEDIDO VALUES (028, 025, '17/6/2019', '19/6/2019');
INSERT INTO PEDIDO VALUES (029, 026, '23/2/2019', '26/2/2019');
INSERT INTO PEDIDO VALUES (030, 027, '14/9/2019', '16/9/2019');
INSERT INTO PEDIDO VALUES (031, 028, '11/8/2019', '16/8/2019');
INSERT INTO PEDIDO VALUES (032, 028, '11/12/2019', '18/12/2019');
INSERT INTO PEDIDO VALUES (033, 031, '24/2/2019', '25/2/2019');
INSERT INTO PEDIDO VALUES (034, 031, '28/8/2019', '29/8/2019');
INSERT INTO PEDIDO VALUES (035, 031, '9/1/2019', '10/1/2019');
INSERT INTO PEDIDO VALUES (036, 031, '22/10/2019', '22/10/2019');
INSERT INTO PEDIDO VALUES (037, 031, '9/9/2019', '9/9/2019');
INSERT INTO PEDIDO VALUES (038, 032, '1/4/2018', '1/4/2018');
INSERT INTO PEDIDO VALUES (039, 032, '6/5/2018', '6/5/2018');
INSERT INTO PEDIDO VALUES (040, 034, '23/1/2020', '23/1/2018');
INSERT INTO PEDIDO VALUES (041, 035, '10/2/2018', '10/2/2018');


--DATOS DETALLE_COMPRA
INSERT INTO DETALLE_COMPRA VALUES (001, 101, 4, 3);
INSERT INTO DETALLE_COMPRA VALUES (002, 105, 10, 12);
INSERT INTO DETALLE_COMPRA VALUES (003, 120, 1, 34.99);
INSERT INTO DETALLE_COMPRA VALUES (004, 112, 1, 4);
INSERT INTO DETALLE_COMPRA VALUES (005, 119, 1, 39.99);
INSERT INTO DETALLE_COMPRA VALUES (006, 105, 2, 12);
INSERT INTO DETALLE_COMPRA VALUES (007, 109, 2, 12);
INSERT INTO DETALLE_COMPRA VALUES (008, 112, 1, 4);
INSERT INTO DETALLE_COMPRA VALUES (009, 101, 2, 3);
INSERT INTO DETALLE_COMPRA VALUES (010, 124, 4, 9);
INSERT INTO DETALLE_COMPRA VALUES (011, 128, 2, 6);
INSERT INTO DETALLE_COMPRA VALUES (012, 129, 3, 8);
INSERT INTO DETALLE_COMPRA VALUES (013, 114, 1, 79.99);
INSERT INTO DETALLE_COMPRA VALUES (014, 124, 2, 40);

INSERT INTO DETALLE_COMPRA VALUES (015, 202, 2, 3.25);
INSERT INTO DETALLE_COMPRA VALUES (016, 208, 4, 3);
INSERT INTO DETALLE_COMPRA VALUES (017, 226, 2, 44.99);
INSERT INTO DETALLE_COMPRA VALUES (018, 219, 1, 39.99);
INSERT INTO DETALLE_COMPRA VALUES (019, 220, 3, 34.99);
INSERT INTO DETALLE_COMPRA VALUES (020, 204, 2, 5.1);
INSERT INTO DETALLE_COMPRA VALUES (021, 209, 1, 10);
INSERT INTO DETALLE_COMPRA VALUES (022, 227, 1, 5.9);
INSERT INTO DETALLE_COMPRA VALUES (023, 226, 2, 12);
INSERT INTO DETALLE_COMPRA VALUES (024, 228, 1, 6);
INSERT INTO DETALLE_COMPRA VALUES (025, 207, 2, 4.5);
INSERT INTO DETALLE_COMPRA VALUES (026, 210, 3, 4);

INSERT INTO DETALLE_COMPRA VALUES (027, 302, 2.95, 2);
INSERT INTO DETALLE_COMPRA VALUES (028, 301, 3, 1);
INSERT INTO DETALLE_COMPRA VALUES (029, 308, 3, 1);
INSERT INTO DETALLE_COMPRA VALUES (030, 309, 12, 3);
INSERT INTO DETALLE_COMPRA VALUES (031, 310, 3, 2);
INSERT INTO DETALLE_COMPRA VALUES (032, 312, 4, 1);
INSERT INTO DETALLE_COMPRA VALUES (033, 315, 54.99, 2);
INSERT INTO DETALLE_COMPRA VALUES (034, 318, 599.99, 1);
INSERT INTO DETALLE_COMPRA VALUES (035, 319, 39.99, 2);
INSERT INTO DETALLE_COMPRA VALUES (036, 320, 34.99, 2);
INSERT INTO DETALLE_COMPRA VALUES (037, 325, 13.5, 1);
INSERT INTO DETALLE_COMPRA VALUES (038, 326, 12, 2);
INSERT INTO DETALLE_COMPRA VALUES (039, 328, 6, 3);
INSERT INTO DETALLE_COMPRA VALUES (040, 329, 8, 4);
INSERT INTO DETALLE_COMPRA VALUES (041, 312, 8, 4);

--DATOS DETALLE_PEDIDO
INSERT INTO DETALLE_PEDIDO VALUES (001, 102, 2.95, 3);
INSERT INTO DETALLE_PEDIDO VALUES (002, 106, 7, 12);
INSERT INTO DETALLE_PEDIDO VALUES (003, 120, 1, 34.99);
INSERT INTO DETALLE_PEDIDO VALUES (004, 113, 3, 4);
INSERT INTO DETALLE_PEDIDO VALUES (005, 121, 13, 39.99);
INSERT INTO DETALLE_PEDIDO VALUES (006, 105, 2, 12);
INSERT INTO DETALLE_PEDIDO VALUES (007, 109, 2, 12);
INSERT INTO DETALLE_PEDIDO VALUES (008, 112, 1, 4);
INSERT INTO DETALLE_PEDIDO VALUES (009, 101, 2, 3);
INSERT INTO DETALLE_PEDIDO VALUES (010, 124, 4, 9);
INSERT INTO DETALLE_PEDIDO VALUES (011, 128, 2, 6);
INSERT INTO DETALLE_PEDIDO VALUES (012, 116, 44.99, 8);
INSERT INTO DETALLE_PEDIDO VALUES (013, 112, 4, 79.99);

INSERT INTO DETALLE_PEDIDO VALUES (014, 202, 2, 3.25);
INSERT INTO DETALLE_PEDIDO VALUES (015, 202, 2, 3.25);
INSERT INTO DETALLE_PEDIDO VALUES (016, 208, 4, 3);
INSERT INTO DETALLE_PEDIDO VALUES (017, 226, 2, 44.99);
INSERT INTO DETALLE_PEDIDO VALUES (018, 219, 1, 39.99);
INSERT INTO DETALLE_PEDIDO VALUES (019, 220, 3, 34.99);
INSERT INTO DETALLE_PEDIDO VALUES (020, 204, 2, 5.1);
INSERT INTO DETALLE_PEDIDO VALUES (021, 209, 1, 10);
INSERT INTO DETALLE_PEDIDO VALUES (022, 227, 1, 5.9);
INSERT INTO DETALLE_PEDIDO VALUES (023, 226, 2, 12);
INSERT INTO DETALLE_PEDIDO VALUES (024, 228, 1, 6);
INSERT INTO DETALLE_PEDIDO VALUES (025, 207, 2, 4.5);
INSERT INTO DETALLE_PEDIDO VALUES (026, 210, 3, 4);

INSERT INTO DETALLE_PEDIDO VALUES (027, 302, 2.95, 2);
INSERT INTO DETALLE_PEDIDO VALUES (028, 301, 3, 1);
INSERT INTO DETALLE_PEDIDO VALUES (029, 308, 3, 1);
INSERT INTO DETALLE_PEDIDO VALUES (030, 309, 12, 3);
INSERT INTO DETALLE_PEDIDO VALUES (031, 310, 3, 2);
INSERT INTO DETALLE_PEDIDO VALUES (032, 312, 4, 1);
INSERT INTO DETALLE_PEDIDO VALUES (033, 315, 54.99, 2);
INSERT INTO DETALLE_PEDIDO VALUES (034, 318, 599.99, 1);
INSERT INTO DETALLE_PEDIDO VALUES (035, 319, 39.99, 2);
INSERT INTO DETALLE_PEDIDO VALUES (036, 320, 34.99, 2);
INSERT INTO DETALLE_PEDIDO VALUES (037, 325, 13.5, 1);
INSERT INTO DETALLE_PEDIDO VALUES (038, 326, 12, 2);
INSERT INTO DETALLE_PEDIDO VALUES (039, 328, 6, 3);
INSERT INTO DETALLE_PEDIDO VALUES (040, 329, 8, 4);
INSERT INTO DETALLE_PEDIDO VALUES (041, 312, 8, 4);

COMMIT;