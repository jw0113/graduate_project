import argparse
import os
import json
import re

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

    # 파일 내용 중 \n이 있을 경우 한줄씩 검사
    for index in range(len(inputfile)):
        temp = inputfile[index]

        for size in range(len(rulefile)):
            # json형식 중 정규표현식 부분만 추출
            pattern = rulefile[size]["regexp"]

            # 미리 컴파일해두고 저장하는 방법
            regexp = re.compile(pattern)

            # 파일의 내용과 정규표현식 매칭
            match_re = re.findall(regexp, inputfile[index])

            print(match_re)
            
            # 정규표현식에 해당되는 내용 추출
            for match in match_re:
                while True:

                    # 매칭된 값을 파일 내용에서 찾음
                    match_index = temp.find(match)
                    
                    if match_index == -1 :
                        break
                    temp = temp[match_index+len(match):]



def main():
    # 스프링을 만들기 전 Test용으로 터미널 창에서 파일을 업로드하여 탐지&해제하는 방식으로 진행
    # argparse : 명령창에서 인자 전달하면 받아서 진행하깅 위한 라이브러리
    # ArgumentParser 객체 생성 / description : 도움말 메시지
    parser = argparse.ArgumentParser(description="Test Python")

    # ArgumentParser에 인자 추가하기
    parser.add_argument("inputfile",type=str,help="input file")

    # 입력받은 인자값을 args에 저장하기
    args = parser.parse_args()

    # 입력받은 파일을 리스트형식으로 가져오기
    inputfile_list = load_file(args.inputfile)

    # json형식으로 저장한 Rules 가져오기
    rule = load_rules("./rules/rules.json")

    # 읽어온 파일과 rule파일을 이용해 탐지하기
    result = match_rule(inputfile_list, rule)

    #print("json 내용 불러오기 : ",rule)
    #print("파일 내용 불러오기 : ",inputfile_list)

if __name__ == "__main__":
    main()