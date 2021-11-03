# url의 html에서 </html>태그가 존재하지 않는 경우 확인

import urllib.request

def url_based_code(url_str) :
    try :
        url_html = urllib.request.urlopen(url_str)

        html_str = str(url_html.read().decode("utf-8"))
    
        find_result = html_str.find('</html>')
    
        if find_result == -1 :
            return True
        else :
            return False

    except Exception as e:
        print(e)
        return "fail"
