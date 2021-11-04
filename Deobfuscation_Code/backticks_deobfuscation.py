# powershell - back ticks 해제 코드

def b_deobfuscation(deobfuscation) :


    for index in range(len(deobfuscation)) : 
        deobfuscation = deobfuscation.replace("`","")

    #print("backtics_deobfuscation reuslt =", deob_str)
    return deobfuscation

