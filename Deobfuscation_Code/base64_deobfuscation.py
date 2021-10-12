import sys
import os
import base64


def b_deobfuscation(deobfuscation) :
    b_str = deobfuscation
    b_str = b_str.encode('ascii')
    b_bytes = base64.b64decode(b_str)

    b_result = b_bytes.decode('ascii').split('\x00')

    print("deobfuscation_result : " + ''.join(b_result))
