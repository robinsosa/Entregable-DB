CREATE TABLE ECOM_CATEGORIA 
    ( 
     ID_Categoria      INTEGER  NOT NULL , 
     Nombre_Categoria  NVARCHAR2 (99)  NOT NULL , 
     Descripcion_Categ NVARCHAR2 (200) 
    ) 
;

ALTER TABLE ECOM_CATEGORIA 
    ADD CONSTRAINT ECOM_CATEGORIA_PK PRIMARY KEY ( ID_Categoria ) ;

CREATE TABLE ECOM_CLIENTE 
    ( 
     ID_Cliente       INTEGER  NOT NULL , 
     Nombre_Cliente   NVARCHAR2 (50)  NOT NULL , 
     Apellido_Cliente NVARCHAR2 (60)  NOT NULL , 
     Email            NVARCHAR2 (100)  NOT NULL , 
     Direccion        NVARCHAR2 (100)  NOT NULL , 
     Telefono         NCHAR (12)  NOT NULL , 
     Fecha_registro   DATE  NOT NULL 
    ) 
;

ALTER TABLE ECOM_CLIENTE 
    ADD CONSTRAINT ECOM_CLIENTE_PK PRIMARY KEY ( ID_Cliente ) ;

CREATE TABLE ECOM_PROVEEDOR 
    ( 
     ID_Proveedor     INTEGER  NOT NULL , 
     Nombre_Proveedor NVARCHAR2 (100)  NOT NULL , 
     Contacto         NVARCHAR2 (100) , 
     Telefono         NCHAR (12) , 
     Email            NVARCHAR2 (100) , 
     Direccion        NVARCHAR2 (200) 
    ) 
;

ALTER TABLE ECOM_PROVEEDOR 
    ADD CONSTRAINT ECOM_PROVEEDOR_PK PRIMARY KEY ( ID_Proveedor ) ;

CREATE TABLE ECOM_EMPLEADO 
    ( 
     ID_Empleado        INTEGER  NOT NULL , 
     Nombre_Empleado    NVARCHAR2 (50)  NOT NULL , 
     Apellido_Empleado  NVARCHAR2 (60)  NOT NULL , 
     Cargo              NVARCHAR2 (50) , 
     Salario            NUMBER (10,2) , 
     Fecha_Contratacion DATE , 
     Departamento       NVARCHAR2 (50) 
    ) 
;

ALTER TABLE ECOM_EMPLEADO 
    ADD CONSTRAINT ECOM_EMPLEADO_PK PRIMARY KEY ( ID_Empleado ) ;

CREATE TABLE ECOM_METODO_PAGO 
    ( 
     ID_Metodo_Pago INTEGER  NOT NULL , 
     Nombre_Metodo  NVARCHAR2 (50)  NOT NULL , 
     Descripcion    NVARCHAR2 (200) 
    ) 
;

ALTER TABLE ECOM_METODO_PAGO 
    ADD CONSTRAINT ECOM_METODO_PAGO_PK PRIMARY KEY ( ID_Metodo_Pago ) ;


CREATE TABLE ECOM_PRODUCTO 
    ( 
     ID_Producto                 INTEGER  NOT NULL , 
     ECOM_CATEGORIA_ID_Categoria INTEGER  NOT NULL , 
     ECOM_PROVEEDOR_ID_Proveedor INTEGER  NOT NULL , 
     Nombre_Producto             NVARCHAR2 (150)  NOT NULL , 
     Descripcion                 NVARCHAR2 (200) , 
     Precio                      NUMBER (10,2)  NOT NULL , 
     Marca                       NVARCHAR2 (50) 
    ) 
;

ALTER TABLE ECOM_PRODUCTO 
    ADD CONSTRAINT ECOM_PRODUCTO_PK PRIMARY KEY ( ID_Producto ) ;

CREATE TABLE ECOM_PEDIDO 
    ( 
     ID_Pedido               INTEGER  NOT NULL , 
     ECOM_CLIENTE_ID_Cliente INTEGER  NOT NULL , 
     ECOM_METODO_PAGO_ID_Metodo_Pago INTEGER NOT NULL , 
     Fecha_Pedido            DATE  NOT NULL , 
     Total                   NUMBER (10,2)  NOT NULL , 
     Estado                  NVARCHAR2 (20)  NOT NULL 
    ) 
;

ALTER TABLE ECOM_PEDIDO 
    ADD CONSTRAINT ECOM_PEDIDO_PK PRIMARY KEY ( ID_Pedido ) ;

CREATE TABLE ECOM_FACTURA 
    ( 
     ID_Factura               INTEGER  NOT NULL , 
     ECOM_PEDIDO_ID_Pedido    INTEGER  NOT NULL , 
     Fecha_Factura            DATE  NOT NULL , 
     Subtotal                 NUMBER (10,2) , 
     IGV                      NUMBER (10,2) , 
     Total                    NUMBER (10,2) , 
     Estado                   NVARCHAR2 (20) 
    ) 
;

ALTER TABLE ECOM_FACTURA 
    ADD CONSTRAINT ECOM_FACTURA_PK PRIMARY KEY ( ID_Factura ) ;

CREATE TABLE ECOM_ENVIO 
    ( 
     ID_Envio               INTEGER  NOT NULL , 
     ECOM_PEDIDO_ID_Pedido  INTEGER  NOT NULL , 
     Direccion_Envio        NVARCHAR2 (200)  NOT NULL , 
     Fecha_Envio            DATE , 
     Fecha_Entrega_Estimada DATE , 
     Estado_Envio           NVARCHAR2 (20) , 
     Transportista          NVARCHAR2 (50) , 
     Numero_Guia            NVARCHAR2 (50) 
    ) 
;

ALTER TABLE ECOM_ENVIO 
    ADD CONSTRAINT ECOM_ENVIO_PK PRIMARY KEY ( ID_Envio ) ;


CREATE TABLE ECOM_RESENA 
    ( 
     ID_Resena                INTEGER  NOT NULL , 
     ECOM_CLIENTE_ID_Cliente  INTEGER  NOT NULL , 
     ECOM_PRODUCTO_ID_Producto INTEGER NOT NULL , 
     Calificacion             INTEGER  NOT NULL , 
     Comentario               NVARCHAR2 (500) , 
     Fecha_Resena             DATE 
    ) 
;

ALTER TABLE ECOM_RESENA 
    ADD CONSTRAINT ECOM_RESENA_PK PRIMARY KEY ( ID_Resena ) ;

CREATE TABLE ECOM_DETAL_PEDI 
    ( 
     ID_Detalle                INTEGER  NOT NULL , 
     ECOM_PEDIDO_ID_Pedido     INTEGER  NOT NULL , 
     ECOM_PRODUCTO_ID_Producto INTEGER  NOT NULL , 
     Cantidad                  INTEGER  NOT NULL , 
     Precio_Unitario           NUMBER (10,2)  NOT NULL , 
     Sub_Total                 NUMBER (10,2)  NOT NULL 
    ) 
;

ALTER TABLE ECOM_DETAL_PEDI 
    ADD CONSTRAINT ECOM_DETAL_PEDI_PK PRIMARY KEY ( ID_Detalle ) ;


CREATE TABLE ECOM_INVENTARIO 
    ( 
     ID_Inventario             INTEGER  NOT NULL , 
     ECOM_PRODUCTO_ID_Producto INTEGER  NOT NULL , 
     Cantidad_Disponible       INTEGER  NOT NULL , 
     Stock_Minimo              INTEGER  NOT NULL 
    ) 
;

CREATE UNIQUE INDEX ECOM_INVENTARIO__IDX ON ECOM_INVENTARIO 
    ( 
     ECOM_PRODUCTO_ID_Producto ASC 
    ) 
;

ALTER TABLE ECOM_INVENTARIO 
    ADD CONSTRAINT ECOM_INVENTAR_PK PRIMARY KEY ( ID_Inventario ) ;

ALTER TABLE ECOM_DETAL_PEDI 
    ADD CONSTRAINT ECOM_DETAL_PEDI_ECOM_PEDID_FK FOREIGN KEY 
    ( 
     ECOM_PEDIDO_ID_Pedido
    ) 
    REFERENCES ECOM_PEDIDO 
    ( 
     ID_Pedido
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_DETAL_PEDI 
    ADD CONSTRAINT ECOM_DETAL_PEDID_ECOM_PRODU_FK FOREIGN KEY 
    ( 
     ECOM_PRODUCTO_ID_Producto
    ) 
    REFERENCES ECOM_PRODUCTO 
    ( 
     ID_Producto
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_INVENTARIO 
    ADD CONSTRAINT ECOM_INVENT_ECOM_PRODU_FK FOREIGN KEY 
    ( 
     ECOM_PRODUCTO_ID_Producto
    ) 
    REFERENCES ECOM_PRODUCTO 
    ( 
     ID_Producto
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_PEDIDO 
    ADD CONSTRAINT ECOM_PEDIDO_ECOM_CLIENTE_FK FOREIGN KEY 
    ( 
     ECOM_CLIENTE_ID_Cliente
    ) 
    REFERENCES ECOM_CLIENTE 
    ( 
     ID_Cliente
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_PRODUCTO 
    ADD CONSTRAINT ECOM_PRODU_ECOM_CATEG_FK FOREIGN KEY 
    ( 
     ECOM_CATEGORIA_ID_Categoria
    ) 
    REFERENCES ECOM_CATEGORIA 
    ( 
     ID_Categoria
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_PRODUCTO 
    ADD CONSTRAINT ECOM_PROD_PROVEEDOR_FK FOREIGN KEY 
    ( 
     ECOM_PROVEEDOR_ID_Proveedor
    ) 
    REFERENCES ECOM_PROVEEDOR 
    ( 
     ID_Proveedor
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_PEDIDO 
    ADD CONSTRAINT ECOM_PED_METODO_PAGO_FK FOREIGN KEY 
    ( 
     ECOM_METODO_PAGO_ID_Metodo_Pago
    ) 
    REFERENCES ECOM_METODO_PAGO 
    ( 
     ID_Metodo_Pago
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_FACTURA 
    ADD CONSTRAINT ECOM_FACTURA_PEDIDO_FK FOREIGN KEY 
    ( 
     ECOM_PEDIDO_ID_Pedido
    ) 
    REFERENCES ECOM_PEDIDO 
    ( 
     ID_Pedido
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_ENVIO 
    ADD CONSTRAINT ECOM_ENVIO_PEDIDO_FK FOREIGN KEY 
    ( 
     ECOM_PEDIDO_ID_Pedido
    ) 
    REFERENCES ECOM_PEDIDO 
    ( 
     ID_Pedido
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_RESENA 
    ADD CONSTRAINT ECOM_RESENA_CLIENTE_FK FOREIGN KEY 
    ( 
     ECOM_CLIENTE_ID_Cliente
    ) 
    REFERENCES ECOM_CLIENTE 
    ( 
     ID_Cliente
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_RESENA 
    ADD CONSTRAINT ECOM_RESENA_PRODUCTO_FK FOREIGN KEY 
    ( 
     ECOM_PRODUCTO_ID_Producto
    ) 
    REFERENCES ECOM_PRODUCTO 
    ( 
     ID_Producto
    ) 
    ON DELETE CASCADE 
;

ALTER TABLE ECOM_RESENA 
    ADD CONSTRAINT CHK_CALIFICACION CHECK (Calificacion BETWEEN 1 AND 5);

-- CONTINUAMOS
-- CREACION DE SECUENCIAS
DROP SEQUENCE seq_ecom_cliente;
CREATE SEQUENCE seq_ecom_cliente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_categoria START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_producto START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_pedido START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_detal_pedi START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_inventario START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_proveedor START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_empleado START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_metodo_pago START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_factura START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_envio START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_ecom_resena START WITH 1 INCREMENT BY 1;

-- 1 TABLA CLIENTES
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Yulion', 'Olivares', 'yulionoliva@gmail.com', 'Monte-castillo', '922319227', DATE '2024-01-15');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Jerson', 'More', 'jersonmore@gmail.com', 'Paita', '902513636', DATE '2024-01-05');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Lenna', 'Ezpinoza', 'lennaezpinoza@gmail.com', 'Castilla', '922852589', DATE '2023-12-18');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Marcos', 'Ramos', 'marcosramos@gmail.com', 'Catacaos', '951236487', DATE '2024-01-22');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Lucía', 'Vargas', 'lucia.vargas@gmail.com', 'Sullana', '902456785', DATE '2023-11-03');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Kevin', 'Silva', 'kevinsilva@gmail.com', 'Talara', '981234569', DATE '2024-01-12');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'María', 'Chunga', 'mariachunga@gmail.com', 'Sechura', '912345678', DATE '2024-01-27');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Bryan', 'Rojas', 'bryanrojas@gmail.com', 'La Unión', '956478213', DATE '2024-01-14');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Fiorella', 'Calle', 'fiorellacalle@gmail.com', 'Tambogrande', '987654321', DATE '2024-01-09');
INSERT INTO ECOM_CLIENTE VALUES (seq_ecom_cliente.Nextval, 'Anthony', 'Cornejo', 'anthonycornejo@gmail.com', 'Las Lomas', '924785612', DATE '2024-01-30');

-- 2 TABLA DE CATEGORIA
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Accesorios', 'Accesorios para móviles, ordenadores, y otros dispositivos.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Smartphones', 'Teléfonos inteligentes de última generación con sistemas Android e iOS.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Computadoras y Laptops', 'Equipos de escritorio y portátiles para trabajo, estudio y gaming.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Periféricos', 'Teclados, ratones, cámaras y otros accesorios de entrada y salida.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Almacenamiento', 'Discos duros, memorias USB, SSD y soluciones de almacenamiento externo.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Audio y Sonido', 'Audífonos, parlantes, micrófonos y sistemas de sonido profesionales.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Redes y Conectividad', 'Routers, cables, antenas y equipos para conexión a internet.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Gadgets y Wearables', 'Dispositivos inteligentes como relojes, pulseras y gafas electrónicas.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Componentes de PC', 'Procesadores, tarjetas madre, memorias RAM, fuentes y tarjetas gráficas.');
INSERT INTO ECOM_CATEGORIA VALUES (seq_ecom_categoria.Nextval, 'Software y Licencias', 'Sistemas operativos, suites de oficina y programas de seguridad.');

-- 3 TABLA DE PROVEEDORES
INSERT INTO ECOM_PROVEEDOR VALUES (seq_ecom_proveedor.Nextval, 'TecnoImport S.A.', 'Carlos Rojas', '014567890', 'ventas@tecnoimport.com', 'Av. Industrial 123, Lima');
INSERT INTO ECOM_PROVEEDOR VALUES (seq_ecom_proveedor.Nextval, 'ElectroWorld', 'María Torres', '014567891', 'contacto@electroworld.com', 'Jr. Electronics 456, Arequipa');
INSERT INTO ECOM_PROVEEDOR VALUES (seq_ecom_proveedor.Nextval, 'Distribuidora Tech', 'Roberto Silva', '014567892', 'info@techdist.com', 'Av. Tecnología 789, Trujillo');
INSERT INTO ECOM_PROVEEDOR VALUES (seq_ecom_proveedor.Nextval, 'Gadgets & More', 'Laura Mendoza', '014567893', 'ventas@gadgetsmore.com', 'Calle Innovación 321, Piura');
INSERT INTO ECOM_PROVEEDOR VALUES (seq_ecom_proveedor.Nextval, 'Digital Solutions', 'Javier López', '014567894', 'contact@digitalsolutions.com', 'Av. Digital 654, Chiclayo');

-- 4 TABLA DE PRODUCTOS
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 1, 1, 'Audífonos Bluetooth', 'Audífonos inalámbricos con cancelación de ruido', 150.00, 'Sony');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 2, 2, 'iPhone 15 Pro', 'Smartphone Apple 256GB', 4200.00, 'Apple');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 3, 3, 'Laptop Gaming', 'Laptop i7, 16GB RAM, RTX 4060', 3800.00, 'ASUS');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 4, 1, 'Disco SSD 1TB', 'Unidad de estado sólido NVMe ultrarrápida', 420.00, 'Kingston');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 5, 4, 'Mouse Gamer RGB', 'Ratón ergonómico con iluminación y sensor de alta precisión', 120.00, 'Logitech');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 6, 5, 'Parlante Portátil', 'Altavoz Bluetooth resistente al agua con sonido 360°', 250.00, 'JBL');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 7, 2, 'Router Wi-Fi 6', 'Router de doble banda con alta velocidad y amplio alcance', 380.00, 'TP-Link');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 8, 3, 'Smartwatch Deportivo', 'Reloj inteligente con GPS, monitor de ritmo cardíaco y oxígeno', 300.00, 'Huawei');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 9, 4, 'Tarjeta Gráfica RTX 4070', 'GPU de alto rendimiento para gaming y diseño 3D', 5200.00, 'NVIDIA');
INSERT INTO ECOM_PRODUCTO VALUES (seq_ecom_producto.Nextval, 10, 5, 'Memoria RAM 32GB DDR5', 'Módulo de memoria de alto rendimiento para PCs y laptops', 650.00, 'Corsair');

-- 5 TABLA DE MÉTODOS DE PAGO
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Tarjeta de Crédito', 'Pago con tarjeta de crédito Visa/Mastercard');
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Tarjeta de Débito', 'Pago con tarjeta de débito');
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Transferencia Bancaria', 'Transferencia interbancaria');
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Yape', 'Pago mediante Yape');
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Plin', 'Pago mediante Plin');
INSERT INTO ECOM_METODO_PAGO VALUES (seq_ecom_metodo_pago.Nextval, 'Efectivo', 'Pago en efectivo al momento de la entrega');

-- 6 TABLA DE PEDIDOS
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 1, 1, DATE '2024-01-15', 99.9, 'Proceso...');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 2, 2, DATE '2024-01-16', 4200.0, 'Entregado');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 3, 3, DATE '2024-01-17', 300.0, 'En camino');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 4, 1, DATE '2024-01-18', 3800.0, 'Pendiente');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 5, 4, DATE '2024-01-19', 120.0, 'Proceso...');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 6, 5, DATE '2024-01-20', 180.0, 'Entregado');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 7, 6, DATE '2024-01-21', 220.0, 'En camino');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 8, 2, DATE '2024-01-22', 350.0, 'Pendiente');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 9, 3, DATE '2024-01-23', 45.0, 'Proceso...');
INSERT INTO ECOM_PEDIDO VALUES (seq_ecom_pedido.Nextval, 10, 1, DATE '2024-01-24', 250.0, 'Entregado');

-- 7 TABLA DE DETALLES DE PEDIDO
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 1, 1, 1, 99.9, 99.9);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 2, 2, 1, 4200.0, 4200.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 3, 4, 2, 150.0, 300.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 4, 3, 1, 3800.0, 3800.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 5, 5, 1, 120.0, 120.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 6, 7, 1, 180.0, 180.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 7, 8, 1, 220.0, 220.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 8, 9, 1, 350.0, 350.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 9, 10, 1, 45.0, 45.0);
INSERT INTO ECOM_DETAL_PEDI VALUES (seq_ecom_detal_pedi.Nextval, 10, 6, 1, 250.0, 250.0);
SELECT *FROM ECOM_DETAL_PEDI;
-- 8 TABLA DE INVENTARIO
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 1, 50, 10);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 2, 25, 5);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 3, 15, 3);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 4, 100, 20);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 5, 30, 8);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 6, 40, 12);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 7, 60, 15);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 8, 20, 5);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 9, 35, 10);
INSERT INTO ECOM_INVENTARIO VALUES (seq_ecom_inventario.Nextval, 10, 80, 25);

-- 9- TABLA DE EMPLEADOS
INSERT INTO ECOM_EMPLEADO VALUES (seq_ecom_empleado.Nextval, 'Ana', 'García', 'Gerente de Ventas', 3500.00, DATE '2022-03-15', 'Ventas');
INSERT INTO ECOM_EMPLEADO VALUES (seq_ecom_empleado.Nextval, 'Luis', 'Martínez', 'Asistente de Almacén', 1800.00, DATE '2023-01-20', 'Almacén');
INSERT INTO ECOM_EMPLEADO VALUES (seq_ecom_empleado.Nextval, 'Carmen', 'Díaz', 'Especialista en Soporte', 2800.00, DATE '2022-08-10', 'Soporte');
INSERT INTO ECOM_EMPLEADO VALUES (seq_ecom_empleado.Nextval, 'Pedro', 'Castillo', 'Coordinador de Envíos', 2200.00, DATE '2023-03-05', 'Logística');
INSERT INTO ECOM_EMPLEADO VALUES (seq_ecom_empleado.Nextval, 'Sofía', 'Quiroga', 'Analista de Marketing', 2600.00, DATE '2022-11-12', 'Marketing');

-- 10 TABLA DE FACTURAS
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 1, DATE '2024-01-15', 84.66, 15.24, 99.9, 'Emitida');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 2, DATE '2024-01-16', 3559.32, 640.68, 4200.0, 'Pagada');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 3, DATE '2024-01-17', 254.24, 45.76, 300.0, 'Pagada');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 4, DATE '2024-01-18', 3220.34, 579.66, 3800.0, 'Pendiente');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 5, DATE '2024-01-19', 101.69, 18.31, 120.0, 'Emitida');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 6, DATE '2024-01-20', 152.54, 27.46, 180.0, 'Pagada');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 7, DATE '2024-01-21', 186.44, 33.56, 220.0, 'Emitida');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 8, DATE '2024-01-22', 296.61, 53.39, 350.0, 'Pendiente');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 9, DATE '2024-01-23', 38.14, 6.86, 45.0, 'Emitida');
INSERT INTO ECOM_FACTURA VALUES (seq_ecom_factura.Nextval, 10, DATE '2024-01-24', 211.86, 38.14, 250.0, 'Pagada');

-- 11 TABLA DE ENVÍOS
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 1, 'Monte-castillo/28-de-junio', DATE '2024-01-16', DATE '2024-01-18', 'En preparación', 'Serpost', 'TRK00123456');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 2, 'Paita/Av. Principal 123', DATE '2024-01-17', DATE '2024-01-19', 'Entregado', 'Olva Courier', 'TRK00234567');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 3, 'Castilla/Calle Los Olivos 456', DATE '2024-01-18', DATE '2024-01-20', 'En camino', 'DHL', 'TRK00345678');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 4, 'Catacaos/Urb. San Juan 789', NULL, DATE '2024-01-25', 'Pendiente', 'Serpost', 'TRK00456789');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 5, 'Sullana/Av. Panamericana 101', DATE '2024-01-20', DATE '2024-01-22', 'En preparación', 'Olva Courier', 'TRK00567890');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 6, 'Talara/Calle Petrolera 202', DATE '2024-01-21', DATE '2024-01-23', 'Entregado', 'DHL', 'TRK00678901');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 7, 'Sechura/Plaza Central 303', DATE '2024-01-22', DATE '2024-01-24', 'En camino', 'Serpost', 'TRK00789012');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 8, 'La Unión/Av. Unión 404', NULL, DATE '2024-01-26', 'Pendiente', 'Olva Courier', 'TRK00890123');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 9, 'Tambogrande/Calle Principal 505', DATE '2024-01-24', DATE '2024-01-26', 'En preparación', 'DHL', 'TRK00901234');
INSERT INTO ECOM_ENVIO VALUES (seq_ecom_envio.Nextval, 10, 'Las Lomas/Av. Central 606', DATE '2024-01-25', DATE '2024-01-27', 'Entregado', 'Serpost', 'TRK01012345');

-- 12 TABLA DE RESEÑAS
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 1, 1, 5, 'Excelentes audífonos, la cancelación de ruido funciona perfectamente', DATE '2024-01-20');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 2, 2, 4, 'Buen smartphone, pero el precio es algo elevado', DATE '2024-01-22');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 3, 1, 5, 'Segunda compra de estos audífonos, lo recomiendo totalmente', DATE '2024-01-25');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 4, 3, 5, 'La laptop es una bestia para gaming, muy satisfecho', DATE '2024-01-26');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 5, 5, 4, 'Buen mouse, comfortable para largas sesiones de juego', DATE '2024-01-27');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 6, 7, 3, 'El router funciona bien, pero la señal no es muy estable', DATE '2024-01-28');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 7, 8, 5, 'El smartwatch superó mis expectativas, excelente compra', DATE '2024-01-29');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 8, 9, 5, 'Tarjeta gráfica increíble, corre todos los juegos en ultra', DATE '2024-01-30');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 9, 10, 4, 'Buena memoria RAM, mejora notable el rendimiento', DATE '2024-01-31');
INSERT INTO ECOM_RESENA VALUES (seq_ecom_resena.Nextval, 10, 6, 5, 'El parlante tiene un sonido excelente y es muy portátil', DATE '2024-02-01');
select * from ECOM_RESENA
-- CONSULTAS QUE PIDEN
-- CONSULTA 1: PRODUCTOS MAS VENVIDOS 
SELECT 
    p.Nombre_Producto,
    p.Marca,
    SUM(dp.Cantidad) as Total_Vendido,
    SUM(dp.Sub_Total) as Ingresos_Totales
FROM ECOM_PRODUCTO p
JOIN ECOM_DETAL_PEDI dp ON p.ID_Producto = dp.ECOM_PRODUCTO_ID_Producto
GROUP BY p.Nombre_Producto, p.Marca
ORDER BY Total_Vendido DESC;

-- 2: PEDIDOS PENDIENTES
SELECT 
    p.ID_Pedido,
    c.Nombre_Cliente || ' ' || c.Apellido_Cliente as Cliente,
    p.Fecha_Pedido,
    p.Total,
    p.Estado
FROM ECOM_PEDIDO p
JOIN ECOM_CLIENTE c ON p.ECOM_CLIENTE_ID_Cliente = c.ID_Cliente
WHERE p.Estado IN ('Pendiente', 'Proceso...')
ORDER BY p.Fecha_Pedido;

-- 3: CLIENTES CON MAS COMPRAS 
SELECT 
    c.Nombre_Cliente || ' ' || c.Apellido_Cliente as Cliente,
    COUNT(p.ID_Pedido) as Total_Pedidos,
    SUM(p.Total) as Total_Gastado
FROM ECOM_CLIENTE c
JOIN ECOM_PEDIDO p ON c.ID_Cliente = p.ECOM_CLIENTE_ID_Cliente
GROUP BY c.Nombre_Cliente, c.Apellido_Cliente
ORDER BY Total_Gastado DESC;

-- 4: INVENTARIO BAJO 
SELECT 
    p.Nombre_Producto,
    i.Cantidad_Disponible,
    i.Stock_Minimo,
    CASE 
        WHEN i.Cantidad_Disponible <= i.Stock_Minimo THEN 'CRÍTICO'
        WHEN i.Cantidad_Disponible <= i.Stock_Minimo * 1.5 THEN 'BAJO'
        ELSE 'NORMAL'
    END as Estado_Stock
FROM ECOM_PRODUCTO p
JOIN ECOM_INVENTARIO i ON p.ID_Producto = i.ECOM_PRODUCTO_ID_Producto
WHERE i.Cantidad_Disponible <= i.Stock_Minimo * 1.5
ORDER BY i.Cantidad_Disponible ASC;

-- 5: VENTAS POR CATEGORIAS
SELECT 
    cat.Nombre_Categoria,
    COUNT(dp.ID_Detalle) as Total_Ventas,
    SUM(dp.Sub_Total) as Ingresos_Totales
FROM ECOM_CATEGORIA cat
JOIN ECOM_PRODUCTO p ON cat.ID_Categoria = p.ECOM_CATEGORIA_ID_Categoria
JOIN ECOM_DETAL_PEDI dp ON p.ID_Producto = dp.ECOM_PRODUCTO_ID_Producto
GROUP BY cat.Nombre_Categoria
ORDER BY Ingresos_Totales DESC;

-- 6: FACTURACION POR MES
SELECT 
    TO_CHAR(f.Fecha_Factura, 'YYYY-MM') as Mes,
    COUNT(f.ID_Factura) as Total_Facturas,
    SUM(f.Total) as Facturacion_Total
FROM ECOM_FACTURA f
GROUP BY TO_CHAR(f.Fecha_Factura, 'YYYY-MM')
ORDER BY Mes DESC;

-- 7: PEDIDOS POR METODO DE PAGO 
SELECT 
    mp.Nombre_Metodo,
    COUNT(p.ID_Pedido) as Total_Pedidos,
    SUM(p.Total) as Monto_Total
FROM ECOM_METODO_PAGO mp
JOIN ECOM_PEDIDO p ON mp.ID_Metodo_Pago = p.ECOM_METODO_PAGO_ID_Metodo_Pago
GROUP BY mp.Nombre_Metodo
ORDER BY Total_Pedidos DESC;

-- 8: PRODUCTOS MEJOR CALIDAD
SELECT 
    p.Nombre_Producto,
    p.Marca,
    ROUND(AVG(r.Calificacion), 2) as Calificacion_Promedio,
    COUNT(r.ID_Resena) as Total_Resenas
FROM ECOM_PRODUCTO p
JOIN ECOM_RESENA r ON p.ID_Producto = r.ECOM_PRODUCTO_ID_Producto
GROUP BY p.Nombre_Producto, p.Marca
HAVING COUNT(r.ID_Resena) >= 1
ORDER BY Calificacion_Promedio DESC;

-- DCL: CREACIÓN DE USUARIOS Y PERMISOS

-- 1. USUARIO PARA VENDEDORES (solo ver e insertar pedidos)
CREATE USER vendedor_ecom IDENTIFIED BY "Vendedor123";

GRANT CONNECT TO vendedor_ecom;
GRANT SELECT ON ECOM_CLIENTE TO vendedor_ecom;
GRANT SELECT ON ECOM_PRODUCTO TO vendedor_ecom;
GRANT SELECT ON ECOM_CATEGORIA TO vendedor_ecom;
GRANT SELECT, INSERT ON ECOM_PEDIDO TO vendedor_ecom;
GRANT SELECT, INSERT ON ECOM_DETAL_PEDI TO vendedor_ecom;
GRANT SELECT ON ECOM_METODO_PAGO TO vendedor_ecom;

-- 2. USUARIO PARA ALMACÉN (solo gestionar inventario)
CREATE USER almacen_ecom IDENTIFIED BY "Almacen123";

GRANT CONNECT TO almacen_ecom;
GRANT SELECT ON ECOM_PRODUCTO TO almacen_ecom;
GRANT SELECT, UPDATE ON ECOM_INVENTARIO TO almacen_ecom;

-- 3. USUARIO PARA GERENTES (ver todo, no modificar precios)
CREATE USER gerente_ecom IDENTIFIED BY "Gerente123";

GRANT CONNECT TO gerente_ecom;
GRANT SELECT ON ECOM_CLIENTE TO gerente_ecom;
GRANT SELECT ON ECOM_PRODUCTO TO gerente_ecom;
GRANT SELECT ON ECOM_PEDIDO TO gerente_ecom;
GRANT SELECT ON ECOM_DETAL_PEDI TO gerente_ecom;
GRANT SELECT ON ECOM_INVENTARIO TO gerente_ecom;
GRANT SELECT ON ECOM_FACTURA TO gerente_ecom;
GRANT SELECT ON ECOM_ENVIO TO gerente_ecom;
GRANT SELECT ON ECOM_RESENA TO gerente_ecom;

-- 4. USUARIO ADMINISTRADOR (acceso total)
CREATE USER admin_ecomstore IDENTIFIED BY "Admin123";

GRANT CONNECT, RESOURCE TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_CLIENTE TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_PRODUCTO TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_PEDIDO TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_DETAL_PEDI TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_INVENTARIO TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_FACTURA TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_ENVIO TO admin_ecomstore;
GRANT SELECT, INSERT, UPDATE, DELETE ON ECOM_RESENA TO admin_ecomstore;

-- 5. QUITAR PERMISOS 
-- REVOKE DELETE ON ECOM_PRODUCTO FROM vendedor_ecom;
-- Para conectarse 
-- CONNECT admin_ecomstore/Admin123;

-- TCL: TRANSACCIONES PARA PROCESOS CRÍTICOS

-- 1. TRANSACCIÓN PARA REALIZAR UN PEDIDO
DECLARE
    v_pedido_id INTEGER;
    v_detalle_id INTEGER;
BEGIN
    -- Obtener próximos IDs de secuencias
    SELECT seq_ecom_pedido.NEXTVAL INTO v_pedido_id FROM DUAL;
    SELECT seq_ecom_detal_pedi.NEXTVAL INTO v_detalle_id FROM DUAL;
    
    -- 1. INSERTAR PEDIDO
    INSERT INTO ECOM_PEDIDO (ID_Pedido, ECOM_CLIENTE_ID_Cliente, ECOM_METODO_PAGO_ID_Metodo_Pago, Fecha_Pedido, Total, Estado)
    VALUES (v_pedido_id, 1, 1, SYSDATE, 300.00, 'Proceso...');
    
    -- 2. INSERTAR DETALLE DEL PEDIDO
    INSERT INTO ECOM_DETAL_PEDI (ID_Detalle, ECOM_PEDIDO_ID_Pedido, ECOM_PRODUCTO_ID_Producto, Cantidad, Precio_Unitario, Sub_Total)
    VALUES (v_detalle_id, v_pedido_id, 1, 2, 150.00, 300.00);
    
    -- 3. ACTUALIZAR INVENTARIO
    UPDATE ECOM_INVENTARIO 
    SET Cantidad_Disponible = Cantidad_Disponible - 2 
    WHERE ECOM_PRODUCTO_ID_Producto = 1;
    
    -- 4. VERIFICAR QUE HAY STOCK SUFICIENTE
    IF (SELECT Cantidad_Disponible FROM ECOM_INVENTARIO WHERE ECOM_PRODUCTO_ID_Producto = 1) < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Stock insuficiente para el producto');
    END IF;
    
    -- SI TODO SALE BIEN, CONFIRMAR TRANSACCIÓN
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Pedido ' || v_pedido_id || ' realizado exitosamente');
    
EXCEPTION
    -- SI HAY ALGÚN ERROR, CANCELAR TODOS LOS CAMBIOS
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en el pedido: ' || SQLERRM);
END;
/

-- 2. TRANSACCIÓN PARA ACTUALIZACIÓN MÚLTIPLE DE INVENTARIO
DECLARE
    CURSOR c_productos IS
        SELECT ID_Producto, Cantidad_Disponible 
        FROM ECOM_INVENTARIO 
        WHERE Cantidad_Disponible < Stock_Minimo;
BEGIN
    FOR producto IN c_productos LOOP
        -- ACTUALIZAR INVENTARIO (SIMULAR REABASTECIMIENTO)
        UPDATE ECOM_INVENTARIO 
        SET Cantidad_Disponible = Cantidad_Disponible + 50
        WHERE ID_Inventario = producto.ID_Producto;
        
        DBMS_OUTPUT.PUT_LINE('Producto ' || producto.ID_Producto || ' reabastecido');
    END LOOP;
    
    -- CONFIRMAR ACTUALIZACIONES
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Reabastecimiento completado exitosamente');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en reabastecimiento: ' || SQLERRM);
END;
/

-- 3. TRANSACCIÓN CON PUNTOS DE GUARDADO
DECLARE
    v_factura_id INTEGER;
BEGIN
    -- OBTENER ID DE FACTURA
    SELECT seq_ecom_factura.NEXTVAL INTO v_factura_id FROM DUAL;
    
    -- 1. INSERTAR FACTURA
    INSERT INTO ECOM_FACTURA (ID_Factura, ECOM_PEDIDO_ID_Pedido, Fecha_Factura, Subtotal, IGV, Total, Estado)
    VALUES (v_factura_id, 1, SYSDATE, 254.24, 45.76, 300.00, 'Emitida');
    
    -- PUNTO DE GUARDADO
    SAVEPOINT factura_creada;
    
    -- 2. ACTUALIZAR ESTADO DEL PEDIDO
    UPDATE ECOM_PEDIDO 
    SET Estado = 'Facturado' 
    WHERE ID_Pedido = 1;
    
    -- 3. CREAR ENVÍO
    INSERT INTO ECOM_ENVIO (ID_Envio, ECOM_PEDIDO_ID_Pedido, Direccion_Envio, Fecha_Envio, Fecha_Entrega_Estimada, Estado_Envio, Transportista, Numero_Guia)
    VALUES (seq_ecom_envio.NEXTVAL, 1, 'Monte-castillo/28-de-junio', SYSDATE, SYSDATE + 3, 'En preparación', 'Serpost', 'TRK01123456');
    
    -- SI TODO SALE BIEN, CONFIRMAR
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Proceso de facturación y envío completado');
    
EXCEPTION
    WHEN OTHERS THEN
        -- REVERTIR HASTA EL PUNTO DE GUARDADO O TODO
        ROLLBACK TO SAVEPOINT factura_creada;
        -- O ROLLBACK COMPLETO SI NO HAY SAVEPOINT
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error en facturación: ' || SQLERRM);
END;
/
