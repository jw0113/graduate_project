# URL의 길이가 65 이상인지 탐지

def url_based_code(url_str) :

    if len(url_str) > 65 :
        return True
    else :
        return False
