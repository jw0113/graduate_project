# URL에 IP주소가 존재하는지 여부 파악

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
        if based_rule[index]['title'] == "Dot":
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule1 = mod.url_based_code(url_str)

        if based_rule[index]['title'] == "ContainDigits" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule2 = mod.url_based_code(url_str)

        

    if rule1 and rule2 :
        return True
    else :
        return False