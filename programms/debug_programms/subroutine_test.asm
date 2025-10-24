LDIM r31 :interrupt_dest
MST r31 hEEEE 
CAL :test_sub

LDIM r1 d0

:loop
ADDI r1 r1 b1
SUBI r1 r0 d50
BRC zero :halt
JMP :loop

:test_sub
LDIM r1 b1
MST r1 b1
RET

:interrupt_dest
MLD r2 hDDDD
MST r2 b11
RET

:halt
HLT