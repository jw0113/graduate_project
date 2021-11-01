import base64


def base64_encode(str):

    # 문자열을 bytes 타입으로 인코딩 변환
    str_bytes = str.encode('ascii')
    print(str_bytes)

    # bytes 타입을 base64로 변환
    str_base64 = base64.b64encode(str_bytes)
    str_re = str_base64.decode('ascii')
    print(str_re)
    return str_re