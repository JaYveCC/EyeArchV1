LDIM r1 d0
LDIM r2 d1
:loop
ADD r1 r2 r1
MST r1 d1
ADD r1 r2 r2
MST r2 d1
JMP loop