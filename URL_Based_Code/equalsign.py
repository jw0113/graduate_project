# URL에 '=' 탐지

def url_based_code(url_str) :
    str_list = list(url_str)

    num = 0

    for a in str_list :
        if a == '=':
            num += 1
            
    if num == 0 :
        print("No matching")
        return False
    else :
        print("matching")
        return True

def main():
    a = url_based_code("www.naver.com")
    print(a)

if __name__ == "__main__" :
    main()
