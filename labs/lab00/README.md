# Lab00: Introducción a Verilog, Simulación y Máquinas de Estados Finitos (FSM)

## Contenido
- Objetivos de aprendizaje  
- Fundamento teórico  
- Procedimiento  
- Descripción del HDL base  
- Entregables  

---

## 1. Objetivos de aprendizaje

- Instalar y verificar el correcto funcionamiento de **Icarus Verilog** y **GTKWave**.
- Comprender la diferencia entre **lógica combinacional** y **lógica secuencial**.
- Diseñar e implementar **Máquinas de Estados Finitos (FSM)** sencillas en Verilog.
- Implementar sistemas que operan a lo largo de **varios ciclos de reloj**.
- Validar el comportamiento de los diseños mediante **testbench** y visualización de señales en GTKWave.

---

## 2. Fundamento teórico

### 2.1 Lógica secuencial y sincronización

A diferencia de la lógica combinacional, en la cual las salidas dependen únicamente de las entradas actuales, la lógica secuencial incorpora **elementos de memoria** que permiten almacenar información entre ciclos de reloj.  
El comportamiento del sistema depende del **estado previo** y de las entradas presentes, siendo el reloj el encargado de sincronizar los cambios.

En HDL, este tipo de lógica se describe típicamente mediante bloques `always @(posedge clk)`.

---

### 2.2 Máquinas de Estados Finitos (FSM)

Una Máquina de Estados Finitos es un modelo de control secuencial en el que el sistema:

- Se encuentra en **un solo estado a la vez**.
- Cambia de estado en función de:
  - El estado actual
  - Las entradas
- Produce salidas asociadas a los estados y/o transiciones.

Las FSM permiten describir de forma estructurada sistemas que requieren **control temporal**, siendo ampliamente utilizadas en:
- Unidades de control
- Protocolos
- Sistemas secuenciales complejos

---

### 2.3 Relación entre FSM y sistemas digitales complejos

Muchos sistemas digitales, como multiplicadores secuenciales, ALUs y procesadores, se construyen a partir de dos bloques principales:

- **Unidad de control** (FSM)
- **Datapath** (registros, sumadores, contadores, etc.)

Este laboratorio introduce estos conceptos de forma progresiva, preparando al estudiante para diseños más complejos en laboratorios posteriores.

---

## 3. Procedimiento

### 3.0.0 Instalación de Icarus Verilog (+GTK wave) y editor de código (Visual Studio Code)

Antes de iniciar los ejercicios del laboratorio, es necesario contar con un entorno básico para el desarrollo y simulación en Verilog.
Este laboratorio utilizará:

- **Icarus Verilog**: compilador y simulador de Verilog.
- **GTKWave**: visualizador de señales.
- **Visual Studio Code**: editor de código fuente.

#### 3.0.0.1 Instalación de Icarus Verilog y GTKWave

##### Windows
1. Descargue el instalador desde:
   - [[Icarus Verilog](https://bleyer.org/icarus/)]
2. Instale **Icarus Verilog** (el instalador incluye GTKWave). Es necesario tener muy claro la ruta donde fue instalada la aplicación, así como un entorno de carpetas bien organizado y claro, esto le hará más facul el trabajo.
3. Asegurese de instalar la versión full de Icarus Verilog (MinGW dependencies y GTKWave)
4. Verifique la correcta instalación ejecutando en la consola: "iverilog" en donde obtendrá de vuelta información sobre la versión instalada.

#### 3.0.0.2 Instalación de Visual Studio Code
1. Descargue el instalador desde:
   - [[Visual Studio Code](https://code.visualstudio.com)]

### 3.0 Verificación del entorno de trabajo (Smoke Test: si lo enciendo y no sale humo, al menos algo básico funciona)

1. Compile y simule un módulo combinacional simple en Verilog.
2. Genere un archivo `.vcd`.
3. Visualice las señales en GTKWave para verificar el correcto funcionamiento del entorno.

Paso a paso: 
Descargue el archivo [smoke_andor.v](src/smoke_andor.v) y el archivo [tb_smoke_andor.v](src/tb_smoke_andor.v) y visualícelos en Visual Studio Code (VSC).

Abra una nueva terminal dentro de VSC y ejecute los siguientes comandos:
1. Compilar (-o)
`iverilog -o tb_smoke_andor.vvp tb_smoke_andor.v`
2. Simular (vvp = generar el .vcd)
`vvp tb_smoke_andor.vvp`
3. Ver ondas en GTKWave
`gtkwave`
New tab, abrir el archivo .vcd, poner las señales de su interés:

![Resultado del smoke test en GTKWave](src/img/lab00_demo_gtkwave.png)

---

### 3.1 Ejercicio 1 (Grupal): FSM de control – Semáforo simple

#### Descripción
Diseñar un semáforo vehicular controlado por una FSM de **tres estados**, donde cada estado permanece activo durante un número fijo de ciclos de reloj.

#### Estados
- **S0:** Luz verde  
- **S1:** Luz amarilla  
- **S2:** Luz roja  

#### Duración de estados
- Verde: 5 ciclos  
- Amarillo: 2 ciclos  
- Rojo: 4 ciclos  

#### Entradas
- `clk`
- `rst`

#### Salidas
- `green`
- `yellow`
- `red`

#### Reglas
- Solo una salida puede estar activa a la vez.
- El sistema inicia siempre en el estado **Verde** después de un reset.
- La transición entre estados ocurre automáticamente al cumplirse el número de ciclos asignado.

---

### 3.2 Ejercicio 2 (Grupal): FSM con datapath – Acumulador secuencial

#### Descripción
Diseñar un sistema secuencial que acumula un valor de entrada durante varios ciclos, controlado por una FSM.

#### Entradas
- `clk`
- `rst`
- `start`
- `x[3:0]`

#### Salidas
- `acc[5:0]`
- `done`

#### Funcionamiento
1. **IDLE:**  
   - Espera la señal `start`.
2. **LOAD:**  
   - Inicializa el acumulador en cero.
3. **ADD:**  
   - Suma el valor `x` al acumulador durante un número determinado de ciclos.
4. **DONE:**  
   - Activa `done` por un ciclo y regresa a IDLE.

#### Variantes por grupo
- Sumar `x` 3 veces.
- Sumar `x` 4 veces.
- Sumar `x` hasta que `acc ≥ 20`.
- Incluir una señal de cancelación.


### 3.3 Ejercicio 3 (Grupal): Diseño y simulación de una ASM completa (Control + Datapath)

En este ejercicio se implementará un sistema secuencial que permita comprender el funcionamiento de una **Máquina de Estados Algorítmica (ASM)** en su forma completa, integrando:

- Control (máquina de estados)
- Datapath (registros y contadores)
- Temporización explícita
- Señales de inicio y finalización

El objetivo es mostrar el **panorama global del sistema**, no únicamente una FSM aislada.


#### Objetivo

Diseñar un transmisor serial síncrono de 8 bits que:

1. Reciba un byte de entrada.
2. Lo transmita bit a bit por una línea serial.
3. Controle la duración temporal de cada bit.
4. Indique cuándo la transmisión ha finalizado.

El diseño deberá verificarse mediante simulación en **Icarus Verilog + GTKWave**.


#### Entradas

- `clk` – Reloj del sistema.
- `rst` – Señal de reset.
- `start` – Pulso de inicio de transmisión (1 ciclo).
- `data_in[7:0]` – Byte a transmitir.


#### Salidas

- `tx` – Línea de salida serial.
- `busy` – Indica que la transmisión está en curso.
- `done` – Pulso de 1 ciclo al finalizar la transmisión.


#### Parámetro de temporización

El diseño debe incluir el parámetro:

```
parameter CLKS_PER_BIT = N;
```

Este parámetro define cuántos ciclos de clk dura cada bit transmitido.
Para simulación se recomienda usar valores pequeños (ej. 8, 10 o 16)

### Comportamiento esperado

##### Estado IDLE
- `busy = 0`
- `tx = 1` (línea en reposo)
- Espera la señal `start`.

##### Estado LOAD
- Carga `data_in` en un registro interno `shift_reg`.
- Reinicia:
  - `bit_count`
  - `tick_cnt`
- Activa `busy = 1`.

##### Estado TRANSMIT (BIT_HOLD / SHIFT_NEXT)

Por cada uno de los 8 bits:

- `tx` toma el valor del bit actual del registro (`shift_reg[0]` si es LSB primero).
- `tick_cnt` cuenta desde `0` hasta `CLKS_PER_BIT - 1`.
- Cuando `tick_cnt` alcanza el valor máximo:
  - Se reinicia `tick_cnt`.
  - Se desplaza `shift_reg`.
  - Se incrementa `bit_count`.
  - Se continúa con el siguiente bit.

Este proceso se repite hasta transmitir los 8 bits.

##### Estado DONE
- `done = 1` durante un solo ciclo de reloj.
- `busy = 0`.
- El sistema retorna al estado `IDLE`.


#### Requisitos de diseño (obligatorios)

El sistema debe incluir explícitamente:

- Una **ASM claramente definida**, con estados tales como:
  - `IDLE`
  - `LOAD`
  - `BIT_HOLD`
  - `SHIFT_NEXT`
  - `DONE`

- Un registro de desplazamiento:
  ```
  reg [7:0] shift_reg;
  ```
- Un contador de bits:
  ```
  reg [2:0] bit_count;
  ```
- Un contador de temporización:
  ```
  reg [$clog2(CLKS_PER_BIT)-1:0] tick_cnt;
  ```
#### Verificación en simulación

El repositorio debe incluir un **testbench** que permita verificar el funcionamiento completo del sistema.

El testbench debe:

1. Aplicar `rst` al inicio de la simulación.
2. Generar al menos **dos transmisiones distintas**, por ejemplo:
   - `8'hA5`
   - `8'h3C`
3. Generar el archivo `wave.vcd` para su posterior análisis en GTKWave.
4. Asegurar que la señal `start` sea un **pulso de un solo ciclo**.


#### Señales mínimas a visualizar en GTKWave

En la simulación deben visualizarse, como mínimo, las siguientes señales:

- `clk`
- `rst`
- `start`
- `state`
- `data_in`
- `shift_reg`
- `bit_count`
- `tick_cnt`
- `tx`
- `busy`
- `done`

El análisis debe permitir observar:

- La transición correcta entre estados.
- La duración exacta de cada bit transmitido.
- El desplazamiento progresivo de `shift_reg`.
- El incremento adecuado de `bit_count`.
- La activación correcta de `busy` y `done`.

#### Evidencia requerida en el README

El informe debe incluir:

- Descripción breve de la ASM implementada.
- Explicación del funcionamiento observado en GTKWave.
- Confirmación explícita de:
  - Transmisión correcta de los 8 bits.
  - Duración exacta de cada bit (`CLKS_PER_BIT` ciclos).
  - Activación correcta de `busy` durante la transmisión.
  - Activación de `done` por un único ciclo al finalizar.
 
#### Criterios de éxito

El ejercicio se considera correcto si se cumplen todas las siguientes condiciones:

- Se transmiten correctamente los 8 bits del dato de entrada en el orden especificado.
- Cada bit permanece estable durante exactamente `CLKS_PER_BIT` ciclos de reloj.
- La señal `busy` se mantiene activa durante toda la transmisión.
- La señal `done` se activa por un único ciclo al finalizar el envío del byte.
- La evolución interna del sistema (estado, contadores y registro de desplazamiento) es coherente y verificable en la simulación.



---

## 4. Descripción del HDL base

Cada diseño debe incluir:

- Registro de **estado actual**.
- Lógica de **siguiente estado**.
- Lógica de **salidas**.
- Contadores internos cuando sea necesario.
- Señal de reset síncrona o asíncrona.

Cada módulo debe estar acompañado de su **testbench**, el cual incluya:
- Generación de reloj.
- Aplicación de reset.
- Estímulos adecuados para verificar todos los estados.
- Generación del archivo `.vcd`.

---

## 5. Entregables

- Documentación del laboratorio en el archivo `README.md`.
- Carpeta `src/` con:
  - Código HDL de cada ejercicio.
  - Testbench correspondiente.
- Evidencias de simulación (capturas de GTKWave).
- Demostración funcional durante la sesión de laboratorio.

Todos los archivos deben ser cargados en el repositorio asignado en **GitHub Classroom**.

---

## Recursos adicionales
- [Video ¿Qué es una máquina de estados y cómo se escriben en verilog?](https://www.youtube.com/watch?v=tzxaf-CNU3Q)
- [Video ¿Cómo escribir una FSM en verilog?](https://www.youtube.com/watch?v=ENH-8zZLbK8&list=PLewEhUg0vlYzLnNKIO6SEWh91uAgBw5K8)
- [Video Semáforo avanzado análisis y verilog](https://www.youtube.com/watch?v=77OjVgGVmSs)

