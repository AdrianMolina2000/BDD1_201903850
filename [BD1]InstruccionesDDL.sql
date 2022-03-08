------------------CREAR TABLA TITULO------------------
CREATE TABLE titulo (
    id_titulo NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    titulo    VARCHAR2(100) NOT NULL
);
ALTER TABLE titulo ADD CONSTRAINT titulo_pk PRIMARY KEY (id_titulo);


------------------CREAR TABLA EMPLEADO------------------
CREATE TABLE empleado (
    id_empleado      NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre           VARCHAR2(100) NOT NULL,
    apellido         VARCHAR2(100),
    direccion        VARCHAR2(100) NOT NULL,
    telefono         VARCHAR2(25) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero           VARCHAR2(1) NOT NULL,
    id_titulo        NUMBER NOT NULL
);
ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY (id_empleado);
ALTER TABLE empleado ADD CONSTRAINT empleado_titulo_fk FOREIGN KEY (id_titulo) REFERENCES titulo (id_titulo);


------------------CREAR TABLA PACIENTE------------------
CREATE TABLE paciente (
    id_paciente      NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre           VARCHAR2(100) NOT NULL,
    apellido         VARCHAR2(100),
    direccion        VARCHAR2(100) NOT NULL,
    telefono         VARCHAR2(25) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    genero           VARCHAR2(1) NOT NULL,
    altura           NUMBER NOT NULL,
    peso             NUMBER NOT NULL
);
ALTER TABLE paciente ADD CONSTRAINT paciente_pk PRIMARY KEY (id_paciente);


------------------CREAR TABLA TRATAMIENTO------------------
CREATE TABLE tratamiento (
    id_tratamiento     NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_tratamiento VARCHAR2(100) NOT NULL,
    fecha_tratamiento  DATE NOT NULL
);
ALTER TABLE tratamiento ADD CONSTRAINT tratamiento_pk PRIMARY KEY (id_tratamiento);


------------------CREAR TABLA PACIENTE_TRATAMIENTO------------------
CREATE TABLE paciente_tratamiento (
    id_paciente_tratamiento     NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    id_tratamiento              NUMBER NOT NULL,
    id_paciente                 NUMBER NOT NULL
);
ALTER TABLE paciente_tratamiento ADD CONSTRAINT paciente_tratamiento_pk PRIMARY KEY (id_paciente_tratamiento);
ALTER TABLE paciente_tratamiento ADD CONSTRAINT paciente_tratamiento_paciente_fk FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente);
ALTER TABLE paciente_tratamiento ADD CONSTRAINT paciente_tratamiento_tratamiento_fk FOREIGN KEY (id_tratamiento) REFERENCES tratamiento(id_tratamiento);


------------------CREAR TABLA EVALUACION------------------
CREATE TABLE evaluacion (
    id_evaluacion        NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    fecha_evaluacion     DATE NOT NULL,
    id_empleado          NUMBER NOT NULL,
    id_paciente          NUMBER NOT NULL
);
ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_pk PRIMARY KEY (id_evaluacion);
ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_empleado_fk FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado);
ALTER TABLE evaluacion ADD CONSTRAINT evaluacion_paciente_fk FOREIGN KEY (id_paciente) REFERENCES paciente (id_paciente);


------------------CREAR TABLA DIAGNOSTICO------------------
CREATE TABLE diagnostico (
    id_diagnostico     NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    rango              NUMBER NOT NULL,
    nombre_diagnostico VARCHAR2(50) NOT NULL
);
ALTER TABLE diagnostico ADD CONSTRAINT diagnostico_pk PRIMARY KEY (id_diagnostico);


------------------CREAR TABLA SINTOMA------------------
CREATE TABLE sintoma (
    id_sintoma     NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    nombre_sintoma VARCHAR2(50) NOT NULL
);
ALTER TABLE sintoma ADD CONSTRAINT sintoma_pk PRIMARY KEY (id_sintoma);


------------------CREAR TABLA SINTOMA_DIAGNOSTICO------------------
CREATE TABLE sintoma_diagnostico (
    id_sintoma_diagnostico      NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    id_sintoma                  NUMBER NOT NULL,
    id_diagnostico              NUMBER NOT NULL
);
ALTER TABLE sintoma_diagnostico ADD CONSTRAINT sintoma_diagnostico_pk PRIMARY KEY (id_sintoma_diagnostico);
ALTER TABLE sintoma_diagnostico ADD CONSTRAINT sintoma_diagnostico_diagnostico_fk FOREIGN KEY (id_diagnostico) REFERENCES diagnostico (id_diagnostico);
ALTER TABLE sintoma_diagnostico ADD CONSTRAINT sintoma_diagnostico_sintoma_fk FOREIGN KEY (id_sintoma) REFERENCES sintoma (id_sintoma);


------------------CREAR TABLA EVALUACION_SINTOMA------------------
CREATE TABLE evaluacion_sintoma (
    id_evaluacion_sintoma       NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1),
    id_evaluacion               NUMBER NOT NULL,
    id_sintoma                  NUMBER NOT NULL
);
ALTER TABLE evaluacion_sintoma ADD CONSTRAINT evaluacion_sintoma_pk PRIMARY KEY (id_evaluacion_sintoma);
ALTER TABLE evaluacion_sintoma ADD CONSTRAINT evaluacion_sintoma_evaluacion_fk FOREIGN KEY (id_evaluacion) REFERENCES evaluacion (id_evaluacion);
ALTER TABLE evaluacion_sintoma ADD CONSTRAINT evaluacion_sintoma_sintoma_fk FOREIGN KEY (id_sintoma) REFERENCES sintoma (id_sintoma);

------------------ELIMINACION DE TABLAS------------------
drop table evaluacion_sintoma;
drop table sintoma_diagnostico;
drop table sintoma;
drop table diagnostico;
drop table evaluacion;
drop table paciente_tratamiento;
drop table tratamiento;
drop table paciente;
drop table empleado;
drop table titulo;

