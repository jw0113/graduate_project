# powershell - split 탐지 코드

def split_deob(deobfuscation) :

    sp_str = deobfuscation
    sp_deob = sp_str.replace("+","")
    sp_deob = sp_deob.replace('"',"")
    sp_deob = sp_deob.replace("'","")
    print("split_deobfuscation result : ",sp_deob)

    return sp_deob
