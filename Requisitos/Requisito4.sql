--REQUISITO 4: DISPARADOR COMPRA
--Cuando se inserte una nueva compra se activará el diparador Stock_Compra
CREATE OR REPLACE TRIGGER Stock_Compra
    AFTER INSERT ON detalle_compra
    FOR EACH ROW
    DECLARE
        v_cant NUMBER(3);
        v_rest NUMBER(3);
BEGIN
    --Tomo la cantidad y la inserto en una variable
    v_cant:=:NEW.cantidad;
    DBMS_OUTPUT.PUT_LINE ('**************************************************************');
    DBMS_OUTPUT.PUT_LINE('Se ha restado al stock: '|| v_cant || ' unidades');
    --El trigger ejecuta un Update para descontar la cantidad en stock de los productos.
    UPDATE producto SET cantidad_stock=cantidad_stock-v_cant WHERE cod_producto=:NEW.cod_producto;
END;
/

--Trigger que muestra la cantidad de productos restantes ó
--Trigger que lanza una excepción si la compra supera la cantidad que hay en el stock
CREATE OR REPLACE TRIGGER Stock_Compra2
    BEFORE UPDATE OF cantidad_stock ON producto
    FOR EACH ROW
    DECLARE
        error_fuera_stock exception;
BEGIN
    IF (:NEW.cantidad_stock<0) THEN
        RAISE error_fuera_stock;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Quedan en el stock: '|| :NEW.cantidad_stock || ' unidades');
        DBMS_OUTPUT.PUT_LINE ('**************************************************************');
    END IF;
    EXCEPTION
        WHEN error_fuera_stock THEN
        DBMS_OUTPUT.PUT_LINE('Error -20005, No hay suficientes productos en stock');
END;
/

--Código para probar los disparadores:
INSERT INTO COMPRA VALUES (059, 3, '10/6/2020');
INSERT INTO DETALLE_COMPRA VALUES (059, 105, 201, 10);