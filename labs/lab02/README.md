# Lab02: Diseño, simulación e implementación de una ALU de 4 bits

## Contenido

- Objetivos de aprendizaje  
- Fundamento teórico  
- Arquitectura del sistema  
- Procedimiento  
- Requisitos del diseño  
- Implementación en FPGA  
- Verificación en hardware  
- Entregables  
- Criterios de éxito  

---

# 1. Objetivos de aprendizaje

Al finalizar este laboratorio, el estudiante será capaz de:

- Comprender el papel de la **Unidad Aritmético-Lógica (ALU)** dentro de un procesador digital.
- Diseñar una **ALU de 4 bits** utilizando Verilog.
- Implementar operaciones aritméticas y lógicas controladas por un código de operación.
- Comprender la diferencia entre **lógica combinacional** y **lógica secuencial**.
- Comprender el uso de **registros para almacenamiento temporal de datos y señales de control**.
- Diseñar un sistema utilizando **módulos independientes e interconectados jerárquicamente**.
- Validar el funcionamiento del diseño mediante **simulación en Icarus Verilog y visualización en GTKWave**.
- Implementar el diseño en la **FPGA Zybo Z7** utilizando switches, botones y LEDs como interfaz de entrada/salida.

Este laboratorio constituye el **primer bloque funcional del procesador** que se desarrollará progresivamente durante el curso.

---

# 2. Fundamento teórico

## 2.1 Unidad Aritmético-Lógica (ALU)

La **ALU (Arithmetic Logic Unit)** es el bloque encargado de realizar operaciones matemáticas y lógicas dentro de un procesador.

Entre las operaciones más comunes se encuentran:

- suma  
- resta  
- AND lógico  
- OR lógico  
- XOR lógico  
- desplazamientos  

En una arquitectura de procesador, la ALU recibe datos desde registros del **datapath**, ejecuta la operación seleccionada por la **unidad de control** y produce un resultado que puede almacenarse nuevamente en los registros o enviarse a memoria.

En este laboratorio, la ALU deberá comportarse como un **bloque de lógica combinacional**. Esto significa que el resultado deberá depender únicamente de los valores actuales de sus operandos y del código de operación seleccionado.

La ALU no deberá almacenar información ni conservar estados anteriores.

---

## 2.2 Registros en sistemas digitales

Los **registros** son elementos de almacenamiento que permiten guardar datos entre ciclos de reloj.

Se implementan mediante **flip-flops** y se utilizan para almacenar:

- operandos  
- resultados intermedios  
- direcciones  
- instrucciones  
- señales de control  

En este laboratorio se utilizarán registros para almacenar los operandos que serán procesados por la ALU.

Además, el sistema deberá conservar el **código de operación seleccionado**, de forma que la operación permanezca activa después de soltar los botones utilizados para seleccionarla.

---

## 2.3 Datapath simplificado

Debido a que la FPGA dispone de un número limitado de entradas físicas, los operandos no se introducirán simultáneamente. En su lugar se utilizará un **bus de datos compartido** y elementos de almacenamiento.

El sistema deberá permitir:

1. Ingresar un operando mediante los **switches**.  
2. Almacenar dicho valor como Operando A.  
3. Ingresar un segundo operando mediante los mismos switches.  
4. Almacenar dicho valor como Operando B.  
5. Seleccionar una operación aritmética o lógica.  
6. Conservar la operación seleccionada después de liberar los botones.  
7. Procesar ambos operandos mediante la **ALU**.  
8. Visualizar el resultado en los **LEDs**.  
9. Identificar visualmente la operación seleccionada mediante el **LED RGB**.

Este esquema representa una arquitectura básica de **datapath**, que será la base para sistemas de mayor complejidad en los laboratorios posteriores.

---

# 3. Procedimiento

## 3.1 Ejercicio 1: Diseño de la ALU

Diseñar una ALU de **4 bits** que ejecute las siguientes operaciones.

### Entradas

- Operando A de 4 bits  
- Operando B de 4 bits  
- Código de operación de 2 bits  

### Salida

- Resultado de 4 bits  

### Operaciones requeridas

| Código de operación | Operación |
|---------------------|-----------|
| 00 | Suma |
| 01 | Resta |
| 10 | AND |
| 11 | OR |

La ALU debe implementarse como **lógica combinacional**.

La ALU deberá desarrollarse como un **módulo independiente** del módulo superior del sistema.

Las operaciones aritméticas y lógicas no deberán implementarse directamente dentro del módulo encargado de conectar las entradas y salidas físicas de la FPGA.

La organización interna del módulo y la estrategia utilizada para implementar las operaciones deberán ser definidas por cada grupo, siempre que se cumplan los requisitos funcionales establecidos.

---

## 3.2 Ejercicio 2: Simulación de la ALU

Antes de implementar el diseño en hardware, se debe verificar su funcionamiento mediante simulación.

### Testbench requerido

El testbench debe:

- probar múltiples combinaciones de entrada  
- verificar todas las operaciones  
- comprobar diferentes valores de los operandos  
- generar un archivo de ondas para visualización  

### Proceso de simulación

1. Compilar el diseño y el testbench con Icarus Verilog.  
2. Ejecutar la simulación para generar el archivo de ondas.  
3. Visualizar las señales en GTKWave.

---

### Señales a analizar en GTKWave

Como mínimo se deberán observar:

- Operando A  
- Operando B  
- Código de operación  
- Resultado  

Durante la simulación se debe verificar:

- correcta ejecución de cada operación  
- coherencia entre entradas y resultados  
- cambios correctos del resultado al variar el código de operación  
- comportamiento combinacional de la ALU  

La simulación deberá permitir comprobar que la ALU responde correctamente ante cambios en cualquiera de sus entradas.

---

# 4. Requisitos del diseño

El sistema desarrollado deberá cumplir los siguientes requisitos.

## 4.1 Modularidad

El diseño deberá estar organizado utilizando **módulos funcionales independientes**.

Como mínimo, la ALU deberá implementarse como un módulo separado del módulo superior encargado de conectar el diseño con los recursos físicos de la FPGA.

El módulo superior deberá encargarse de integrar los diferentes elementos del sistema.

La forma específica en la que se distribuyan las demás funciones entre módulos queda a criterio de cada grupo.

---

## 4.2 ALU combinacional

La ALU deberá implementarse exclusivamente como **lógica combinacional**.

Por lo tanto:

- no deberá almacenar operandos
- no deberá almacenar resultados
- no deberá conservar estados anteriores
- su resultado deberá depender únicamente de sus entradas actuales

Los elementos de almacenamiento requeridos por el sistema deberán implementarse fuera de la ALU.

---

## 4.3 Almacenamiento de operandos

El sistema deberá permitir almacenar de manera independiente:

- Operando A
- Operando B

Una vez almacenados, los operandos deberán conservar su valor incluso si se modifica posteriormente la posición de los switches.

El mecanismo específico utilizado para realizar este almacenamiento deberá ser diseñado por cada grupo.

---

## 4.4 Selección de operación

El sistema deberá permitir seleccionar una de las cuatro operaciones disponibles mediante dos botones.

La selección realizada deberá **conservarse después de soltar los botones**.

Por lo tanto, no será necesario mantener presionados los botones durante la ejecución de una operación.

Cada botón deberá estar asociado a uno de los bits del código de operación y deberá permitir modificar dicho bit.

El mecanismo específico utilizado para detectar la interacción con los botones y conservar el código de operación deberá ser definido por cada grupo.

---

## 4.5 Indicador de operación mediante LED RGB

El sistema deberá utilizar el **LED RGB** como indicador visual de la operación actualmente seleccionada.

Cada una de las cuatro operaciones deberá estar asociada a un **color diferente**, de manera que sea posible identificar visualmente qué operación se encuentra activa.

Como requisito mínimo:

| Operación | Color |
|-----------|-------|
| Suma | Verde |
| Resta | Rojo |
| AND | Color definido por el grupo |
| OR | Color definido por el grupo |

Los grupos deberán seleccionar y documentar un color diferente para las operaciones **AND** y **OR**.

Los cuatro colores utilizados deberán ser distinguibles entre sí.

El color mostrado por el LED RGB deberá corresponder en todo momento al **código de operación almacenado** y deberá permanecer activo después de soltar los botones de selección.

La estrategia utilizada para generar y controlar los diferentes colores queda a criterio de cada grupo.

---

# 5. Implementación en FPGA

## Asignación de hardware

### Switches

Los switches representan el **bus de datos de 4 bits**.

| Switch | Función |
|--------|---------|
| SW0 | bit 0 |
| SW1 | bit 1 |
| SW2 | bit 2 |
| SW3 | bit 3 |

---

### Botones

Los botones controlan la carga de los operandos y la selección de la operación de la ALU.

| Botón | Función |
|-------|---------|
| BTN0 | cargar Operando A |
| BTN1 | cargar Operando B |
| BTN2 | modificar bit 0 del código de operación |
| BTN3 | modificar bit 1 del código de operación |

Los botones destinados a seleccionar la operación deberán modificar y almacenar el código correspondiente.

La operación seleccionada deberá permanecer activa después de soltar los botones.

---

### LEDs

Los LEDs muestran el resultado de la operación.

| LED | Función |
|-----|---------|
| LED0 | bit 0 del resultado |
| LED1 | bit 1 del resultado |
| LED2 | bit 2 del resultado |
| LED3 | bit 3 del resultado |

---

### LED RGB

El LED RGB deberá indicar mediante colores la **operación actualmente seleccionada**.

| Operación | Color |
|-----------|-------|
| Suma | Verde |
| Resta | Rojo |
| AND | Definido por el grupo |
| OR | Definido por el grupo |

Cada operación deberá tener un color diferente.

Los colores seleccionados para las operaciones AND y OR deberán ser especificados y documentados por el grupo en el `README.md` de la entrega.

El color deberá mantenerse mientras la operación correspondiente permanezca seleccionada.

---

# 6. Verificación en hardware

El funcionamiento del sistema deberá verificarse directamente sobre la FPGA.

Como mínimo, se deberá comprobar el siguiente comportamiento:

1. Colocar un valor en los switches.  
2. Cargar dicho valor como Operando A.  
3. Modificar la posición de los switches.  
4. Verificar que el Operando A conserve el valor previamente almacenado.  
5. Cargar un nuevo valor como Operando B.  
6. Seleccionar una de las operaciones disponibles.  
7. Soltar los botones utilizados para seleccionar la operación.  
8. Verificar que la operación permanezca seleccionada.  
9. Observar el resultado en los LEDs.  
10. Verificar que el LED RGB indique mediante el color correspondiente la operación seleccionada.  
11. Cambiar la operación sin modificar los operandos y verificar que el resultado se actualice correctamente.  
12. Verificar que el LED RGB cambie de acuerdo con la nueva operación seleccionada.  
13. Modificar nuevamente los switches y verificar que los operandos almacenados no cambien hasta que se realice una nueva carga.

Durante la demostración deberá comprobarse que:

- los operandos pueden almacenarse de manera independiente  
- los operandos permanecen almacenados después de modificar los switches  
- el código de operación permanece almacenado después de soltar los botones  
- la ALU ejecuta correctamente la operación seleccionada  
- no es necesario mantener presionado ningún botón para conservar una operación  
- el resultado cambia correctamente cuando se selecciona una operación diferente  
- el LED RGB identifica correctamente la operación seleccionada  
- las cuatro operaciones se identifican mediante colores diferentes  

---

# 7. Entregables

Cada grupo deberá entregar en el repositorio asignado:

## README.md

Debe incluir:

- explicación general del funcionamiento del sistema  
- descripción de la arquitectura propuesta  
- explicación de los módulos desarrollados  
- tabla de operaciones implementadas  
- explicación de la forma en que se almacenan los operandos  
- explicación de la forma en que se conserva el código de operación  
- tabla con los colores utilizados para identificar cada operación mediante el LED RGB  
- capturas de GTKWave  
- explicación del comportamiento observado durante la simulación  
- evidencia de la implementación funcional en FPGA  

---

## Carpeta src/

Debe incluir:

- archivos Verilog correspondientes al diseño desarrollado  
- módulo independiente de la ALU  
- módulo superior del sistema  
- cualquier módulo adicional desarrollado por el grupo  

---

## Carpeta sim/

Debe incluir:

- testbench utilizado para la simulación  
- archivo de ondas generado  
- capturas de GTKWave  

---

## Demostración en laboratorio

Cada grupo deberá demostrar:

- simulación funcional en GTKWave  
- implementación funcional en FPGA  
- ejecución correcta de todas las operaciones  
- almacenamiento correcto de los operandos  
- conservación de la operación seleccionada después de soltar los botones  
- correcta separación entre la lógica combinacional de la ALU y los elementos de almacenamiento del sistema  
- modularización adecuada del diseño  
- indicación correcta de la operación seleccionada mediante el LED RGB  
- uso de un color diferente para cada una de las cuatro operaciones  

---

# 8. Criterios de éxito

El laboratorio se considera correcto si se cumplen todas las siguientes condiciones:

- la ALU ejecuta correctamente todas las operaciones definidas  
- la ALU se encuentra implementada como un **módulo independiente de lógica combinacional**  
- las operaciones aritméticas y lógicas no se encuentran implementadas directamente dentro del módulo superior  
- la ALU no almacena información ni conserva estados anteriores  
- los operandos A y B pueden almacenarse de manera independiente  
- los operandos permanecen almacenados después de modificar los switches  
- el código de operación permanece almacenado después de soltar los botones  
- no es necesario mantener presionados los botones de selección para mantener una operación activa  
- el LED RGB indica correctamente la operación actualmente seleccionada  
- cada una de las cuatro operaciones utiliza un color diferente  
- los colores utilizados para AND y OR se encuentran especificados y documentados por el grupo  
- la simulación coincide con el comportamiento esperado  
- el diseño sintetiza correctamente en Vivado  
- el sistema responde correctamente a las entradas físicas de la FPGA  