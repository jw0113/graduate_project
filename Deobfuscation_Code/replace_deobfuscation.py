# powershell - replace() 해제 코드



def b_deobfuscation(deobfuscation) :

    # deobfuscation은 ""이로 인해 오류 발생 가능하므로 여기로 넘어오기 전 ""을 ''으로 바꿔야함

    #re_str = "'z(dldm)OP://192/168/1/144/z(dldm)OP'.replace('z(dldm)OP','http')"
    re_str = deobfuscation
    re_deob = eval(re_str)
    
    print("replace deobfuscation : " + re_deob)
