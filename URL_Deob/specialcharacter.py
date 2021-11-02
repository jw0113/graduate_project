# URL에 특수문자가 있는지 파악

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
    print(based_rule[0]['title'])
    for index in range(len(based_rule)) :
        if based_rule[index]['title'] == "AtMark":
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule1 = mod.url_based_code(url_str)

        if based_rule[index]['title'] == "EqualSign" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule2 = mod.url_based_code(url_str)

        if based_rule[index]['title'] == "Hypen" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule3 = mod.url_based_code(url_str)
        
        if based_rule[index]['title'] == "SemiColon" :
            rule_path = based_rule[index]["code_location"]
            rule_name = os.path.basename(rule_path)

            spec = importlib.util.spec_from_file_location(rule_name, rule_path)
            mod = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(mod)
            rule4 = mod.url_based_code(url_str)

        

    if rule1 or rule2 or rule3 or rule4 :
        return True
    else :
        return False