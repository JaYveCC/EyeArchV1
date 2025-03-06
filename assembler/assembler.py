#!/usr/bin/python
from sys import argv
file = open(argv[1], "r")
content = file.read()
programm = content.split('\n')
programm.pop(0)

bin_programm = [[0 for word in range(4)] for line in range(len(programm))]

def parse_reg(operand):
    if operand[0] == 'r':
        operand = operand[1:]
        operand = int(operand)
        if operand > 31:
            raise ValueError("register address does not exist: " + str(operand))
        operand = '{0:05b}'.format(operand)
        return operand
    else:
        raise ValueError("unknown register '" + operand + "'")

def parse_imm(operand):
    match operand[0]:
        case 'b':
            operand = operand[1:]
        case 'h':
            operand = operand[1:]
            operand = '{0:016b}'.format(int("0x" + operand, 16))
        case 'd':
            operand = operand[1:]
            operand = int(operand)
            operand = '{0:016b}'.format(operand)
    operand = operand + "".join(['0' for x in range(16 - len(operand))])
    if len(operand) == 16:
        return operand
    else:
        raise ValueError("immediate value does not fit in 16 bits")

def double_soruce_dest(opcode):
    bin_programm[line][0] = opcode
    bin_programm[line][1] = parse_reg(words[1])
    bin_programm[line][2] = parse_reg(words[2])
    bin_programm[line][3] = parse_reg(words[3]) + '00000000000'

for line in range(len(programm)):
    words = programm[line].split(' ')
    match words[0]:
        case 'NOP':
            bin_programm[line][0] = '000000'
            bin_programm[line][1] = '00000'
            bin_programm[line][2] = '00000'
            bin_programm[line][3] = '0000000000000000'
        case 'ADD':
            double_soruce_dest('000001')
        case 'SUB':
            double_soruce_dest('000010')
        case 'OR':
            double_soruce_dest('000011')
        case 'AND':
            double_soruce_dest('000100')
        case 'XOR':
            double_soruce_dest('000101')
        case 'NOR':
            double_soruce_dest('000110')
        case 'NAND':
            double_soruce_dest('000111')
        case 'XNOR':
            double_soruce_dest('001000')
        case 'INV':
            bin_programm[line][0] = '001001'
            bin_programm[line][1] = parse_reg(words[1])
            bin_programm[line][2] = '00000'
            bin_programm[line][3] = parse_reg(words[2]) + '00000000000'
        case 'BSHL':
            double_soruce_dest('001010')
        case 'BSHR':
            double_soruce_dest('001011')
        case 'SBSHL':
            double_soruce_dest('001100')
        case 'SBSHL':
            double_soruce_dest('001100')
        case 'SBSHR':
            double_soruce_dest('001101')
        case 'LDIM':
            bin_programm[line][0] = '001001'
            bin_programm[line][1] = '00000'
            bin_programm[line][2] = parse_reg(words[1])
            bin_programm[line][3] = parse_imm(words[2])

bin_programm = [''.join(line) for line in bin_programm]
hex_programm = ["{:08x}".format(int(line, 2)) for line in bin_programm]
hex_programm = '\n'.join(hex_programm)
print(hex_programm)
file.close()