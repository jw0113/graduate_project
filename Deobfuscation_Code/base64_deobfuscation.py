# Base64 decode하여 해제

import sys
import os
import base64


def b_deobfuscation(deobfuscation) :
    b_str = deobfuscation
    b_str = b_str.encode('ascii')
    b_bytes = base64.b64decode(b_str)

    b_result = b_bytes.decode('ascii').split('\x00')
    b_result = ''.join(b_result)

    #print("deobfuscation_result : " + ''.join(b_result))
    return b_result
