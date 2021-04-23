--REQUISITO 2: MOSTRAR LA INFORMACIÓN DE UN CLIENTE DADO EL NOMBRE
--FORMATO EN PDF

CREATE OR REPLACE PROCEDURE muestraCliente (nombreCli VARCHAR2) IS
    --DECLARACIÓN DE VARIABLE PARA GUARDAR EL CÓDIGO DEL CLIENTE
    v_cod_c NUMBER(3);
    --CURSOR PARA ENCONTRAR AL CLIENTE
    CURSOR cliente IS
        SELECT cod_cliente, apellido1 || ' ' || apellido2 AS "APELLIDOS" 
            FROM cliente 
            WHERE nombre=nombreCli;
    --CURSOR PARA SABER LA CANTIDAD DE PRODUCTOS QUE HA COMPRADO EL CLIENTE
    CURSOR numProC IS
        SELECT SUM(d.cantidad) AS "CANTIDAD"
            FROM detalle_compra d, compra cr, cliente c 
            WHERE d.cod_compra=cr.cod_compra
            AND cr.cod_cliente=c.cod_cliente
            AND c.cod_cliente=v_cod_c;
    --CURSOR PARA SABER LA CANTIDAD DE PRODUCTOS QUE HA PEDIDO EL CLIENTE
    CURSOR numProP IS
        SELECT SUM(d.cantidad) AS "CANTIDAD"
            FROM detalle_pedido d, pedido p, cliente c 
            WHERE d.cod_pedido=p.cod_pedido
            AND p.cod_cliente=c.cod_cliente
            AND c.cod_cliente=v_cod_c;
    --CURSOR PARA SABER LA LISTA DE PRODUCTOS QUE HA COMPRADO EL CLIENTE
    CURSOR LisProC IS
        SELECT p.nombre
            FROM producto p, detalle_compra d, compra cr, cliente c
            WHERE p.cod_producto=d.cod_producto
            AND d.cod_compra=cr.cod_compra
            AND cr.cod_cliente=c.cod_cliente
            AND c.cod_cliente=v_cod_c;
    --CURSOR PARA SABER LA LISTA DE PRODUCTOS QUE HA PEDIDO EL CLIENTE   
    CURSOR LisProP IS
        SELECT p.nombre
            FROM producto p, detalle_pedido d, pedido p, cliente c
            WHERE p.cod_producto=d.cod_producto
            AND d.cod_pedido=p.cod_pedido
            AND p.cod_cliente=c.cod_cliente
            AND c.cod_cliente=v_cod_c;
    --DECLARACIÓN DE VARIABLES Y EXCEPCIONES
    registroNPC numProC%ROWTYPE;
    registroNPP numProP%ROWTYPE;
    registroLPC LisProC%ROWTYPE;
    registroLPP LisProP%ROWTYPE;
    registroC cliente%ROWTYPE;
    v_cont BOOLEAN :=true;
    error_cliente_0 exception;
BEGIN
    --LOOP DEL PRIMER CURSOR PARA MOSTRAR LOS DATOS DEL CLIENTE, EN CASO DE QUE EL CLIENTE NO EXISTA SALDRÁ DEL LOOP AUOMÁTICAMENTE Y MOSTRARÁ LA EXCEPCIÓN error_cliente_0
    OPEN cliente;
    LOOP
        FETCH cliente INTO registroC;
        EXIT WHEN cliente%NOTFOUND;
        --VARIABLE PARA COMPROBAR SI HA ENCONTRADO AL CLIENTE O NO, SI ES TRUE NO HABRÁ ENCONTRADO AL CLIENTE Y EL IF SIGUIENTE SE EJECUTARÁ Y PASARÁ A LA EXCEPCIÓN.
        v_cont:=false;
        DBMS_OUTPUT.PUT_LINE ('**************************************************************');
        DBMS_OUTPUT.PUT_LINE  ('El código del cliente ' || registroC.apellidos || ', ' || nombreCli || ' es ' || registroC.cod_cliente);
        v_cod_c:=registroC.cod_cliente;     --Asigno el codigo del cliente a la variable
            --CURSOR PARA MOSTRAR LA CANTIDAD DE PRODUCTOS QUE HA COMPRADO, EN CASO DE QUE NO HAYA COMPRADO SALDRÁ DEL BUCLE SIN MOSTRAR DATOS
            OPEN numProC;
            LOOP
                FETCH numProC INTO registroNPC;
                EXIT WHEN numProC%NOTFOUND;
                EXIT WHEN registroNPC.cantidad IS NULL;
                DBMS_OUTPUT.PUT_LINE ('-Número de productos comprados: '|| registroNPC.cantidad);
                DBMS_OUTPUT.PUT_LINE ('-Lista de productos:');
                --CURSOR PARA MOSTRAR LA LISTA DE PRODUCTOS QUE HA COMPRADO
                OPEN LisProC;
                LOOP
                    FETCH LisProC INTO registroLPC;
                    EXIT WHEN LisProC%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE (CHR(9) ||registroLPC.nombre);
                END LOOP;
                CLOSE LisProC;
            END LOOP;
            CLOSE numProC;
            --CURSOR PARA MOSTRAR LA CANTIDAD DE PRODUCTOS QUE HA PEDIDO, EN CASO DE QUE NO HAYA PEDIDO SALDRÁ DEL BUCLE SIN MOSTRAR DATOS
            OPEN numProP;
            LOOP
                FETCH numProP INTO registroNPP;
                EXIT WHEN numProP%NOTFOUND;
                EXIT WHEN registroNPP.cantidad IS NULL;
                DBMS_OUTPUT.PUT_LINE ('-Número de productos comprados: '|| registroNPP.cantidad);
                DBMS_OUTPUT.PUT_LINE ('-Lista de productos:');
                --CURSOR PARA MOSTRAR LA LISTA DE PRODUCTOS QUE HA PEDIDO
                OPEN LisProP;
                LOOP
                    FETCH LisProP INTO registroLPP;
                    EXIT WHEN LisProP%NOTFOUND;
                    DBMS_OUTPUT.PUT_LINE (CHR(9) ||registroLPP.nombre);
                END LOOP;
                CLOSE LisProP;
            END LOOP;
            CLOSE numProP;

    END LOOP;
    CLOSE cliente;
    --IF PARA LA EXCEPCIÓN
    IF v_cont=True THEN
        RAISE error_cliente_0;
    END IF;
    DBMS_OUTPUT.PUT_LINE ('**************************************************************');
    EXCEPTION
        WHEN error_cliente_0 THEN
        DBMS_OUTPUT.PUT_LINE  ('Error -20002:  No existe el cliente ' || nombreCli);
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;
/