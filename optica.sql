DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica;
USE optica;

CREATE TABLE proveedor (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    NIF VARCHAR(45) NOT NULL,
    direccion VARCHAR(60),
    telefono INT,
    fax VARCHAR(30),
    PRIMARY KEY (id)
)
;

CREATE TABLE marca (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    id_proveedor INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id)
)
;

CREATE TABLE gafa (
    id INT NOT NULL AUTO_INCREMENT,
    graduacion_l VARCHAR(10),
    graduacion_r VARCHAR(10),
    tipo_montura VARCHAR (40) NOT NULL,
    color_montura VARCHAR (40),
    color_vidrio VARCHAR (40),
    precio FLOAT,
    id_marca INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_marca) REFERENCES marca(id)
)
;

CREATE TABLE empleado (
id INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30),
PRIMARY KEY (id)
)
;

CREATE TABLE cliente (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    correo_electronico VARCHAR(45) NOT NULL,
    fecha_de_registro VARCHAR(45) NOT NULL,
    codigo_postal INT,
    telefono INT,
    recomendado_por INT,
    PRIMARY KEY (id),
    FOREIGN KEY (recomendado_por) REFERENCES cliente(id)
)
;

CREATE TABLE venta (
  id INT NOT NULL AUTO_INCREMENT,
  id_cliente INT NOT NULL,
  id_empleado INT NOT NULL,
  id_gafa INT NOT NULL,
  fecha_de_venta DATE NOT NULL,
  PRIMARY KEY (id),
    FOREIGN KEY (id_cliente)
    REFERENCES cliente (id),
    FOREIGN KEY (id_gafa)
    REFERENCES gafa (id),
    FOREIGN KEY (id_empleado)
    REFERENCES empleado(id)
    )
    ;

INSERT INTO proveedor (nombre, NIF, direccion, telefono, fax) VALUES
('Proveeduría Central', 'A12345678', 'Calle Mayor 123, Madrid', 912345678, '912345679'),
('Suministros Martínez', 'B23456789', 'Avenida de la Constitución 45, Barcelona', 934567890, '934567891'),
('Distribuciones López', 'C34567890', 'Calle de la Luna 10, Valencia', 961234567, '961234568'),
('Abastecimientos S.L.', 'D45678901', 'Plaza del Sol 5, Sevilla', 955123456, '955123457');


INSERT INTO marca (nombre, id_proveedor) VALUES
('Carrera', 1),
('Gucci', 1),
('Oakley', 3),
('Persol', 3),
('Prada', 4),
('Versace', 2);

INSERT INTO gafa (graduacion_l, graduacion_r, tipo_montura, color_montura, color_vidrio, precio, id_marca) VALUES
('-1.25', '-1.50', 'pasta', 'negro', 'transparente', 120.50, 1),
('-2.00', '-2.00', 'metálica', 'plateado', 'azul', 150.00, 2),
('-0.75', '-0.50', 'flotante', 'transparente', 'verde', 200.75, 3),
('-3.00', '-2.75', 'pasta', 'azul', 'gris', 180.25, 4),
('-1.50', '-1.75', 'metálica', 'negro', 'marrón', 130.40, 5),
('-2.25', '-2.50', 'flotante', 'dorado', 'transparente', 210.00, 1),
('-0.25', '-0.25', 'pasta', 'rojo', 'gris', 90.99, 2),
('-4.00', '-3.50', 'metálica', 'gris', 'azul', 160.75, 3);

INSERT INTO empleado (nombre) VALUES
('Carlos García'),
('María Fernández'),
('José López'),
('Ana Martínez'),
('Luis Rodríguez');

INSERT INTO cliente (nombre, correo_electronico, fecha_de_registro, codigo_postal, telefono, recomendado_por) VALUES
('Juan Pérez', 'juan.perez@example.com', '2023-01-15', 28001, 912345678, NULL),
('Laura Gómez', 'laura.gomez@example.com', '2023-02-20', 28002, 912345679, 1),
('Miguel Hernández', 'miguel.hernandez@example.com', '2023-03-18', 28003, 912345680, 1),
('Ana Torres', 'ana.torres@example.com', '2023-04-10', 28004, 912345681, 2),
('David Martín', 'david.martin@example.com', '2023-05-05', 28005, 912345682, NULL),
('Sofía Ruiz', 'sofia.ruiz@example.com', '2023-06-12', 28006, 912345683, 5),
('Carlos Sánchez', 'carlos.sanchez@example.com', '2023-07-19', 28007, 912345684, 3),
('Elena Moreno', 'elena.moreno@example.com', '2023-08-25', 28008, 912345685, 4);

INSERT INTO venta (id_cliente, id_empleado, id_gafa, fecha_de_venta) VALUES
(2, 4, 4, '2023-01-15'),
(2, 3, 3, '2024-01-20'),
(3, 1, 3, '2024-02-18'),
(5, 3, 4, '2024-03-10'),
(8, 5, 5, '2024-04-05'),
(6, 4, 6, '2023-05-12'),
(7, 2, 7, '2024-06-19'),
(8, 4, 8, '2023-07-25');


-- Consultas

-- Compras de un cliente
SELECT c.nombre AS cliente, 
    v.fecha_de_venta AS fecha_de_compra,
    g.precio AS precio,
    m.nombre AS nombre_marca
    FROM marca m JOIN gafa g ON m.id = g.id
    JOIN venta v ON g.id = v.id
    JOIN cliente c ON v.id_cliente = c.id WHERE c.id = '2';
    
-- Ventas de un empleado durante un año
SELECT e.nombre AS nombre,
    m.nombre AS nombre_marca,
    COUNT(g.id) AS cantidad_de_ventas,
    v.fecha_de_venta AS fecha_de_venta
    FROM marca m JOIN gafa g ON m.id = g.id
    JOIN venta v ON g.id = v.id_gafa
    JOIN empleado e ON v.id_empleado = e.id
    WHERE e.id = '4' AND year(v.fecha_de_venta) = '2023'
    GROUP BY e.nombre, g.id, v.fecha_de_venta;
    
-- Lista de proveedores que han suministrado gafas vendidas

SELECT p.nombre AS proveedor,
        m.nombre AS nombre_marca,
        COUNT(g.id) AS gafas_vendidas
FROM proveedor p JOIN marca m ON p.id = m.id_proveedor
JOIN gafa g ON m.id = g.id_marca
JOIN venta v ON v.id_gafa = g.id
GROUP BY p.nombre, m.nombre;