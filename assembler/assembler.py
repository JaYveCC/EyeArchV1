#!/usr/bin/python
from sys import argv
file = open(argv[1], "r")
content = file.read()
programm = content.split('\n')

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

def parse_cond(operand):
    match operand:
        case 'zero':    return '00000'
        case 'nzero':   return '00001'
        case 'cout':    return '00010'
        case 'ncout':   return '00011'
        case 'odd':     return '00100'
        case 'even':    return '00101'
        case 'msb':     return '00110'
        case 'nmsb':    return '00111'

instructions = [['NOP'      , '000000', 'n', 'n', 'n'],
                ['ADD'      , '000001', 'r', 'r', 'r'],
                ['SUB'      , '000010', 'r', 'r', 'r'],
                ['OR'       , '000011', 'r', 'r', 'r'],
                ['AND'      , '000100', 'r', 'r', 'r'],
                ['XOR'      , '000101', 'r', 'r', 'r'],
                ['NOR'      , '000110', 'r', 'r', 'r'],
                ['NAND'     , '000111', 'r', 'r', 'r'],
                ['XNOR'     , '001000', 'r', 'r', 'r'],
                ['INV'      , '001001', 'n', 'r', 'r'],
                ['BSHL'     , '001001', 'r', 'r', 'r'],
                ['BSHR'     , '001011', 'r', 'r', 'r'],
                ['SBSHL'    , '001100', 'r', 'r', 'r'],
                ['SBSHR'    , '001101', 'r', 'r', 'r'],
                ['LDIM'     , '001110', 'n', 'r', 'i'],
                ['ADDI'     , '001111', 'r', 'r', 'i'],
                ['SUBI'     , '010000', 'r', 'r', 'i'],
                ['ORI'      , '010001', 'r', 'r', 'i'],
                ['ANDI'     , '010010', 'r', 'r', 'i'],
                ['XORI'     , '010011', 'r', 'r', 'i'],
                ['NORI'     , '010100', 'r', 'r', 'i'],
                ['NANDI'    , '010101', 'r', 'r', 'i'],
                ['XNORI'    , '010110', 'r', 'r', 'i'],
                ['BSHLI'    , '010111', 'r', 'r', 'i'],
                ['BSHRI'    , '011000', 'r', 'r', 'i'],
                ['SBSHLI'   , '011001', 'r', 'r', 'i'],
                ['SBSHRI'   , '011010', 'r', 'r', 'i'],
                ['ISUBI'    , '011011', 'r', 'r', 'i'],
                ['MLD'      , '011100', 'n', 'r', 'i'],
                ['MST'      , '011101', 'r', 'n', 'i'],
                ['PML'      , '011110', 'n', 'r', 'r'],
                ['PMS'      , '011111', 'r', 'r', 'n'],
                ['BRC'      , '100000', 'n', 'b', 'i'],
                ['JMP'      , '100001', 'n', 'n', 'i'],
                ['PBR'      , '100010', 'r', 'b', 'n'],
                ['PJM'      , '100011', 'r', 'n', 'n'],
                ['SJM'      , '100011', 'r', 'n', 'i'],
                ['HLT'      , '111111', 'n', 'n', 'n']]

for line in range(len(programm)):
    words = programm[line].split(' ')
    for instruction in instructions:
        if words[0] == instruction[0]:
            bin_programm[line][0] = instruction[1]
            operand_count = 1
            for operand in range(4):
                match instruction[operand + 1]:
                    case 'n':
                        bin_programm[line][operand] = '00000'
                    case 'r':
                        bin_programm[line][operand] = parse_reg(words[operand_count])
                        operand_count += 1
                    case 'i':
                        bin_programm[line][operand] = parse_imm(words[operand_count])
                        operand_count += 1
                    case 'b':
                        bin_programm[line][operand] = parse_cond(words[operand_count])
                        operand_count += 1
                        
            if len(bin_programm[line][3]) != 16:
                bin_programm[line][3] = '00000000000' + bin_programm[line][3]

            bin_programm[line].reverse()
bin_programm = [''.join(line) for line in bin_programm]
hex_programm = ["{:08x}".format(int(line, 2)) for line in bin_programm]
hex_programm = '\n'.join(hex_programm)
print(hex_programm)
file.close()