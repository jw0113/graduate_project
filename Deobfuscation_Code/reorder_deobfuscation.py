# Powershell - reorder 해제 코드
import re

def b_deobfuscation(deobfuscation) :

    result = {}

    # {1} 이 부분만 추출
    key_pattern = "([{\d+}]{2,})"
    regexp1 = re.compile(key_pattern)
    key_list = re.findall(regexp1, deobfuscation)

    # 'a' 이 부분만 추출
    value_pattern = "([\'\"]\w.{1,}[\'\"])"
    regexp2 = re.compile(value_pattern)
    value_list = re.findall(regexp2, deobfuscation)
    value_list = value_list[0].split(",")

    # {1}에서 숫자 부분만 추출
    for a in key_list :
        key_p = "(\d)"
        reg = re.compile(key_p)
        key = re.findall(reg,a)


    # key : 숫자, value : 데이터 형식으로 dict 생성
    for num in range(len(key)):
        result[str(key[num])] = str(value_list[num])

    # sort진행
    result = sorted(result.items())

    # value만 모아서 문자열 생성
    result_deobfuscation = str()
    for key, value in result : 
        result_deobfuscation += value
    
    result_deobfuscation = result_deobfuscation.replace("'","")
    result_deobfuscation = result_deobfuscation.replace('"',"")
    
    return result_deobfuscation
