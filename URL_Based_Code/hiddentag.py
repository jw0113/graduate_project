# url의 html에서 <hidden>태그 확인

import urllib.request
from bs4 import BeautifulSoup

def url_based_code(url_str) :
    try :
        headers = {'User-Agent' : 'Mozilla/5.0'}
        url_request = urllib.request.Request(url_str, headers=headers)
        url_html = urllib.request.urlopen(url_request)

        #html_str = str(url_html.read().decode("utf-8"))
        html_str = BeautifulSoup(url_html, 'html.parser')
        #print(html_str)
    
        find_result = html_str.find('<input type = "hidden"')
        find_result1 = html_str.find('<input type= "hidden"')
        find_result2 = html_str.find('<input type ="hidden"')
        find_result4 = html_str.find('<input type="hidden"')
    
        if find_result == -1 or find_result1 == -1 or find_result2 == -1 or find_result4 == -1 :
            return False
        else :
            return True

    except Exception as e:
        print(e)
        return "fail"

