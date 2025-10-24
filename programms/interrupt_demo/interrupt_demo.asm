LDIM r31 :int_handler
MST r31 hEEEE

LDIM r1 b0
LDIM r2 b0
LDIM r3 b0

:loop
MLD r2 b1
XOR r1 r2 r3
MST r3 b1
JMP :loop

:increment
ADDI r1 r1 b1
RET

:decrement
SUBI r1 r1 b1
RET

:int_handler
MLD r30 hDDDD

SUBI r30 r0 b0
BRC zero :btn0

SUBI r30 r0 b1
BRC zero :btn1

HLT

:btn0
CAL :increment
EIN
RET

:btn1
CAL :decrement
EIN
RET