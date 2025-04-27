MLD r3 d0
LDIM r4 d0
LDIM r1 d1
:loop
ADD r1 r2 r2
MST r2 d0
ADD r1 r2 r1
MST r1 d1
ADDI r4 r4 d1
SUB r3 r4 r0
BRC nzero loop
HLT