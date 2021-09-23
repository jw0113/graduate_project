import sys
import re
import os
import json
import glob
import argparse
import inspect
import importlib.util
import time
import webbrowser

html_text1 = """
    <!DOCTYPE html>
    <head>
        <link rel="stylesheet" href="temp.css">
        <script src="temp.js"></script>
    </head>
    <body>
        <div>
            <div id="left_section" class="left_box">
    """

html_text2 = """
            </div>
            <div class="right_box">
                <div id="section1" class="label">
                 res[match_idx][0]['rule_no'],res[match_idx][0]['title'],res[match_idx][0]['descriptions'])
                </div>
                <div class="elements">
                상세한 내용1
                </div>
            </div>
        </div>
    </body>
    </html>    
"""

def  load_rules(rule_path:str) -> dict:

    rules = {}

    rule_pattern = f'{rule_path}/*.json'
    rule_files = glob.glob(rule_pattern)

    for rule_file in rule_files:
        try:
            json_data = json.loads(open(rule_file).read()) 
            rules[str(json_data['no'])]= json_data
        except Exception as e:
            pass
    return rules

def load_malware(path:str) -> list:
    try:
        lines = open(path).readlines()
        return lines
    except:
        return []

def match_rule(lines:list, rules:list) -> dict:

    result = {}

    for line_idx in range(len(lines)):
        line_res = []

        for rule in rules.values():
            print(f'{line_idx+1} match {rule["title"]}')

            pattern = rule['regexp']
            regexp = re.compile(pattern)
            matched_list = re.findall(regexp, lines[line_idx])
            
            line_temp = lines[line_idx]

            current_pos = 0
            for matched in matched_list:
                
                while True:
                    matched_pos = line_temp.find(matched)

                    if matched_pos == -1:
                        break
                    line_temp = line_temp[matched_pos+len(matched):]
                    
            
                    line_res.append({'rule_no':rule["no"],'title':rule["title"], 'descriptions':rule["descriptions"], 'matched':matched, 'pos': (current_pos+matched_pos, current_pos+matched_pos+len(matched))})

                    current_pos += matched_pos+len(matched)

    #    for res in line_res:
    #        print(f'{res["rule_no"]} in {res["pos"]}')
        result[str(line_idx+1)] = line_res
    return result
       
def main():
    parser = argparse.ArgumentParser(description='Parse Script')
    parser.add_argument('input', type=str, 
                    help='input file')
    
    parser.add_argument('--rules', type=str, 
                    help='rule path')

    args = parser.parse_args()

    rule_path = './rules'
    if args.rules != None and  args.rules != '':
        rule_path = args.rules

    print('[+] Load Rules')
    rules = load_rules(rule_path)
    print(f'    [-] {len(rules)} rules loaded')

    source_lines = load_malware(args.input) # source_line : 파일 읽어옴. list 형식
    res = match_rule(source_lines, rules) # res : 읽은 파일에서 탐지된 내용에 대해 가져옴

    print(res)
    title_line=[]
    label=[]
    pre=[]
    result_deobfuscation=[]
    result_deobfuscations=[]
    b = []
#    print(rules)
    for match_idx in res:       # match_idx : 탐지된 수에 대한 번호 
        deobfuscation = (res[match_idx][0]['matched']) # res[match_idx][0] : 89번 라인대로 출력 dict 형식
        change_p = "<div class=\"pre\" onclick=\"display("+match_idx+");\" ><p id=pid" + match_idx + ">" + str(deobfuscation) + "</p></div>" # 탐지된 부분만 p태그, pid값 넣어줌
        for source_idx in source_lines:     # source_idx : 읽어온 파일을 엔터 단위로 리스트로 받아와서 인덱스 부여
            if deobfuscation in source_idx: # 각 줄마다 탐지된 내용 탐색. deobfuscation = 코드 중에서 난독화 된 내용
                source_idx = source_idx.replace(deobfuscation, change_p) # source_idx p 태그 넣은 형식으로 변경
                pre.append(source_idx)
                #print(pre)
        for rule_idx in rules :
            try :
                if res[match_idx][0]['rule_no'] == rules[rule_idx]['no'] :
                    title_line = [str(res[match_idx][0]['title']),str(res[match_idx][0]['descriptions'])]
                    label.append(title_line)
                
                    ob_path = rules[rule_idx]['deobfuscation']
                    mod_name = os.path.basename(ob_path)
                spec = importlib.util.spec_from_file_location(mod_name, ob_path)
                foo = importlib.util.module_from_spec(spec)
                spec.loader.exec_module(foo)
                list_deo = foo.deobfus_code(deobfuscation)
            except:
                continue
        result_deobfuscation.append(list_deo)

    """
        result_deobfuscations.extend(list_deo)
        for a in result_deobfuscations:
            if '\x00' in a:
                result_deobfuscations.remove(a)
        c = "".join(result_deobfuscations)
        result_deobfuscation.append(c)
        #print(list_deo)
        #print(result_deobfuscation)
        #print(type(d))
#        print(result_deobfuscation)           #->base64파일에서 받은 결과들의 리스트
    for result_idx in result_deobfuscation :
        result_idx = result_idx.replace("\x00","")
    """
    #temp.py
    right_box = ""
    funElements = ""
    html_head ="""<!DOCTYPE html>
    <head>
        <link rel="stylesheet" href="temp.css">
    </head>
    """

    html_body_1 ="""<body>
    <form>
        <div>
            <div id="left_section" class="left_box">
    """

    num = len(label)
    for i in range(num):
        funLabel = """
                <div>
                    <div class="label">
                        """+str(label[i])+"""
                    </div>
                    <div class="elements" id=\"ele"""+str(i+1)+"\" style=\"display: none\">"
        funElements = funLabel+str(result_deobfuscation[i])+"""            </div>
                </div>
        """
        right_box += funElements     


    html_body_2 ="""        </div>
        </div>
    
        <div class="right_box">
    """

    html_body_3 ="""    </div>
    </form>
        <script src="temp.js"></script>
    </body>
    """




    #result와 label은 같은 값이 들어가야하고, elements가 자세한 값
    #body1뒤에 누르면 열릴 결과값 텍스트
    #body2뒤엔 div 하나로 넣으면 됨


    html_text = str(html_head)+str(html_body_1)+str(pre)+str(html_body_2)+str(right_box)+str(html_body_3) 


    with open('report.html', 'w') as html_file:
        html_file.write(html_text)

    print("Create report.html")
    time.sleep(1)
    webbrowser.open_new_tab('report.html')    

"""
    with open('html_file.html', 'a') as html_file:
        html_file.write(html_text1)
        for source_idx in source_lines:
            html_file.write(source_idx)
        html_file.write(html_text2)
"""
    
if __name__ == '__main__':
    main()