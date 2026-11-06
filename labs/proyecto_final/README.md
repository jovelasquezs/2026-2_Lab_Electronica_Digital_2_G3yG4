# Guía de Evaluación – Proyecto Final
**Electrónica Digital II | Laboratorio 2026-2**

## 1. Objetivo

El proyecto final tiene como propósito evaluar la capacidad de los estudiantes para diseñar, implementar e integrar un sistema digital funcional, aplicando los conocimientos desarrollados durante el curso.

La evaluación se realizará mediante una **sustentación presencial**, en la cual cada grupo deberá demostrar el funcionamiento del sistema, explicar su implementación y responder preguntas técnicas.

Se valorará especialmente el funcionamiento real del proyecto, la comprensión de su arquitectura y la calidad de la implementación.

## 2. Requisitos mínimos y restricciones del proyecto

Todos los proyectos deberán cumplir las siguientes condiciones:

### 2.1 Periféricos de entrada y salida

El sistema deberá implementar, como mínimo:

- **Dos (2) periféricos de entrada.**
- **Dos (2) periféricos de salida.**

**Restricciones:**
- Los LED no serán considerados periféricos de salida para el cumplimiento de este requisito.
- Los botones o pulsadores no serán considerados periféricos de entrada para el cumplimiento de este requisito.
- Los LED y botones podrán utilizarse como elementos auxiliares, pero no contarán dentro del mínimo exigido.
- Los periféricos deberán estar integrados al sistema y demostrar su funcionamiento durante la sustentación presencial.

### 2.2 Uso del procesador ARM y Vitis

El proyecto deberá utilizar obligatoriamente **al menos uno de los núcleos ARM del procesador Zynq de la tarjeta Zybo Z7**.

Para ello, los estudiantes deberán:

- Implementar una aplicación de software utilizando **AMD/Xilinx Vitis**.
- Ejecutar dicha aplicación sobre al menos uno de los núcleos ARM de la tarjeta.
- Integrar la ejecución del software con el funcionamiento del sistema desarrollado.
- Explicar el papel del procesador ARM dentro de la arquitectura del proyecto.
- Describir la comunicación entre hardware y software, cuando corresponda.

**No será suficiente implementar el proyecto únicamente mediante lógica programable (PL).** El procesador ARM deberá participar efectivamente en el funcionamiento del sistema.

## 3. Entregables

Cada grupo deberá entregar un repositorio en **GitHub** que contenga:

1. **README.md:** informe del proyecto que incluya descripción, objetivos, arquitectura, implementación, resultados y conclusiones.
2. **Video de funcionamiento:** evidencia audiovisual del sistema implementado, mostrando todas las funcionalidades desarrolladas.
3. **Código fuente:** archivos necesarios para revisar y reproducir el diseño, incluyendo el código desarrollado en Vitis.
4. **Diagramas:** arquitectura general, diagramas de bloques, FSM, ASM o diagramas de flujo, según corresponda.
5. **Archivos de implementación:** archivos de restricciones, configuración y exportación de hardware, según corresponda.

### 3.1 Requisitos del video

El video deberá estar disponible mediante un enlace accesible desde el `README.md` y mostrar claramente:

- La tarjeta Zybo Z7 y los periféricos utilizados.
- El funcionamiento de los periféricos de entrada y salida.
- La demostración de todas las funcionalidades implementadas.
- Diferentes casos de prueba que permitan verificar el comportamiento del sistema.
- Evidencia de la participación del procesador ARM en el funcionamiento del proyecto.
- Una explicación breve de lo que se observa en cada demostración.
- Los resultados obtenidos y las limitaciones o funcionalidades incompletas, cuando corresponda.

**El video deberá contener evidencia real del funcionamiento del proyecto**, y no únicamente simulaciones, diagramas o explicaciones teóricas.

## 4. Criterios de evaluación

### 4.1 Funcionamiento y demostración presencial — 2.0 puntos (40 %)

Se evaluará el funcionamiento real del sistema durante la sustentación presencial.

- Cumplimiento de los objetivos y funcionalidades propuestas.
- Correcto funcionamiento de los periféricos de entrada y salida.
- Integración de los módulos y periféricos utilizados.
- Ejecución e integración efectiva del software desarrollado en Vitis sobre el procesador ARM.
- Demostración del funcionamiento bajo diferentes condiciones y casos de prueba.

El funcionamiento parcial recibirá una calificación proporcional a las funcionalidades correctamente demostradas.

### 4.2 Diseño e implementación técnica — 1.0 punto (20 %)

Se evaluará la calidad técnica del diseño y su implementación.

- Arquitectura coherente y adecuada para el proyecto.
- Organización y modularidad del código.
- Implementación de los módulos de hardware y software.
- Uso adecuado de los conceptos y herramientas desarrollados durante el curso.
- Integración del procesador ARM y los periféricos dentro de la arquitectura del sistema.

### 4.3 Sustentación técnica — 1.0 punto (20 %)

Se evaluará la capacidad de los estudiantes para explicar y justificar el trabajo desarrollado.

- Comprensión del funcionamiento general del sistema.
- Explicación de la arquitectura y los módulos implementados.
- Justificación de las decisiones de diseño.
- Comprensión del funcionamiento del software desarrollado en Vitis y su relación con el hardware.
- Capacidad para responder preguntas técnicas relacionadas con el proyecto.

### 4.4 Documentación y repositorio — 1.0 punto (20 %)

Se evaluará la claridad, organización y calidad de la documentación entregada.

- README completo, claro y coherente con el sistema desarrollado.
- Video que demuestre todas las funcionalidades implementadas y los casos de prueba realizados.
- Código fuente completo, organizado y legible, incluyendo los archivos del proyecto desarrollado en Vitis.
- Diagramas y explicaciones técnicas que permitan comprender el diseño.
- Archivos necesarios para revisar y reproducir la implementación.
- Análisis de resultados, limitaciones y conclusiones técnicas.

La documentación debe permitir comprender el proyecto sin necesidad de haber presenciado la sustentación.

## 5. Rúbrica general

| Criterio | Puntos | Peso |
|---|---:|---:|
| Funcionamiento y demostración presencial | 2.0 | 40 % |
| Diseño e implementación técnica | 1.0 | 20 % |
| Sustentación técnica | 1.0 | 20 % |
| Documentación y repositorio | 1.0 | 20 % |
| **Total** | **5.0** | **100 %** |

## 6. Consideraciones finales

- Cada grupo deberá demostrar el funcionamiento del sistema implementado en la tarjeta Zybo Z7.
- El cumplimiento de los requisitos mínimos de periféricos y utilización del procesador ARM es obligatorio.
- El video de funcionamiento es un entregable obligatorio y deberá evidenciar las funcionalidades desarrolladas.
- Se evaluará el funcionamiento efectivamente demostrado y no solamente el descrito en el informe.
- Los errores, limitaciones y funcionalidades incompletas deberán identificarse y explicarse.
- El código fuente y los demás archivos deberán corresponder a la implementación presentada.