# Interrupts

Implementation of interrupts for EyeArchV1

## Ports

There is a configurable anmount of interrupt ports.
An interrupt port consists of a 16 bit ID, a confirm bit and a acknowledge bit.
The 16 bit ID can be used as an identifier by the software interrupt handler to know what interrupt it is.
After the CPU puts an interrupt into the queue, it will pull the acknowledge bit, of the port that requested the interrupt, high.

If multiple interrupts happen in the same clock cycle, it will acknowledge the interrupt with the highest priority.

## Blocking and unblocking interrupts

Every time a interrupt gets executed, interrupts get automatically blocked so the interrupt handler has time to get ready for the next interrupt. Interrupts can be unblocked with the EIN instruction.

## Interrupt queue

Every time a interrupt happens the ID of interrupt gets pushed into a FIFO queue. When the interrupt handler is ready and interrupts get unblocked, the next interrupt in the queue will be executed.
If the queue is full, new interrupts will not be acknowledged untill there is space in the queue again.

## Callstack

Before executing an interrupt, the curent PC and flags will be pushed into the callstack. After returning from the interrupt using the RET instruction, the PC and flagregister will be set to the value in the callstack.
If the callstack is full, interrupts will be dissabled until there is space in the callstack again.
Using the RET instruction while not in a subroutine will do nothing.

## Interrupt related CSRs

There are 2 interrupt related CSRs:

- The branch destination address can be set to any value and will be used as the address to branch to when an interrupt happens.
- The interrupt ID will be put into a read only CSR.

## Interrupt related instructions

There are 3 interrupt related instructions:

- The RET instruction pops the callstack and uses its values to return to the previous subroutine/the main programm.
- The EIN instruction unblocks interrupts.
- The BIN instruction blocks interrupts.

## Operation

To send an interrupt, the I/O device has first input the right interrupt ID and then pull the confirm bit to high. The ID will be put into the interrupt queue.
When the interrupt handler is ready it will start executing the next interrupt in the queue.
Executing an interrupt will automatically block interrupts. It will push the current PC and flags on into the callstack.
After that it branches to the address in the interrupt destination address.
The software interrupt handler can then look at the interrupt ID CSR to determine what interrupt it is.
After the interrupt handler is ready it can use the EIN instructions to unblock interrupts.