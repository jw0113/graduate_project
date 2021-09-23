import argparse
import os

def main():
    # 스프링을 만들기 전 Test용으로 터미널 창에서 파일을 업로드하여 탐지&해제하는 방식으로 진행
    # argparse : 명령창에서 인자 전달하면 받아서 진행하깅 위한 라이브러리
    # ArgumentParser 객체 생성 / description : 도움말 메시지
    parser = argparse.ArgumentParser(description="Test Python")

    # ArgumentParser에 인자 추가하기
    parser.add_argument('inputfile',type=str,help='input file')

    # 입력받은 인자값을 args에 저장하기
    args = parser.parse_args()
