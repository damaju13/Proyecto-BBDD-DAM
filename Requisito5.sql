--REQUISITO 5: DISPARADORES DE AUDITORÍA
--HAY UN DISPARADOR DE AUDITORÍA POR CADA TABLA DE AUDITORÍA Y UNA TABLA DE AUDITORÍA POR TABLA DE LA BASE DE DATOS
--EJEMPLO GENERAL PARA EXPLICAR EL FUNCIONAMIENTO DE LOS DISPARADORES DE AUDITORÍA:

--CREATE OR REPLACE TRIGGER NOMBRE_DISPARADOR
--    AFTER INSERT OR DELETE OR UPDATE ON TABLA_BASE_DATOS                                          --DESPUÉS DE LA EJECUCIÓN DE LA SENTENCIA EN UNA TABLA DE LA BBDD SE EJECUTA EL DISPARADOR 
--    FOR EACH ROW                                                                                  --ES UN DISPARADOR DE FILA
--    DECLARE                                                                                       --DECLARAMOS VARIABLES DONDE GUARDAREMOS LA INFORMACIÓN DE LOS ANTIGUOS Y NUEVOS REGISTROS
--        v_txt VARCHAR2(1000);
--        v_txt2 VARCHAR2(1000);
--BEGIN
--    IF INSERTING THEN                                                                             --SI INSERTA EJECUTA:
--    v_txt:= :NEW.dato1 || '#' || :NEW.dato2 || '#' || :NEW.dato3;                                 --METE EN UNA VARIABLE LOS DATOS EN FORMA DE PATRÓN LOS DATOS INSERTADOS (NUEVOS)
--    INSERT INTO AUDITORIA_TABLA (fecha,usuario,sentencia,reg_old,reg_new)                         --INSERTA LOS DATOS EN LA TABLA AUDITORÍA
--        VALUES (SYSDATE, USER, 1, ' ', v_txt);                                                    --EL VALOR 1 ES INSERT

--    ELSIF UPDATING THEN                                                                           --SI ACTUALIZA EJECUTA:
--    v_txt:= :NEW.dato1 || '#' || :NEW.dato2 || '#' || :NEW.dato3;                                 --METE EN UNA VARIABLE LOS DATOS EN FORMA DE PATRÓN LOS DATOS ACTUALIZADOS (NUEVOS)
--    v_txt2:=:OLD.dato1 || '#' || :OLD.dato2 || '#' || :OLD.dato3;                                 --METE EN UNA VARIABLE LOS DATOS EN FORMA DE PATRÓN LOS DATOS ANTIGUOS QUE SE ACTUALIZARON
--    INSERT INTO AUDITORIA_CLIENTE (fecha,usuario,sentencia,reg_old,reg_new)                       --INSERTA LOS DATOS EN LA TABLA AUDITORÍA
--        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);                                                 --EL VALOR 2 ES UPDATE

--    ELSE                                                                                          --SINO SERÁ DELETE
--    v_txt2:=:OLD.dato1 || '#' || :OLD.dato2 || '#' || :OLD.dato3;                                 --METE EN UNA VARIABLE LOS DATOS EN FORMA DE PATRÓN LOS DATOS ANTIGUOS ELIMINADOS
--    INSERT INTO AUDITORIA_CLIENTE (fecha,usuario,sentencia,reg_old,reg_new)                       --INSERTA LOS DATOS EN LA TABLA AUDITORÍA
--        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
--    END IF;
--END;
--/

--DISPARADOR DE LA TABLA CLIENTE
CREATE OR REPLACE TRIGGER AUDITOR_CLIENTE
    AFTER INSERT OR DELETE OR UPDATE ON CLIENTE
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_cliente || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2 || '#' || :NEW.dni || '#' || :NEW.telefono || '#' || :NEW.cod_empleado_jefe;
    INSERT INTO AUDITORIA_CLIENTE (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:=:NEW.cod_cliente || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2 || '#' || :NEW.dni || '#' || :NEW.telefono || '#' || :NEW.cod_empleado_jefe;
    v_txt2:=:OLD.cod_cliente || '#' || :OLD.nombre || '#' || :OLD.apellido1 || '#' || :OLD.apellido2 || '#' || :OLD.dni || '#' || :OLD.telefono || '#' || :OLD.cod_empleado_jefe;
    INSERT INTO AUDITORIA_CLIENTE (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:= :NEW.cod_cliente || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2 || '#' || :NEW.dni || '#' || :NEW.telefono || '#' || :NEW.cod_empleado_jefe;
    INSERT INTO AUDITORIA_CLIENTE (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA COMPRA
CREATE OR REPLACE TRIGGER AUDITOR_COMPRA
    AFTER INSERT OR DELETE OR UPDATE ON COMPRA
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_compra || '#' || :NEW.cod_cliente || '#' || :NEW.fecha_compra;
    INSERT INTO AUDITORIA_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_compra || '#' || :NEW.cod_cliente || '#' || :NEW.fecha_compra;
    v_txt2:=:OLD.cod_compra || '#' || :OLD.cod_cliente || '#' || :OLD.fecha_compra;
    INSERT INTO AUDITORIA_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_compra || '#' || :OLD.cod_cliente || '#' || :OLD.fecha_compra;
    INSERT INTO AUDITORIA_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA DEPARTAMENTO
CREATE OR REPLACE TRIGGER AUDITOR_DEPARTAMENTO
    AFTER INSERT OR DELETE OR UPDATE ON DEPARTAMENTO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.cod_establecimiento;
    INSERT INTO AUDITORIA_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.cod_establecimiento;
    v_txt2:=:OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.cod_establecimiento;
    INSERT INTO AUDITORIA_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.cod_establecimiento;
    INSERT INTO AUDITORIA_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA DETALLE COMPRA
CREATE OR REPLACE TRIGGER AUDITOR_DETALLE_COMPRA
    AFTER INSERT OR DELETE OR UPDATE ON DETALLE_COMPRA
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_compra || '#' || :NEW.cod_producto || '#' || :NEW.cantidad || '#' || :NEW.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_compra || '#' || :NEW.cod_producto || '#' || :NEW.cantidad || '#' || :NEW.precio_unidad;
    v_txt2:=:OLD.cod_compra || '#' || :OLD.cod_producto || '#' || :OLD.cantidad || '#' || :OLD.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_compra || '#' || :OLD.cod_producto || '#' || :OLD.cantidad || '#' || :OLD.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_COMPRA (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA DETALLE PEDIDO
CREATE OR REPLACE TRIGGER AUDITOR_DETALLE_PEDIDO
    AFTER INSERT OR DELETE OR UPDATE ON DETALLE_PEDIDO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_pedido || '#' || :NEW.cod_producto || '#' || :NEW.cantidad || '#' || :NEW.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_pedido || '#' || :NEW.cod_producto || '#' || :NEW.cantidad || '#' || :NEW.precio_unidad;    
    v_txt2:=:OLD.cod_pedido || '#' || :OLD.cod_producto || '#' || :OLD.cantidad || '#' || :OLD.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_pedido || '#' || :OLD.cod_producto || '#' || :OLD.cantidad || '#' || :OLD.precio_unidad;
    INSERT INTO AUDITORIA_DETALLE_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA EMPLEADO
CREATE OR REPLACE TRIGGER AUDITOR_EMPLEADO
    AFTER INSERT OR DELETE OR UPDATE ON EMPLEADO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_empleado || '#' || :NEW.cod_empleado_jefe || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2 || '#' ||
            :NEW.telefono || '#' || :NEW.pais || '#' || :NEW.provincia || '#' || :NEW.ciudad || '#' || :NEW.dni || '#' || :NEW.salario;
    INSERT INTO AUDITORIA_EMPLEADO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_empleado || '#' || :NEW.cod_empleado_jefe || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2 || '#' ||
            :NEW.telefono || '#' || :NEW.pais || '#' || :NEW.provincia || '#' || :NEW.ciudad || '#' || :NEW.dni || '#' || :NEW.salario;
    v_txt2:=:OLD.cod_empleado || '#' || :OLD.cod_empleado_jefe || '#' || :OLD.nombre || '#' || :OLD.apellido1 || '#' || :OLD.apellido2 || '#' ||
            :OLD.telefono || '#' || :OLD.pais || '#' || :OLD.provincia || '#' || :OLD.ciudad || '#' || :OLD.dni || '#' || :OLD.salario;
    INSERT INTO AUDITORIA_EMPLEADO (fecha,usuario,sentencia,reg_old,reg_NEW) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_empleado || '#' || :OLD.cod_empleado_jefe || '#' || :OLD.nombre || '#' || :OLD.apellido1 || '#' || :OLD.apellido2 || '#' ||
            :OLD.telefono || '#' || :OLD.pais || '#' || :OLD.provincia || '#' || :OLD.ciudad || '#' || :OLD.dni || '#' || :OLD.salario;
    INSERT INTO AUDITORIA_EMPLEADO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA ESTABLECIMIENTO
CREATE OR REPLACE TRIGGER AUDITOR_ESTABLECIMIENTO
    AFTER INSERT OR DELETE OR UPDATE ON ESTABLECIMIENTO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_establecimiento || '#' || :NEW.cod_postal || '#' || :NEW.ciudad || '#' || :NEW.direccion || '#' || :NEW.telefono;
    INSERT INTO AUDITORIA_ESTABLECIMIENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_establecimiento || '#' || :NEW.cod_postal || '#' || :NEW.ciudad || '#' || :NEW.direccion || '#' || :NEW.telefono;
    v_txt2:=:OLD.cod_establecimiento || '#' || :OLD.cod_postal || '#' || :OLD.ciudad || '#' || :OLD.direccion || '#' || :OLD.telefono;
    INSERT INTO AUDITORIA_ESTABLECIMIENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_establecimiento || '#' || :OLD.cod_postal || '#' || :OLD.ciudad || '#' || :OLD.direccion || '#' || :OLD.telefono;
    INSERT INTO AUDITORIA_ESTABLECIMIENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA JEFE DEPARTAMENTO
CREATE OR REPLACE TRIGGER AUDITOR_JEFE_DEPARTAMENTO
    AFTER INSERT OR DELETE OR UPDATE ON JEFE_DEPARTAMENTO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2;
    INSERT INTO AUDITORIA_JEFE_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.apellido1 || '#' || :NEW.apellido2;
    v_txt2:=:OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.apellido1 || '#' || :OLD.apellido2;
    INSERT INTO AUDITORIA_JEFE_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.apellido1 || '#' || :OLD.apellido2;
    INSERT INTO AUDITORIA_JEFE_DEPARTAMENTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA PEDIDO
CREATE OR REPLACE TRIGGER AUDITOR_PEDIDO
    AFTER INSERT OR DELETE OR UPDATE ON PEDIDO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_pedido || '#' || :NEW.cod_cliente || '#' || :NEW.fecha_pedido || '#' || :NEW.fecha_entrega;
    INSERT INTO AUDITORIA_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_pedido || '#' || :NEW.cod_cliente || '#' || :NEW.fecha_pedido || '#' || :NEW.fecha_entrega;
    v_txt2:=:OLD.cod_pedido || '#' || :OLD.cod_cliente || '#' || :OLD.fecha_pedido || '#' || :OLD.fecha_entrega;
    INSERT INTO AUDITORIA_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_pedido || '#' || :OLD.cod_cliente || '#' || :OLD.fecha_pedido || '#' || :OLD.fecha_entrega;
    INSERT INTO AUDITORIA_PEDIDO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/
--DISPARADOR DE LA TABLA PRODUCTO
CREATE OR REPLACE TRIGGER AUDITOR_PRODUCTO
    AFTER INSERT OR DELETE OR UPDATE ON PRODUCTO
    FOR EACH ROW
    DECLARE
        v_txt VARCHAR2(1000);
        v_txt2 VARCHAR2(1000);
BEGIN
    IF INSERTING THEN
    v_txt:= :NEW.cod_producto || '#' || :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.gama || '#' || :NEW.descripcion || '#' || 
            :NEW.proovedor || '#' || :NEW.cantidad_stock || '#' || :NEW.precio_venta || '#' || :NEW.precio_proovedor;
    INSERT INTO AUDITORIA_PRODUCTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 1, ' ', v_txt);
    ELSIF UPDATING THEN
    v_txt:= :NEW.cod_producto || '#' || :NEW.cod_departamento || '#' || :NEW.nombre || '#' || :NEW.gama || '#' || :NEW.descripcion || '#' || 
            :NEW.proovedor || '#' || :NEW.cantidad_stock || '#' || :NEW.precio_venta || '#' || :NEW.precio_proovedor;
    v_txt2:=:OLD.cod_producto || '#' || :OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.gama || '#' || :OLD.descripcion || '#' || 
            :OLD.proovedor || '#' || :OLD.cantidad_stock || '#' || :OLD.precio_venta || '#' || :OLD.precio_proovedor;
    INSERT INTO AUDITORIA_PRODUCTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 2, v_txt, v_txt2);
    ELSE
    v_txt2:=:OLD.cod_producto || '#' || :OLD.cod_departamento || '#' || :OLD.nombre || '#' || :OLD.gama || '#' || :OLD.descripcion || '#' || 
            :OLD.proovedor || '#' || :OLD.cantidad_stock || '#' || :OLD.precio_venta || '#' || :OLD.precio_proovedor;
    INSERT INTO AUDITORIA_PRODUCTO (fecha,usuario,sentencia,reg_old,reg_new) 
        VALUES (SYSDATE, USER, 3, v_txt2, ' ');
    END IF;
END;
/