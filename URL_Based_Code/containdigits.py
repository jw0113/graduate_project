# URL에 숫자 탐지
import re

def url_based_code(url_str) :

    pattern = "([0-9])"
    regexp = re.compile(pattern)

    match_digits = re.findall(regexp, url_str)

    if len(match_digits) == 0 :
        return False
    
    else :
        return True
