import serial

def readUint16(ser):    # write Fibonacci series up to n
     x0 = ord(ser.read())          # read one byte
     x1 = ord(ser.read())          # read one byte
     ret = x0 | (x1 << 8)
     return ret

def readUint32(ser):    # write Fibonacci series up to n
     x0 = ord(ser.read())          # read one byte
     x1 = ord(ser.read())          # read one byte
     x2 = ord(ser.read())          # read one byte
     x3 = ord(ser.read())          # read one byte
     ret = x0 | (x1 << 8) | (x1 << 16) | (x1 << 24)
     return ret



ser = serial.Serial('/dev/ttyUSB0', 115200, timeout=1)

while 1:
    v1 = readUint16(ser)
    v2 = readUint16(ser)
    v3 = readUint32(ser)
    print "values", v1, v2, v3

ser.close()


