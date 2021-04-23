--REQUISITO 1: MOSTRAR LA INFORMACI�N DE UN EMPLEADO DADO EL NOMBRE
--FORMATO EN EL PDF
--LA FUNCI�N EST� ARRIBA DEL PROCEDIMIENTO SIMPLEMENTE POR ORDEN DE COMPILACI�N, EL PROGRAMA PRINCIPAL ES EL PROCEDIMIENTO.

--Funci�n esJefe, utiliza el cursor jefe para averiguar si el nombre recibido por par�metro pertenece o no a la tabla creada por la consulta del cursor.
CREATE OR REPLACE FUNCTION esJefe (nombreEmp VARCHAR2) RETURN BOOLEAN IS
    v_jefe BOOLEAN :=false;
    CURSOR jefe IS
        SELECT nombre
        FROM empleado
        WHERE cod_empleado_jefe IS NULL;
    registro jefe%ROWTYPE;
BEGIN
    --Este es el Loop que recorrer� el programa, si el nombre recibido por par�metro es igual a uno de los nombres del registro devuelve true mediante v_jefe, si no devuelve false mediante v_jefe
    OPEN jefe;
    LOOP
    FETCH jefe INTO registro;
        IF registro.nombre LIKE nombreEmp THEN
            v_jefe:=true;
        END IF;
    EXIT WHEN jefe%NOTFOUND;
    END LOOP;
    CLOSE jefe;
    RETURN v_jefe;
END;
/
--PROCEDIMIENTO
CREATE OR REPLACE PROCEDURE muestraEmpleado (nombreEmp VARCHAR2) IS
    --Cursor que recoje la informaci�n principal del empleado.
    CURSOR empleados IS
        SELECT e.cod_empleado, e.apellido1, e.apellido2, e.telefono, e.salario, d.nombre, t.direccion, e.cod_empleado_jefe
        FROM empleado e, departamento d, establecimiento t
        WHERE e.nombre=nombreEmp
        AND d.cod_establecimiento=t.cod_establecimiento
        AND e.cod_departamento=d.cod_departamento;
    --Cursor que recoje la informaci�n de los empleados a cargo de un jefe.
    CURSOR jefesE IS
        SELECT DISTINCT e.nombre, e.apellido1, e.apellido2
        FROM empleado e, empleado j
        WHERE j.cod_empleado=e.cod_empleado_jefe
        AND j.nombre LIKE nombreEmp;
    --Cursor que recoje la informaci�n de los clientes a cargo de un jefe.
    CURSOR jefesC IS
        SELECT DISTINCT c.nombre, c.apellido1, c.apellido2
        FROM cliente c, empleado j
        WHERE j.cod_empleado=c.cod_empleado_jefe
        AND j.nombre LIKE nombreEmp;
    --Declaraci�n de variables y excepciones.
    v_njEmp VARCHAR2(50);
    v_a1jEmp VARCHAR2(50);
    v_a2jEmp VARCHAR2(50);
    registroE empleados%ROWTYPE;
    registroJE jefesE%ROWTYPE;
    registroJC jefesC%ROWTYPE;
    v_cont BOOLEAN:=True;
    error_empleado_0 exception;
BEGIN
    --Abro el cursor para sacar los registros y mostrarlos por pantalla.
    OPEN empleados;
    LOOP
        FETCH empleados INTO registroE;
        --Cuando no queden registros saldr� del bucle, y en caso de que el empleado no exista saldr� del bluce autom�ticamente, con la variable cont sabremos si esto ha sido as�.
        EXIT WHEN empleados%NOTFOUND;
        v_cont:=False;
        --Informaci�n principal del empelado que se muestra en pantalla:
        DBMS_OUTPUT.PUT_LINE ('**************************************************************');
        DBMS_OUTPUT.PUT_LINE ('El empleado '|| registroE.apellido1 || ' ' || registroE.apellido2 || ', ' || nombreEmp || ' tiene el c�digo: ' || registroE.cod_empleado);
        DBMS_OUTPUT.PUT_LINE ('-Tel�fono: ' || registroE.telefono);
        DBMS_OUTPUT.PUT_LINE ('-Salario: ' || registroE.salario);
        DBMS_OUTPUT.PUT_LINE ('-Pertenece al departamento: ' || registroE.nombre);
        DBMS_OUTPUT.PUT_LINE ('-Direcci�n del establecimiento en el que trabaja: ' || registroE.direccion);
    END LOOP;
    CLOSE empleados;
    --Tratamiento de error por inexistencia del empleado. Si el empleado no existe en el loop anterior la variable v_cont no valdr� true, en caso contrario llamar� a la excepci�n error_empleado_0
    IF v_cont=True THEN
        RAISE error_empleado_0;
    END IF;
    --Cl�usula IF ELSE para saber que informaci�n mostrar mediante la funci�n esJefe, si devuelve True proceder� a mostrar los empleados y clientes a cargo del jefe, 
    --y, si es false, mostrar� el jefe del empleado.
    IF esJefe(nombreEmp) THEN
        DBMS_OUTPUT.PUT_LINE (CHR(32)||'Empleados a cargo:');
        OPEN jefesE;
        LOOP
            FETCH jefesE INTO registroJE;
            EXIT WHEN jefesE%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE (CHR(9) ||'-Empleado: '|| registroJE.apellido2 || ' ' || registroJE.apellido1 || ', ' || registroJE.nombre);
        END LOOP;
        CLOSE jefesE;
        DBMS_OUTPUT.PUT_LINE (CHR(32)||'Clientes a cargo:');
        OPEN jefesC;
        LOOP
            FETCH jefesC INTO registroJC;
            EXIT WHEN jefesC%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE (CHR(9) ||'-Cliente: '|| registroJC.apellido2 || ' ' || registroJC.apellido1 || ', ' || registroJC.nombre);
        END LOOP;
        CLOSE jefesC;
    ELSE
        SELECT j.nombre, j.apellido1, j.apellido2 INTO v_njEmp, v_a1jEmp, v_a2jEmp FROM empleado j, empleado e WHERE e.cod_empleado_jefe=j.cod_empleado AND e.nombre=nombreEmp;
        DBMS_OUTPUT.PUT_LINE ('-Jefe: '||  v_a2jEmp || ' '|| v_a1jEmp || ', '||v_njEmp); 
    END IF; 
    DBMS_OUTPUT.PUT_LINE ('**************************************************************');
    --Excepci�n error_empleado_0 que muestra un mensaje si no existe el empleado
    EXCEPTION
        WHEN error_empleado_0 THEN
        DBMS_OUTPUT.PUT_LINE  ('Error -20001:  No existe el empleado ' || nombreEmp);
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;
/