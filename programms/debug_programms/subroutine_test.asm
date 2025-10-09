LDIM r31 :interrupt_dest
MST r31 hEEEE 
CAL :test_sub

:loop
JMP :loop

:test_sub
LDIM r1 b1
MST r1 b1
RET

:interrupt_dest
MLD r2 hDDDD
MST r2 b11
HLT