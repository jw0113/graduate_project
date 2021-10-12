# Base64 난독화 해제 코드

import sys
import os
import base64

def b_deobfuscation(deobfuscation):

    b_str = deobfuscation

    # 문자열을 byte타입으로 인코딩 변환
    b_byte = base64.b64decode(b_str)
    # b_byte = base64.b64decode(b_str.encode('ascii'))

    # byte타입을 base64로 변환
    b_result = b_byte.decode('ascii')

    print("deobfuscation result : " + b_result)

