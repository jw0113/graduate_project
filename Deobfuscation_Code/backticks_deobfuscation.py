# powershell - back ticks 해제 코드

def b_deobfuscation(deobfuscation) :

    deob_str = "d`gkjkgijk`gjkl`gjklgk`k"
    for index in range(len(deob_str)) : 
        deob_str = deob_str.replace("`","")

    print("backtics_deobfuscation reuslt =", deob_str)

