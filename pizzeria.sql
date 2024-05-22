DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria;
USE pizzeria;



CREATE TABLE cliente (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    direccion VARCHAR(45) NOT NULL,
    codigo_postal INT NOT NULL,
    localidad VARCHAR(45) NOT NULL,
    provincia VARCHAR(45) NOT NULL,
    numero_de_telefono INT NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE tienda (
    id INT NOT NULL AUTO_INCREMENT,
    direccion VARCHAR(50) NOT NULL,
    codigo_postal INT NOT NULL,
    localidad VARCHAR(45) NOT NULL,
    provincia VARCHAR(45) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE empleado (
    id INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_tienda INT NOT NULL,
    nombre VARCHAR(45) NOT NULL,
    apellidos VARCHAR(45) NOT NULL,
    nif VARCHAR(30) NOT NULL,
    telefono INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id)
);


CREATE TABLE pedido (
    id INT NOT NULL AUTO_INCREMENT,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_tienda INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    tipo_de_pedido ENUM('reparto', 'recoger_en_tienda') NOT NULL,
    cantidad_de_productos INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY(id_cliente) REFERENCES cliente(id),
    FOREIGN KEY(id_empleado) REFERENCES empleado(id),
    FOREIGN KEY(id_tienda) REFERENCES tienda(id)
);


CREATE TABLE categoria (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE producto (
    id INT NOT NULL AUTO_INCREMENT,
    id_categoria INT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    descripcion VARCHAR(50) NOT NULL,
    imagen VARCHAR(35),
    precio INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id)
);


CREATE TABLE pedido_has_productos (
    id_pedidos INT NOT NULL,
    id_productos INT NOT NULL,
    PRIMARY KEY (id_pedidos, id_productos),
    FOREIGN KEY (id_pedidos) REFERENCES pedido(id),
    FOREIGN KEY (id_productos) REFERENCES producto(id)
);


INSERT INTO cliente (nombre, apellidos, direccion, codigo_postal, localidad, provincia, numero_de_telefono) VALUES
('Juan', 'Pérez García', 'Calle Mayor 123', 28001, 'Madrid', 'Madrid', 912345678),
('María', 'López Fernández', 'Avenida de la Constitución 45', 08001, 'Barcelona', 'Barcelona', 934567890),
('Carlos', 'Martín Sánchez', 'Calle de la Luna 10', 46001, 'Valencia', 'Valencia', 961234567),
('Ana', 'Gómez Rodríguez', 'Plaza del Sol 5', 41001, 'Sevilla', 'Sevilla', 955123456),
('Luis', 'Hernández Ruiz', 'Calle de la Esperanza 22', 50001, 'Zaragoza', 'Zaragoza', 976123456),
('Elena', 'Jiménez García', 'Calle del Prado 78', 48001, 'Bilbao', 'Vizcaya', 944567890),
('Laura', 'Torres Díaz', 'Ronda de la Muralla 12', 29001, 'Málaga', 'Málaga', 952123456),
('David', 'Martínez López', 'Avenida de las Flores 7', 03001, 'Alicante', 'Alicante', 965123456),
('Isabel', 'Sánchez Pérez', 'Calle de la Marina 15', 15001, 'La Coruña', 'La Coruña', 981234567),
('Sofía', 'Ruiz González', 'Calle del Comercio 33', 18001, 'Granada', 'Granada', 958123456);


INSERT INTO tienda (direccion, codigo_postal, localidad, provincia) VALUES
('Calle del Sol 10', 28001, 'Madrid', 'Madrid'),
('Avenida Central 456', 08010, 'Barcelona', 'Barcelona'),
('Calle Valencia 20', 46002, 'Valencia', 'Valencia'),
('Avenida Sevilla 30', 41010, 'Sevilla', 'Sevilla'),
('Calle Zaragoza 5', 50005, 'Zaragoza', 'Zaragoza'),
('Calle Bilbao 40', 48005, 'Bilbao', 'Vizcaya'),
('Paseo de la Costa 15', 29010, 'Málaga', 'Málaga'),
('Avenida Alicante 55', 03005, 'Alicante', 'Alicante'),
('Calle Galicia 60', 15010, 'La Coruña', 'Galicia'),
('Plaza de Granada 25', 18002, 'Granada', 'Granada');


INSERT INTO empleado (id_tienda, nombre, apellidos, nif, telefono) VALUES
(1, 'Laura', 'Martínez Pérez', '12345678A', 612345678),
(2, 'Pedro', 'García López', '23456789B', 622345678),
(3, 'Ana', 'Hernández Gómez', '34567890C', 632345678),
(4, 'Luis', 'Fernández Ruiz', '45678901D', 642345678),
(5, 'Elena', 'González Díaz', '56789012E', 652345678);


INSERT INTO pedido (id_cliente, id_empleado, id_tienda, fecha_hora, tipo_de_pedido, cantidad_de_productos) VALUES
(1, 1, 2, '2024-01-15 10:30:00', 'reparto', 3),
(5, 3, 2, '2024-01-20 14:45:00', 'recoger_en_tienda', 2),
(7, 4, 5, '2024-02-18 09:20:00', 'reparto', 1),
(10, 4, 8, '2024-03-10 16:00:00', 'recoger_en_tienda', 3),
(3, 5, 5, '2024-04-05 11:15:00', 'reparto', 2),
(6, 1, 10, '2024-05-12 13:30:00', 'recoger_en_tienda',1),
(6, 2, 10, '2024-05-12 14:35:00', 'recoger_en_tienda',1);

INSERT INTO categoria (nombre) VALUES
('pizza'),
('hamburguesa'),
('bebida');



INSERT INTO producto (nombre, descripcion, imagen, precio, id_categoria) VALUES
('Margarita', 'Pizza clásica con tomate y queso', 'margarita.jpg', 8, 1),
('Pepperoni', 'Pizza con pepperoni y queso', 'pepperoni.jpg', 10, 1),
('Hawaiana', 'Pizza con piña y jamón', 'hawaiana.jpg', 9, 1),
('Vegetariana', 'Pizza con verduras frescas', 'vegetariana.jpg', 9, 1),
('Coca Cola', 'Refresco de cola 500ml', 'coca_cola.jpg', 2, 3),
('Fanta Naranja', 'Refresco de naranja 500ml', 'fanta_naranja.jpg', 2, 3),
('Agua Mineral', 'Botella de agua 500ml', 'vichy.jpg', 1, 3),
('Cerveza', 'Cerveza 330ml', 'heineken.jpg', 3, 3),
('Hamburguesa Clásica', 'Hamburguesa con lechuga y tomate', 'burger_clasica.jpg', 8, 2),
('Hamburguesa Queso', 'Hamburguesa con queso cheddar', 'burguer_queso.jpg', 9, 2),
('Hamburguesa BBQ', 'Hamburguesa con salsa barbacoa', 'burger_bbq.jpg', 10, 2),
('Hamburguesa Vegetariana', 'Hamburguesa de verduras', 'veggie_burger.jpg', 9, 2);


INSERT INTO pedido_has_productos (id_pedidos, id_productos) VALUES
(1, 4),
(2, 5),
(3, 7),
(3, 6),
(1, 8),
(1, 3),
(2, 9);

-- consultas 


-- Lista cuántos productos de tipo “Bebidas” se han vendido en una determinada localidad.
SELECT t.localidad AS localidad,
        SUM(p.cantidad_de_productos) AS productos
FROM tienda t JOIN pedido p ON t.id = p.id_tienda
INNER JOIN pedido_has_productos q ON p.id = q.id_pedidos
INNER JOIN producto e ON e.id = q.id_productos
INNER JOIN categoria n ON n.id = e.id_categoria
WHERE n.nombre = 'bebida' AND t.localidad = 'Barcelona'
GROUP BY t.localidad;



-- Lista cuántos pedidos ha efectuado un determinado empleado/a.
SELECT COUNT(id_empleado) AS cantidad_de_pedidos
    FROM pedido
WHERE id_empleado = '4';

