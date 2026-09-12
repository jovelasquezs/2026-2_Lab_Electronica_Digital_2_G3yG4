# Lab01: FPGA (Zybo Z7), Vivado/Vitis y Validación de Hardware

## Contenido
- Objetivos de aprendizaje  
- Fundamento teórico  
- Procedimiento  
- Descripción del HDL base  
- Entregables  

---

## 1. Objetivos de aprendizaje

- Instalar y verificar el correcto funcionamiento de **Vivado** y **Vitis**.
- Crear un proyecto para la tarjeta **Zybo Z7** y programar la FPGA mediante **JTAG**.
- Comprender el rol de los **constraints (.xdc)** para mapear señales HDL a pines físicos.
- Validar el funcionamiento de la tarjeta mediante un **Smoke Test**.
- Diseñar e implementar un **Test Funcional Personalizado** (lógica combinacional) usando:
  - **4 switches**
  - **6 botones**
  - **5 LEDs RGB**
- Integrar operaciones de **AND, OR, XOR** y una operación aritmética (**suma o resta de 4 bits**) en un diseño real sobre FPGA.

---

## 2. Fundamento teórico

### 2.1 FPGA vs simulación: del HDL a hardware real

En simulación (Lab00) se valida el comportamiento lógico en un entorno controlado.  
En una FPGA, ese mismo HDL se sintetiza y se implementa en hardware físico, por lo que entran en juego:

- El **reloj real** de la tarjeta.
- Entradas físicas (switches y botones) con rebote y tiempos no ideales.
- Salidas físicas (LEDs) que permiten observar resultados de forma directa.
- El mapeo físico de pines mediante **constraints**.

---

### 2.2 Constraints (.xdc) y mapeo de pines

El archivo `.xdc` define cómo se conectan las señales del módulo `top` con los pines reales de la tarjeta (IOs).  
Un diseño correcto en Verilog puede no funcionar en hardware si:

- Los pines están mal asignados.
- Se usó un estándar eléctrico incorrecto.
- Se conectó una señal a un pin inexistente o diferente.

**Idea clave:**  
El HDL define el hardware lógico, el `.xdc` define cómo ese hardware se conecta al mundo real.

---

### 2.3 Validación incremental: Smoke Test y Test Funcional

Antes de construir sistemas grandes (ALU, datapath, procesador), se valida el flujo completo:

1. Herramientas instaladas y funcionando.
2. Proyecto compila y genera bitstream.
3. La FPGA se programa sin errores.
4. Entradas/salidas funcionan como se espera.

Este laboratorio se enfoca en esa validación, y en la construcción de un test propio que obligue a usar
**lógica combinacional real** (compuertas + aritmética), para que cada que reciba en préstamo la tarjeta 
usted pueda verificar rápidamente su funcionamiento y como preparación inmediata para la ALU.

---

### 2.4 Manuales de referencia de la plataforma

Durante el desarrollo de esta práctica se trabajará con la tarjeta **Zybo Z7**, basada en el SoC **AMD Zynq-7000**. Para consultar información detallada sobre la tarjeta, sus periféricos, conexiones y arquitectura interna, se recomienda utilizar los siguientes manuales oficiales:

- **Zybo Z7 Reference Manual – Digilent**  
  Contiene información específica de la tarjeta de desarrollo, incluyendo distribución de pines, LEDs, botones, switches, reloj, conectores y demás periféricos disponibles.  
  [Consultar Zybo Z7 Reference Manual](https://digilent.com/reference/programmable-logic/zybo-z7/reference-manual)

- **Zynq-7000 SoC Technical Reference Manual (UG585) – AMD**  
  Describe la arquitectura interna del SoC Zynq-7000, incluyendo el Processing System (PS), memoria, periféricos, buses, interrupciones e interfaces entre el PS y la lógica programable (PL).  
  [Consultar Zynq-7000 SoC Technical Reference Manual](https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Introduction)

---

## 3. Procedimiento

### 3.0 Instalación de Vivado y Vitis

Este laboratorio utilizará:

- **Vivado**: diseño RTL, síntesis, implementación y generación de bitstream.
- **Vitis**: herramienta de desarrollo para flujo con procesadores (se instalará en este lab para dejar el entorno listo).

> Nota: Aunque Vitis se instala y verifica, el desarrollo de software sobre el PS (Zynq) se abordará más adelante.

#### 3.0.1 Instalación (Windows)
1. Cree una cuenta en la página de Xilinx en el siguiente (enlace)[https://www.amd.com/en/registration/create-account.html]
2. Descargue el instalador de Vivado y Vitis en el siguiente (enlace)[https://www.amd.com/en/support/downloads/adaptive-socs-and-fpgas/development-tools/2025-2.html]
3. A pesar de que existe la version 2026.1, usaremos la version 2025.2, por ende seleccione la versión  AMD Unified Installer for FPGAs & Adaptive SoCs 2025.2: Windows Self Extracting Web Installer (EXE - 233.33 MB)
![Seleccione el instalador para Windows](src/imgs/desc_vivado.png)
4. Una vez descargue, ejecute el instalador y seleccione **Vitis**
![Seleccione la primera opción - Vitis](src/imgs/ins_vivado_0.png)
5. Elija específicamente las opciones marcadas en la siguiente imagen, asegúrese de no instalar más ya que la instalación le ocupará mucho más espacio:
![Seleccione las siguientes opciones](src/imgs/ins_vivado_2.png)
6. Acepte todas las condiciones:
![Acepte condiciones y siguiente](src/imgs/ins_vivado_3.png)
7. Seleccione el directorio donde quiere que se instale Vivado seleccionando las opciones de la imagen:
![Seleccione su directorio y elija estas opciones](src/imgs/ins_vivado_4.png)
8. Presione instalar, no desconecte su computador de la red ni de la alimentación:
![Instale](src/imgs/ins_vivado_5.png)

Si trabaja sobre Linux (acuda a este repositorio)[https://github.com/jharamirezma/Lab_electronica_digital_2/blob/main/labs/lab00/Vivado_vitis_installation_guide.md] propiedad y autoría del Docente Jhon Ramírez.

#### 3.0.2 Licencia de Vivado

1. Una vez finalizada la instalación de Vivado, se abrirá **Vivado License Manager**. En esta ventana, haga clic en **Connect Now** e inicie sesión con su cuenta de AMD.

![Inicio de sesión en Vivado License Manager](src/imgs/Lic_Vivado_1.png)

2. Después de completar el formulario de acceso, aparecerá una ventana con los diferentes tipos de licencias disponibles. Seleccione **Vivado Basic Tier License, Node Locked License** y, posteriormente, haga clic en **Generate Node-Locked License**.

![Selección de la licencia Vivado Basic Tier](src/imgs/Lic_Vivado_2.png)

3. A continuación, se habilitará una nueva ventana. En ella, haga clic en **Add a Host**.

![Opción para agregar un equipo asociado a la licencia](src/imgs/Lic_Vivado_3.png)

4. Se abrirá un formulario en el que deberá ingresar información correspondiente a su computador.

![Formulario para registrar la información del equipo](src/imgs/Lic_Vivado_4.png)

5. Para obtener los datos solicitados, Vivado License Manager 2025.2 permite consultar la información del equipo desde la opción **View Host Information**. En esta ventana podrá identificar los datos necesarios para registrar correctamente su computador.

![Información del equipo en Vivado License Manager](src/imgs/Lic_Vivado_5.png)

6. Con la información obtenida en el paso anterior, complete los campos solicitados en el formulario mostrado en el paso 4 y haga clic en **Add**. Si la información fue ingresada correctamente, la ventana se cerrará y aparecerá nuevamente la pantalla de generación de licencia con el equipo registrado. Haga clic en **Next** para continuar.

![Equipo registrado para la generación de la licencia](src/imgs/Lic_Vivado_6.png)

7. Una vez generada la licencia, el archivo correspondiente será enviado al correo electrónico asociado a su cuenta de AMD. En el mismo mensaje recibirá las instrucciones necesarias para instalar y activar correctamente la licencia en Vivado.

8. Después de instalar correctamente el archivo de licencia, puede verificar su estado desde la opción **View License Status** de Vivado License Manager. Si la activación fue realizada correctamente, la licencia aparecerá registrada en esta ventana.

![Verificación del estado de la licencia en Vivado License Manager](src/imgs/Lic_Vivado_7.png)

Una vez verificada la activación de la licencia, puede cerrar **Vivado License Manager** y continuar utilizando Vivado normalmente.

---

### 3.1 Configuración del proyecto para Zybo Z7

1. Una vez instalado, debe abrir Vivado.
2. Cree un nuevo proyecto en Vivado. Defina un nombre y su ubicación:
![Defina nombre y ubicación](src/imgs/deploy_0.png)
3. En la ventana Project Type elija **RTL Project** y seleccione **Next**:
![Seleccione RTL Project](src/imgs/deploy_1.png)
4. En la ventana Add Sources debemos añadir los módulos de verilog, system verilog que tengamos creados para cada práctica/proyecto, por ejemplo:
![Añada módulos](src/imgs/deploy_2.png)
5. En la ventana **Add Constraints** debemos incluir el archivo *.xdc* de configuración de pines. Desgargue el archivo [aquí](https://github.com/Digilent/Zybo-Z7-10-XADC/blob/master/src/constraints/Zybo-Z7.xdc)
![Añada las constraints](src/imgs/deploy_3.png)
6. En la ventana Default Part debemos elejir la referencia de la FPGA que se encuentra en la tarjeta de desarrollo ZyboZ7, que para el caso de las tarjetas que tenemos en el LABDIEE, la referencia es xc7z010clg400.
![Añada la tarjeta](src/imgs/deploy_4.png)
7. En la ventana *New Project Summary* encontrará un resumen de la creación del proyecto, presione **Finish** y eso es todo.

---

### 3.2 Verificación del entorno en FPGA (Smoke Test)

#### Descripción

El docente proveerá un **Smoke Test** para validar que la tarjeta está operativa y que el mapeo
de entradas/salidas es el correcto. Montaremos el semáforo que diseñamos en la práctica anterior

#### Actividad 1

1. Descargue el *smoke test* en el siguiente [enlace](src/semaforo.v). Este corresponde a una versión básica del semáforo desarrollado en la práctica anterior.

2. Lea y comprenda el funcionamiento del código, identificando las señales de salida del módulo principal y su correspondiente asignación de pines en el archivo de restricciones `.xdc`. Para esta actividad se utilizará el LED RGB #6 de la Zybo Z7.

   Para asignar correctamente las salidas del diseño a los pines físicos de la FPGA, modifique el archivo `.xdc` de la siguiente manera:

   - Habilite las líneas correspondientes a las salidas que se van a utilizar, como se muestra en el recuadro verde.
   - Mantenga comentadas o deshabilite las líneas correspondientes a salidas que no serán utilizadas, como se muestra en el recuadro rojo.
   - Verifique que el nombre de cada señal indicado en `get_ports` coincida con las salidas definidas en el módulo `top`, resaltadas en verde en la imagen.
   - Compruebe que cada señal esté asociada al pin físico correspondiente de la Zybo Z7, identificado mediante `PACKAGE_PIN` y resaltado en amarillo.

   ![Asignación de pines en el archivo de restricciones XDC para el LED RGB #6](src/imgs/asignacion_pines_led_rgb.png)

3. Ejecute la síntesis y la implementación en Vivado. Posteriormente, programe la Zybo Z7 con el *bitstream* generado, siguiendo el procedimiento explicado en el tutorial visto en clase.

4. Verifique físicamente que el comportamiento del semáforo corresponda con el esperado.

> Si el Smoke Test no funciona correctamente, el estudiante debe resolver el problema de instalación, drivers,
cableado, o selección de tarjeta antes de continuar al Ejercicio 2.

---

### 3.3 Ejercicio 2: Test Funcional Personalizado (Diseño libre con criterios obligatorios)

En este ejercicio cada estudiante diseñará su propio sistema **combinacional** para validar rápidamente
que la FPGA, los pines y el `.xdc` funcionan correctamente.

---

#### Recursos disponibles

- **Entradas:**
  - `SW[3:0]` (4 switches)
  - `BTN[5:0]` (6 botones)

- **Salidas:**
  - `LED[3:0]` (4 LEDs verdes ON/OFF)
  - `LED_RGB` (1 LED RGB: canales R, G, B)

> Total salidas visuales disponibles:  
> - 4 bits binarios directos  
> - 3 canales RGB adicionales  

---

#### Requisitos de diseño (obligatorios)

El diseño debe cumplir **TODOS** los siguientes requisitos:

1. **Usar las 10 entradas disponibles**
   - Los 4 switches deben afectar el comportamiento.
   - Los 6 botones deben afectar el comportamiento.
   - No se permite dejar entradas sin uso.

2. Utilizar todas las salidas:
   - Los 4 LEDs verdes deben mostrar información útil.
   - El LED RGB debe usarse de manera significativa (no decorativa).

3. Incluir explícitamente en el HDL:
   - Al menos una operación **AND**
   - Al menos una operación **OR**
   - Al menos una operación **XOR**
   - Una operación aritmética de 4 bits:
     - **Suma** o **resta**

4. El diseño **NO puede ser trivial**:
   - No se permite "un botón enciende un LED".
   - No se permite cableado directo tipo `assign LED = SW;` como diseño principal.
   - Debe existir procesamiento lógico real.

---

#### Restricción adicional (para evitar diseños demasiado simples)

El diseño debe incluir **dos operandos de 4 bits** construidos a partir de combinaciones de:

- Switches
- Botones

Por ejemplo:

- `A = SW[3:0]`
- `B = {BTN3, BTN2, BTN1, BTN0}`

O cualquier combinación equivalente que use ambas fuentes.

---

#### Recomendación de estructura (altamente sugerida)

Se recomienda que:

- `LED[3:0]` muestren el resultado aritmético (suma o resta).
- El LED RGB indique información adicional:
  - Rojo → operación AND
  - Verde → operación OR
  - Azul → operación XOR
  - O bien banderas como:
    - Zero
    - Carry
    - Paridad

Esto permite verificar en menos de 2 minutos que:

- Las compuertas funcionan.
- La suma/resta funciona.
- Todas las entradas afectan el resultado.
- El `.xdc` está correctamente asignado.

---

#### Ejemplo orientativo (no obligatorio)

**Mini test lógico-aritmético**

- `A = SW[3:0]`
- `B = {BTN3, BTN2, BTN1, BTN0}`
- BTN4 selecciona suma/resta.
- BTN5 invierte B antes de operar.

Operaciones implementadas:

- `AND_result = A & B`
- `OR_result  = A | B`
- `XOR_result = A ^ B`
- `SUM_result = A + B`

Salidas:

- `LED[3:0] = SUM_result`
- `LED_RGB.R = |AND_result`  
  Se activa si el resultado de la operación AND contiene al menos un bit en `1`.
- `LED_RGB.G = |OR_result`  
  Se activa si el resultado de la operación OR contiene al menos un bit en `1`.
- `LED_RGB.B = |XOR_result`  
  Se activa si el resultado de la operación XOR contiene al menos un bit en `1`.

---

#### Evidencia requerida en el README

El estudiante debe incluir:

1. Descripción clara del diseño.
2. Explicación de:
   - Cómo se construyen los operandos.
   - Qué muestra cada LED.
3. Evidencia (foto o video) demostrando:
   - Funcionamiento correcto.
   - Uso de todas las entradas.
   - Uso de todas las salidas.
   - Presencia real de AND, OR, XOR y suma/resta en el código.

---

## 4. Descripción del HDL base

El repositorio del laboratorio debe incluir:

- Un módulo `top` (o wrapper) con las señales de entrada/salida definidas.
- Un archivo `.xdc` con el mapeo de pines provisto.
- Para el Ejercicio 1:
  - Un módulo combinacional principal (por ejemplo `test_funcional.v`)
  - Asignaciones claras para AND/OR/XOR y suma/resta.
  - Comentarios que indiquen qué se está mostrando en cada LED RGB.

> Nota: Aunque este ejercicio puede resolverse 100% combinacional, se recomienda mantener el diseño claro y modular
para facilitar el salto a ALU en el siguiente laboratorio.

---

## 5. Entregables

- Documentación del laboratorio en `README.md`, incluyendo:
  - Evidencia del Smoke Test (programación exitosa)
  - Evidencia y explicación del Ejercicio 1
- Carpeta `src/` con:
  - Código HDL del test funcional personalizado
  - (Opcional) módulos auxiliares reutilizables
- Demostración funcional durante la sesión de laboratorio

Todos los archivos deben ser cargados en el repositorio asignado en **Google Classroom**.
