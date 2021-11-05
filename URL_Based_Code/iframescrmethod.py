# url의 html에서 <iframe>태그에서 src 속성 확인

import urllib.request
from bs4 import BeautifulSoup

def url_based_code(url_str) :
    try :
        headers = {'User-Agent' : 'Mozilla/5.0'}
        url_request = urllib.request.Request(url_str, headers=headers)
        url_html = urllib.request.urlopen(url_request)

        #html_str = str(url_html.read().decode("utf-8"))
        html_str = BeautifulSoup(url_html, 'html.parser')
    
        html_split = html_str.split('<')
        html_result = []
        for a in html_split :
            if a.find("iframe"):
                html_result.append(a)
        
        num = 0
        for b in html_result :
            if b.find("src") :
                num += 1

        if num == 0 :
            return False
        else :
            return True

    except Exception as e:
        print(e)
        return "fail"
