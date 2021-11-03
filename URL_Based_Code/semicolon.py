# URL에 ';' 탐지

def url_based_code(url_str) :
    str_list = list(url_str)

    num = 0

    for a in str_list :
        if a == ';':
            num += 1
            
    if num == 0 :
        return False
    else :
        return True
