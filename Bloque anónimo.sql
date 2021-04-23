--PROYECTO BASE DE DATOS, APARTADO DE PROGRAMACIÓN PL/SQL
--PRIMER APARTADO: BLOQUE ANÓNIMO, CUERPO DEL PROGRAMA
SET SERVEROUTPUT ON

DECLARE
    --Opción del Switch
    numC NUMBER(1):=1;
    --Nombre del empelado del que quieres la información (Requisito 1).
    nombreEmp VARCHAR2(50):='Sheila';   --Ejemplos de empleados existentes para introducir: 'Fran', 'Sheila', 'Alejandra'.
    --Nombre del cliente del que quieres la información (Requisito 2).
    nombreCli VARCHAR2(50):='David';    --Ejemplos de empleados existentes para introducir: 'David', 'Ana', 'Pol'.
    --Nombre del producto del que quieras el precio junto al del establecimiento (Requisito 3).
    nomPro VARCHAR2(50):='Alexa';       --Ejemplos de productos existentes para introducir: 'Alexa', 'Gazpacho', 'Ficus'.
    dirEst VARCHAR2(50):='C/ Colón 5';  --Direcciones de establecimiento existentes para introducir: 'C/ Colón 5', 'C/ Alcornoque 2', 'C/ Alcornoque 2'.
BEGIN
    CASE numC
        WHEN 1 THEN
        --Requisito 1
        muestraEmpleado(nombreEmp);
        WHEN 2 THEN
        --Requisito 2
        muestraCliente(nombreCli);
        WHEN 3 THEN
        --Requisito 3
        --Si retorna -1 El establecimiento no existe y si retorna -2 el producto no existe.
        DBMS_OUTPUT.PUT_LINE('El precio es de: '|| esPrecio(nomPro, dirEst) || '€');
        ELSE DBMS_OUTPUT.PUT_LINE('Opción incorrecta');
    END CASE;
END;
/