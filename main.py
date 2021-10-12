import argparse
import os
import json
import re
import socket
import importlib.util

# 리스트로 파일 읽기
def load_file(path) -> list:
    try:
        print("path 값 : " + path)
        # 파일을 열고 모든 줄을 읽어오기
        file_list = open(path,"r",encoding="UTF8").readlines()
        return file_list
    except:
        print("Fail")
        return []

# Rule 읽어오기
def load_rules(rule_path) -> dict:
    try:
        # json파일 읽기
        with open(rule_path,"r",encoding="UTF8") as f:
            # json.load()함수를 이용해 내용을 dict형식으로 읽어온다.
            data = json.load(f)
        return data
    except:
        return {}

# 파일에서 악성코드 탐지하기
def match_rule(inputfile, rulefile) -> dict:

    result = {}

    # 파일 내용 중 \n이 있을 경우 한줄씩 검사
    # print('inputfile 크기 : ',len(inputfile))
    for index in range(len(inputfile)):
        temp = inputfile[index]
        match_result = []

        for size in range(len(rulefile)):
            # json형식 중 정규표현식 부분만 추출
            pattern = rulefile[size]["regexp"]

            # 미리 컴파일해두고 저장하는 방법
            regexp = re.compile(pattern)

            # 파일의 내용과 정규표현식 매칭
            match_re = re.findall(regexp, inputfile[index])

            #print("이게뭔지 확인",match_re)
            #print("size" , size)
            #print("크기 확인 : ", len(match_re))

            number = 0
            
            # 정규표현식에 해당되는 내용 추출하기(여러개 탐지될 경우를 대비)
            for match in match_re:
                while True:

                    # 매칭된 값을 파일 내용에서 찾음
                    matching = temp.find(match)

                    # 만일 매칭되는 값이 없다면 break
                    if matching == -1:
                        break

                    # 발견되었다면 문자열 추출하기
                    temp = temp[matching+len(match):]

                    # 탐지 결과 값을 추가한다.
                    match_result.append({'rule_no':rulefile[size]["no"], 'title':rulefile[size]["title"], 'descriptions':rulefile[size]["descriptions"], 'match':match, 'pos':(number+matching, number+matching+len(match)),
                                         'deobfuscation' : ''})

                    number += matching+len(match)
        result[str(index+1)] = match_result
        #print("result값 확인하자 : ",result)
    return result

# client가 보낸 파일 받기
def inputfiles(client_sock, size):

    # print("size확인 : ", size)
    file = client_sock.recv(int(size.decode('utf-8')))

    return file.decode('utf-8')

# 난독화 해제 코드
def deobfuscation(result,rules):
    result_deobfuscation = []
    

    for index in result :
        # print(result[index])
        # print(len(result[index]))
        
        if len(result[index]) != 0:

            for rule_index in range(len(rules)) :
                print(result[index][0]['rule_no'])
                print(rules[rule_index]['no'])
                
            
                if result[index][0]['rule_no'] == rules[rule_index]['no'] :

                    # 탐지 rule에서 해제 코드가 담겨있는 모듈 실행하기
                    deob_path = rules[rule_index]['deobfuscation']
                    deob_name = os.path.basename(deob_path)
                    
                    spec = importlib.util.spec_from_file_location(deob_name, deob_path)
                    mod = importlib.util.module_from_spec(spec)
                    spec.loader.exec_module(mod)
                    list_deob = mod.b_deobfuscation((result[index][0]['match']))
            
            # 탐지 부분 해제 코드 넣기
            #result_deobfuscation.append(list_deob)
            result[index][0]['deobfuscation'] = list_deob
            print('최종 result : ', result)
    



def main():
    
    # ------------------------- 스프링 전 TEST CODE -------------------------------------
    # 스프링을 만들기 전 Test용으로 터미널 창에서 파일을 업로드하여 탐지&해제하는 방식으로 진행
    # argparse : 명령창에서 인자 전달하면 받아서 진행하깅 위한 라이브러리
    # ArgumentParser 객체 생성 / description : 도움말 메시지
    #parser = argparse.ArgumentParser(description="Test Python")

    # ArgumentParser에 인자 추가하기
    #parser.add_argument("inputfile",type=str,help="input file")

    # 입력받은 인자값을 args에 저장하기
    #args = parser.parse_args()

    # 입력받은 파일을 리스트형식으로 가져오기
    #inputfile_list = load_file(args.inputfile)
    # -------------------------------------------------------------------------------------

    # socket통신을 이용해 연결 후 데이터크기 받아옴 (소켓 크기 설정 위해)
    host = "127.0.0.1"
    port = 5000
    server = socket.socket(socket.AF_INET)
    server.bind((host,port))
    server.listen(10)

    print("waiting...")
    client_sock, addr = server.accept()
    print("Connected by", addr)

    filesize = client_sock.recv(1024)
    # print("받아온 파일 : ", filesize)
    num = 1
    client_sock.send(num.to_bytes(4,byteorder='little'))

    # 데이터 크기만큼의 데이터 내용도 받아옴
    inputfile_list = inputfiles(client_sock, filesize)
    # print(type(inputfile_list))
    input_list = inputfile_list.split('\n')
    # print(input_list,type(input_list))

    # json형식으로 저장한 Rules 가져오기
    rule = load_rules("./rules/rules.json")

    # 읽어온 파일과 rule파일을 이용해 탐지하기
    result = match_rule(input_list, rule)
    print("result : ", result)

    # 탐지부분 난독화 해제 진행
    deobfuscation(result, rule)
    

    
    

    #print("json 내용 불러오기 : ",rule)
    #print("파일 내용 불러오기 : ",inputfile_list)

if __name__ == "__main__":
    main()
