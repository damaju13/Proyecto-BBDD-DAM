CREATE OR REPLACE FUNCTION esPrecio (nomPro VARCHAR2, dirEst VARCHAR2) RETURN NUMBER IS
    CURSOR establecimiento IS
        SELECT d.cod_departamento
            FROM departamento d, establecimiento e
            WHERE e.cod_establecimiento = d.cod_establecimiento
            AND e.direccion LIKE dirEst;
    v_cod_d NUMBER(3);
    CURSOR producto IS
        SELECT precio_venta
            FROM producto 
            WHERE cod_departamento=v_cod_d
            AND nombre=nomPro;
    registroE establecimiento%ROWTYPE;
    registroP producto%ROWTYPE;
    v_cont BOOLEAN :=True;
    v_cont2 BOOLEAN :=True;
    error_establecimiento_0 exception;
    error_producto_0 exception;
BEGIN
    OPEN establecimiento;
        LOOP
            FETCH establecimiento INTO registroE;
            EXIT WHEN establecimiento%NOTFOUND;
            v_cont:=false;
            v_cod_d:=registroE.cod_departamento;
            OPEN producto;
                LOOP
                    FETCH producto INTO registroP;
                    EXIT WHEN producto%NOTFOUND;
                    v_cont2:=false;
                    RETURN registroP.precio_venta;
                END LOOP;
            CLOSE producto;
        END LOOP;
    CLOSE establecimiento;
    IF v_cont=True THEN
        RETURN -1;
    END IF;
    IF v_cont2=True THEN
        IF (v_cont=false) THEN
            RETURN -2;
        END IF;
    END IF;
    --Excepción error_empleado_0 que muestra un mensaje si no existe el empleado
    EXCEPTION
        WHEN error_establecimiento_0 THEN
        DBMS_OUTPUT.PUT_LINE  ('Error -20003:  No existe establecimiento en la dirección: ' || dirEst);
        WHEN error_producto_0 THEN
        DBMS_OUTPUT.PUT_LINE  ('Error -20004:  No existe el producto: ' || nomPro);
END;
/