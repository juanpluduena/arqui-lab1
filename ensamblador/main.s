// B.EQ Test (equal)
ADDS X1, X1, XZR      // Set condition flags: X1 = 1
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.EQ L1               // If Z == 1 (equal), doesnt branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X5, [X0, #0]     // MEM[32] = 0x5
L1: STUR X6, [X0, #8] // MEM[33] = 0x6

// B.NE Test (not equal)
SUBS X2, X1, XZR      // Set condition flags: X2 = 1
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.NE L2               // If Z == 0 (not equal), branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X7, [X0, #16]    // MEM[34] = 0x7 (won't be executed)
L2: STUR X4, [X0, #24] // MEM[35] = 0x4

// B.HS Test (unsigned higher or same, C == 1)
SUBS X3, X8, #1
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.HS L3               // If C == 1, branch taken
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X9, [X0, #32]    // MEM[36] = 0x9 won't be executed
L3: STUR X4, [X0, #40] // MEM[37] = 0x4

// B.LT Test (signed less than)
SUBS X1, X1, #2      // Set condition flags: X1 = 1 - 2 = -1 (N = 1)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.LT L4               // If N != V (negative, less than), branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X11, [X0, #48]    // MEM[38] = 0xB (won't be executed)
L4: STUR X12, [X0, #56] // MEM[39] = 0xC

// B.LE Test (signed less than or equal)
SUBS X2, X1, #1      // Set condition flags: X2 = 1 - 1 = 0 (Z = 1)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.LE L5               // If Z == 1 (zero) or N == V, branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X13, [X0, #64]   // MEM[40] = 0xD (won't be executed)
L5: STUR X14, [X0, #72] // MEM[41] = 0xE

// B.GT Test (signed greater than)
ADD X1, X0, #1
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
SUBS X3, X1, #0      // Set condition flags: X3 = 1 - 0 = 1 (Z = 0)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.GT L6               // If Z == 0 and N == V, branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X15, [X0, #80]   // MEM[42] = 0xF (won't be executed)
L6: STUR X4, [X0, #88] // MEM[43] = 0x4

// B.GE Test (greater than or equal)
ADDS X1, X1, #1       // X1 = 1 (set condition flags)
ADD XZR, XZR, XZR      // Resolve dependency
ADD XZR, XZR, XZR      // Resolve dependency
SUBS X2, X1, #1       // X2 = 2 - 1 = 1 (N = 0, V = 0)
ADD XZR, XZR, XZR      // Resolve dependency
ADD XZR, XZR, XZR      // Resolve dependency
B.GE L7                // If N == V (branch taken)
ADD XZR, XZR, XZR      // Resolve dependency
ADD XZR, XZR, XZR      // Resolve dependency
ADD XZR, XZR, XZR      // Resolve dependency
STUR X17, [X0, #96]   // MEM[44] = 0x11 (won't be executed)
L7: STUR X12, [X0, #104] // MEM[45] = 0xC

//B.LO Test (unsigned lower, C == 0)
SUB X10, X10, X10
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
SUBS X2, X10, #2      // Set condition flags: X2 = 0 - 2 (C = 0)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.LO L8               // If C == 0, branch (lower)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X19, [X0, #112]  // MEM[46] = 0x13 (won't be executed if branch taken)
L8: STUR X20, [X0, #120] // MEM[47] = 0x14

// B.MI Test (signed minus, N == 1)
SUBS X3, X10, #2       // Set condition flags: X3 = 0 - 2 (N = 1)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.MI L9               // If N == 1 (negative), branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X21, [X0, #128]  // MEM[48] = 0x15 (won't be executed if branch taken)
L9: STUR X22, [X0, #136] // MEM[49] = 0x16

// B.PL Test (positive, N == 0)
ADDS X4, X10, #1       // Set condition flags: X4 = 1 (N = 0)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.PL L10               // If N == 0 (positive), branch
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X23, [X0, #144]  // MEM[50] = 0x17 (won't be executed if branch taken)
L10: STUR X24, [X0, #152] // MEM[51] = 0x18

// B.LS Test (unsigned lower or same, C == 0 or Z == 1)
SUBS X4, X10, #2       // Set condition flags: X4 = -2 (C = 0)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.LS L11              // If C == 0 or Z == 1, branch taken
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X25, [X0, #160]  // MEM[52] = 0x19 (won't be executed if branch taken)
L11: STUR X26, [X0, #168] // MEM[53] = 0x1A

// B.VC Test (overflow clear, V == 0)
ADDS X1, X1, #1          // Usar X1 para evitar overflow
ADD XZR, XZR, XZR         // Resolve dependency
ADD XZR, XZR, XZR         // Resolve dependency
B.VC L14                  // If V == 0 (no overflow), branch
ADD XZR, XZR, XZR         // Resolve dependency
ADD XZR, XZR, XZR         // Resolve dependency
ADD XZR, XZR, XZR         // Resolve dependency
STUR X11, [X0, #176]     // MEM[54] = 0xB (won't be executed if branch taken)
L14: STUR X12, [X0, #184] // MEM[55] = 0xC

// B.HI Test (unsigned higher, C == 1 and Z == 0)
SUBS X5, X5, #1       // Set condition flags: X5 = 1 (C = 1, Z = 0)
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
B.HI L12              // If C == 1 and Z == 0, branch taken
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
ADD XZR, XZR, XZR     // Resolve dependency
STUR X27, [X0, #192]  // MEM[56] = 0x1B (won't be executed if branch taken)
L12: STUR X12, [X0, #200] // MEM[57] = 0xC
