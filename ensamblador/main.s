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
STUR X3, [XZR, #0]  // MEM[0] = 0xF
STUR X4, [XZR, #8]  // MEM[8] = 0x5
STUR X5, [XZR, #16] // MEM[16] = 0x0
STUR X6, [XZR, #24] // MEM[24] = 0xF
STUR X9, [XZR, #32] // MEM[32] = 0xD
STUR X10, [XZR, #40] // MEM[40] = 0x7

// Prueba de salto condicional
SUBS X11, X1, X2   // X11 = X1 - X2 = 0x5 (flags actualizados)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
B.EQ fin           // Si X1 == X2, salta a fin (no debería saltar)

// Prueba de Branch condicional
ADDIS X12, XZR, #0  // X12 = 0
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR
B.EQ salto          // Salta porque X12 es 0

NOP  // No debería ejecutarse si el salto funciona

salto: ADD X13, XZR, XZR  // X13 = 0 (solo para verificar que el salto funcionó)
ADD XZR, XZR, XZR
ADD XZR, XZR, XZR

fin: ADD XZR, XZR, XZR
NOP  // Fin del programa