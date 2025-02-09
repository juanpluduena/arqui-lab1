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