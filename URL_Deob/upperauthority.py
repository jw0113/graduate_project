# URL에서 상위 탈취 가능성 파악

import json
import os
import importlib.util

def load_rules(path) :
    try :
        with open(path, "r", encoding="UTF8") as f:
            data = json.load(f)
        return data

    except:
        return {}

def url_deob(url_str):

    based_rule = load_rules("./rules/based_rules.json")
    for index in range(len(based_rule)) :
        if based_rule[index]['title'] == "BackSlash":
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule1 = mod.url_based_code(url_str)

        if based_rule[index]['title'] == "Dot" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule2 = mod.url_based_code(url_str)

        if based_rule[index]['title'] == "LenghOfURL" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule3 = mod.url_based_code(url_str)
        

    if rule1 and rule2 and rule3 :
        print(rule1, " , ", rule2, " , ", rule3)
        return True
    else :
        return False