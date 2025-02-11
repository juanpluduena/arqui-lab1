# Arquitectura del Computador 2024
Laboratorio 1 de Arquitectura del Computador 2024

## Ejercicio 1

Las modificaciones que se realizaron fueron en los modulos:
- `aludec.sv`: Se agregaron las condiciones para redireccionar alucontrol dependiendo del opcode ADDI o SUBI.
- ` maindec.sv`: Se agregaron los opcode correspondientes a ADDI y SUBI según LEGv8 Green Card.
- `signext.sv`: Se agregó extensión de signo para el valor inmediato que toman las instrucciones ADDI y SUBI.

No hubo necesidad de agregar señales ni módulos además de los ya existentes.

El programa de assembler empleado para realizar el test consta de modificar el contenido en MEM 2 tal que sea 0x7, por lo que primero con ADDI le sumamos 8 al registro X3 y luego con SUBI le restamos 1 al mismo registro.

Código:
```assembly
                              // Dirección:valor
         STUR X1, [X0, #0]    // MEM 0:0x1
         STUR X2, [X0, #8]    // MEM 1:0x2
         ADDI X3, XZR, #8
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         SUBI X3, X3, #1
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X3, [X16, #0]   // MEM 2:0x7
         ADD X3, X4, X5
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X3, [X0, #24]   // MEM 3:0x9
         SUB X3, X4, X5
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X3, [X0, #32]   // MEM 4:0xFFFFFFFFFFFFFFFF
         SUB X4, XZR, X10
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X4, [X0, #40]   // MEM 5:0xFFFFFFFFFFFFFFF6
         ADD X4, X3, X4
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X4, [X0, #48]   // MEM 6:0xFFFFFFFFFFFFFFF5
         SUB X5, X1, X3
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X5, [X0, #56]   // MEM 7:0x2
         AND X5, X10, XZR
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X5, [X0, #64]   // MEM 8:0x0
         AND X5, X10, X3
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X5, [X0, #72]   // MEM 9:0xA
         AND X20, X20, X20
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X20, [X0, #80]  // MEM 10:0x14
         ORR X6, X11, XZR
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X6, [X0, #88]   // MEM 11:0xB
         ORR X6, X11, X3
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X6, [X0, #96]   // MEM 12:0xFFFFFFFFFFFFFFFF
         LDUR X12, [X0, #0]
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         ADD X7, X12, XZR
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X7, [X0, #104]  // MEM 13:0x1
         STUR X12, [X0, #112] // MEM 14:0x1
         ADD XZR, X13, X14
         STUR XZR, [X0, #120] // MEM 15:0x0
         CBZ X0, L1
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X21, [X0, #128] // MEM 16:0x0(si falla CBZ =21)
L1:      STUR X21, [X0, #136] // MEM 17:0x15
         ADD X2, XZR, X1
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
L2:      SUB X2, X2, X1
         ADD X24, XZR, X1
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X24, [X0, #144] // MEM 18:0x1 y MEM 19=0x1
         ADD X0, X0, X8
         CBZ X2, L2
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X30, [X0, #144] // MEM 20:0x1E
         ADD X30, X30, X30
         SUB X21, XZR, X21
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         ADD X30, X30, X20
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         LDUR X25, [X30, #-8]
         ADD XZR, XZR, XZR
         ADD X30, X30, X30
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         ADD X30, X30, X16
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         STUR X25, [X30, #-8] // MEM 21:0xA (= MEM 9)
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
finloop: CBZ XZR, finloop
         ADD XZR, XZR, XZR
         ADD XZR, XZR, XZR
         
```

## Ejercicio 2

Las modificaciones que se realizaron fueron en los modulos:
- `alu.sv`: Se agregaron las flags `Z`, `N`, `V`, `C` y la señal `write_flags`. Además se actualizaron las operaciones de suma y resta para manejar instrucciones con banderas.
- `aludec.sv`: Se agregaron códigos de control para instrucciones con banderas (ADDS, SUBS, ADDIS, SUBIS), permitiendo su correcta decodificación.
- `controller.sv`: Se agregó la señal `condBranch` para identificar instrucciones de salto condicional y habilitar su procesamiento en el datapath.
- `datapath.sv`: Se integró el nuevo módulo `bCondCheck` para evaluar condiciones de salto basadas en las banderas de estado. Además, se incluyó el registro `CPSR_flags` mediante `flopenr.sv` para almacenar las banderas de estado del procesador.
- `execute.sv`: Se expandió la ALU para que genere las banderas de estado y la señal `write_flags`, asegurando su propagación correcta dentro del datapath.
- `maindec.sv`: Se agregaron los opcode de las nuevas instrucciones. Además, se añadió la señal `condBranch` a la decodificación de instrucciones, permitiendo diferenciar los saltos condicionales.
- `memory.sv`: Se modificó la asignación de `PCSrc_M` para incluir la nueva señal `condBranch`, permitiendo la ejecución de saltos condicionales basados en las banderas de estado.
- `processor_arm.sv`: Se añadieron señales de control adicionales: `PCSrc`, `condBranch`, `instr`, `IM_addr`.
- `signext.sv`: Se actualizaron las instrucciones soportadas en la extensión de signo para incluir las instrucciones ADDIS y SUBIS.

Se agregaron nuevos módulos:
- `bCondCheck.sv`: Se creó este módulo para evaluar las condiciones de salto condicional usando las banderas de estado del procesador. Permite determinar si una instrucción condicional debe ejecutarse o no.
- `flopenr.sv`: Este módulo implementa un registro con habilitación (en), usado para almacenar las banderas de estado (Z, N, V, C) y actualizar su valor solo cuando sea necesario.

Se modificó el testbench:
- `processor_tb.sv`: Se agregaron nuevas señales (`PCSrc`, `condBranch`, `instr`, `IM_addr`) para evaluar el comportamiento del procesador con instrucciones condicionales.

Diagrama del microprocesador:

**PROCESSOR_ARM:**  
![processor_arm](/assets/processor_arm.png "processor_arm")

**CONTROLLER:**  
![controller](/assets/controller.png "controller")

**DATAPATH:**  
![datapath](/assets/datapath.png "datapath")


El programa que se usó para testear las nuevas instrucciones es el siguiente:
```assembly
// Inicialización de registros
ADDI X1, XZR, #10    // X1 = 0xA
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
ADDI X2, XZR, #5     // X2 = 0x5
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Prueba de operaciones aritméticas
ADD X3, X1, X2      // X3 = X1 + X2 = 0xA + 0x5 = 0xF
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
SUB X4, X1, X2      // X4 = X1 - X2 = 0xA - 0x5 = 0x5
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
AND X5, X1, X2      // X5 = X1 & X2 = 0xA & 0x5 = 0x0
ORR X6, X1, X2      // X6 = X1 | X2 = 0xA | 0x5 = 0xF

// Prueba de versiones con "S" (cambian flags)
ADDS X7, X1, X2     // X7 = X1 + X2 = 0xF (actualiza flags)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
SUBS X8, X1, X2     // X8 = X1 - X2 = 0x5 (actualiza flags)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Prueba de instrucciones inmediatas
ADDIS X9, X1, #3    // X9 = X1 + 3 = 0xA + 3 = 0xD
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
SUBIS X10, X1, #3   // X10 = X1 - 3 = 0xA - 3 = 0x7
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Prueba de carga y almacenamiento
STUR X3, [X0, #0]  // MEM 0: 0xF
STUR X4, [X0, #8]  // MEM 1: 0x5
STUR X5, [X0, #16] // MEM 2: 0x0
STUR X6, [X0, #24] // MEM 3: 0xF
STUR X9, [X0, #32] // MEM 4: 0xD
STUR X10, [X0, #40] // MEM 5: 0x7

// Prueba de salto condicional
SUBS X11, X1, X2   // X11 = X1 - X2 = 0x5 (flags actualizados)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
B.EQ fin           // Si X1 == X2, salta a fin (no debería saltar)

ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

// Prueba de Branch condicional
ADDIS X12, XZR, #0  // X12 = 0
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
B.EQ salto          // Salta porque X12 es 0

ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
STUR X11, [X0, #48] // No debería ejecutarse si el salto funciona, MEM 6: 0x0
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

salto: ADD X13, XZR, XZR  // X13 = 0 (solo para verificar que el salto funcionó)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

fin: CBZ XZR, fin

```