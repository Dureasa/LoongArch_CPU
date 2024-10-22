
/*            Opcode        */
`define     LU12IW        6'b000101
`define     PCADDU12I    6'b000111
`define     AL           6'b000000
`define     MEM          6'b001010
`define     BEQ          6'b010110
`define     BNE          6'b010111
`define     BLT          6'b011000
`define     BGE          6'b011001
`define     BLTU         6'b011010
`define     BGEU         6'b011011
`define     JIRL         6'b010011
`define     B            6'b010100
`define     BL           6'b010101

/*            Fun1        */
// AL
`define     AL_R    4'b0000
`define     ANDI    4'b1101
`define     ORI     4'b1110
`define     XORI    4'b1111
`define     ADDIW   4'b1010
// MEM
`define     LDW     4'b0010 
`define     STW     4'b0110

/*            Fun2        */
// AL_R
`define     ADDW    7'b0100000
`define     SUBW    7'b0100010
`define     AND     7'b0101010
`define     OR      7'b0101010
`define     NOR     7'b0101000
`define     XOR     7'b0101011
`define     SLT     7'b0100100