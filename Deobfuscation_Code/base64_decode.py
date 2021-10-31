import base64

def base64_decode(str) :
    # 문자열을 bytes 타입으로 인코딩 변환
    str_bytes = str.encode('ascii')

    # bytes 타입을 base64로 변환
    str_base64 = base64.b64decode(str_bytes)
    str_re = str_base64.decode('ascii')
    return str_re
    