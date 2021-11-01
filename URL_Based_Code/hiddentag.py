# url의 html에서 <hidden>태그 확인

import urllib.request

def url_based_code(url_str) :
    try :
        url_html = urllib.request.urlopen(url_str)

        html_str = str(url_html.read().decode("utf-8"))
    
        find_result = html_str.find('<input type = "hidden"')
    
        if find_result == -1 :
            return False
        else :
            return True

    except :
        print("fail")
        return "fail"
