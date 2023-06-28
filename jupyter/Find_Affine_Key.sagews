︠c62c3b92-0a62-409e-bdc6-85f0e0bf48bfs︠
def AffineDecrypt(message, m, a):
    plaintext = ''
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    for c in message:
        num = alph.find(c)
        # Here, write the code to compute the ciphertext number that we send the plaintext number "num" to. Remember the equation for the affine cipher! Then, append the corresponding character to "decrypted".
        plaintext += alph[Mod(m.inverse_mod(26)*(num - a), 26)]
    print message,'->',plaintext
︡d46a874a-be8d-445d-91a0-c3be7d3de291︡{"done":true}︡
︠5b907737-34df-4846-83ab-b7ee49de8685s︠
#!/usr/bin/env python
# -*- coding: utf-8 -*-

def recursive_egcd(a, b):
    """
        Calculates gcd(a,b) and a linear combination such that
        gcd(a,b) = a*x + b*y

        As a side effect:
        If gcd(a,b) = 1 = a*x + b*y
        Then x is multiplicative inverse of a modulo b.
        
        Returns a triple (g, x, y), such that ax + by = g = gcd(a,b).
       Assumes a, b >= 0, and that at least one of them is > 0.
       Bounds on output values: |x|, |y| <= max(a, b)."""
    if a == 0:
        return (b, 0, 1)
    else:
        g, y, x = recursive_egcd(b % a, a)
        return (g, x - (b // a) * y, y)

︡3181fce2-696f-40f1-b659-e8cab2b38d87︡{"done":true}︡
︠2e1e75b2-6f7a-443a-b6d8-f66f293095c7s︠
egcd = recursive_egcd

def InverseMod26(a):
    if gcd(a,26) != 1:
        print "This number is not relatively prime to 26!"
    else:
        return egcd(a, 26)[1] % 26

︡20e60671-412d-4cb6-90c5-35c67003c8ed︡{"done":true}︡
︠9771018d-f54d-445c-a7f3-d36502190dc9s︠
# test
InverseMod26(11)
InverseMod26(13)
︡9af2d337-5cb5-4f2c-b3a3-69d4c0674591︡{"stdout":"19\n"}︡{"stdout":"This number is not relatively prime to 26!\n"}︡{"done":true}︡
︠589528fa-a7a3-46e9-a926-4987311cced6s︠

def guess_affine_key():
    c_e = raw_input("Guess ciphertext letter corresponding to e.")
    c_t = raw_input("Guess ciphertext letter corresponding to t.")
    """
    Solve a system of linear congruences of form:
    4 * m + a = c1 mod 26 (1)
    19 * m + a = c2 mod 26 (2)
    for m and a.
    
    pseudocode:
    1. find l = lcm(p1,p2) 
    2. if l = 0, then goto 4 in equation with xcoeff == 0
    2. else multiply equation 1 by l/xcoeff1 and equation 2 by -l/xcoeff2 (by definition, both are integers):
        l * x + l/xcoeff1 * ycoeff1 * y = l/xcoeff1 * b1 mod 26 
        -l * x - l/xcoeff2 * ycoeff2 * y = -l/xcoeff2 * b2 mod 26
    3. add equation 1 to equation 2 and replace equation 2 with this new equation:
        (l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) * y = l/xcoeff1 * b1 - l/xcoeff2 * b2 mod 26
    4. multiply resulting equation by InverseMod26(l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) to solve for y:
        y = InverseMod26(l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) * (l/xcoeff1 * b1 - l/xcoeff2 * b2) % 26
    5. plug y back into equation (1) to solve for x.    
        x = InverseMod26(xcoeff1) * (b1 - ycoeff1 * y) % 26
        
    Where could this algorithm go wrong?
    Under what circumstances would such a system of two congruences not have a solution?
    Well, if they look like:
        x + y = 1 mod 26
        x + y = 2 mod 26
    In this case, l = 1 and step 3 yields
        0 = 1 mod 26
    The problem is that the new y coefficient is 0.
    Account for that with an elif statement.
    """
    
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    C_e = alph.find(c_e)
    C_t = alph.find(c_t)
    a = InverseMod26(15)*(19 * C_e - 4 * C_t) % 26
    m = (C_t - a)*InverseMod26(19) % 26
    if gcd(m,26) != 1:
        return "Your guesses are inconsistent. Try again."
    else:
        return as_numeric(m), as_numeric(a)
︡dae04de8-405e-4adc-b043-8bb26d17a029︡{"done":true}︡
︠33b32084-8be5-428c-adf7-96a04b31dd80s︠

# test
guess_affine_key()
︡7e5c6e6a-93d0-4758-94ef-ea4ae2a0a461︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to e."}}︡{"delete_last":true}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to e.","submitted":true,"value":"T"}}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to t."}}︡{"delete_last":true}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to t.","submitted":true,"value":"L"}}︡{"stdout":"'Your guesses are inconsistent. Try again.'"}︡{"stdout":"\n"}︡{"done":true}︡
︠e469c58c-0a46-4da5-b8eb-f4637e1f3a7cs︠
def AffineDecrypt(message, m, a):
    plaintext = ''
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    for c in message:
        num = alph.find(c)
        # Here, write the code to compute the ciphertext number that we send the plaintext number "num" to. Remember the equation for the affine cipher! Then, append the corresponding character to "decrypted".
        plaintext += alph[Mod(m.inverse_mod(26)*(num - a), 26)]
    print message,'->',plaintext
︡b29b5246-944d-4347-ae9b-8f99e5686928︡{"done":true}︡
︠dced7177-545f-4442-80dc-612618bacc41s︠
def freq_analysis(message):
    alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M',
                'N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    # builds empty count_list ([0,0,0...0,0])
    count_list = []
    i = 0
    while i < 26:
        count_list.append(0)
        i += 1
    # converts message string to array
    array = []
    for i in message:
        array.append(i)
    n = len(array) + 0.0
    # counts occurences of each letter
    for x in array:
        i = 0
        while i < 26:
            if x == alphabet[i]:
                count_list[i] += 1
            i += 1
    # normalizes frequencies
    freq_list = []
    for x in count_list:
        freq_list.append(x/n)
    return sorted(zip(alphabet, freq_list), key = lambda x: x[1], reverse = True)

︡fb6bf9e3-9bb3-4687-96a5-74d113bf1f03︡{"done":true}︡
︠88ca357b-261b-4240-9c0f-a12dbe479eacs︠

def affine_crack(ciphertext):
    print freq_analysis(ciphertext)
    m = as_numeric(guess_affine_key()[0])
    a = as_numeric(guess_affine_key()[1])
    AffineDecrypt(ciphertext, m, a)
︡da4ec5e6-856c-4967-81dc-d21ed1464c72︡{"done":true}︡
︠838d6faa-c272-48af-bb55-2af0110cd3c1s︠
# test
freq_analysis("XLEJTDNRGTRPTNLXT")

︡a693e350-ed17-4103-b632-b4bcc72d7b27︡{"stdout":"[('T', 0.235294117647059), ('L', 0.117647058823529), ('N', 0.117647058823529), ('R', 0.117647058823529), ('X', 0.117647058823529), ('D', 0.0588235294117647), ('E', 0.0588235294117647), ('G', 0.0588235294117647), ('J', 0.0588235294117647), ('P', 0.0588235294117647), ('A', 0.000000000000000), ('B', 0.000000000000000), ('C', 0.000000000000000), ('F', 0.000000000000000), ('H', 0.000000000000000), ('I', 0.000000000000000), ('K', 0.000000000000000), ('M', 0.000000000000000), ('O', 0.000000000000000), ('Q', 0.000000000000000), ('S', 0.000000000000000), ('U', 0.000000000000000), ('V', 0.000000000000000), ('W', 0.000000000000000), ('Y', 0.000000000000000), ('Z', 0.000000000000000)]\n"}︡{"done":true}︡
︠2750457f-da08-4fd1-9cef-097589731379s︠

affine_crack("XLEJTDNRGTRPTNLXT")
︡f0c3c018-24f4-4a62-ae99-5b0ca7a023c1︡{"stdout":"[('T', 0.235294117647059), ('L', 0.117647058823529), ('N', 0.117647058823529), ('R', 0.117647058823529), ('X', 0.117647058823529), ('D', 0.0588235294117647), ('E', 0.0588235294117647), ('G', 0.0588235294117647), ('J', 0.0588235294117647), ('P', 0.0588235294117647), ('A', 0.000000000000000), ('B', 0.000000000000000), ('C', 0.000000000000000), ('F', 0.000000000000000), ('H', 0.000000000000000), ('I', 0.000000000000000), ('K', 0.000000000000000), ('M', 0.000000000000000), ('O', 0.000000000000000), ('Q', 0.000000000000000), ('S', 0.000000000000000), ('U', 0.000000000000000), ('V', 0.000000000000000), ('W', 0.000000000000000), ('Y', 0.000000000000000), ('Z', 0.000000000000000)]\n"}︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/projects/sage/sage-7.6/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 995, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"\", line 3, in affine_crack\nNameError: global name 'as_numeric' is not defined\n"}︡{"done":true}︡
︠24b61bc3-4210-4096-ae3e-a4e1d58c4f47︠









︡40000a5a-89f9-4ae6-a3b5-fc724f02dded︡
︠ffc22a08-fb91-4c2d-89f9-1868b1e6c5e1s︠
def AffineDecrypt(message, m, a):
    plaintext = ''
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    for c in message:
        num = alph.find(c)
        # Here, write the code to compute the ciphertext number that we send the plaintext number "num" to. Remember the equation for the affine cipher! Then, append the corresponding character to "decrypted".
        plaintext += alph[Mod(m.inverse_mod(26)*(num - a), 26)]
    print message,'->',plaintext
︡ed780795-cf85-4fd5-95b6-f4a3cf5a1c1b︡{"done":true}︡
︠13da3a03-6bec-48dc-bdb7-20e1aea72bb4s︠
#!/usr/bin/env python
# -*- coding: utf-8 -*-

def recursive_egcd(a, b):
    """
        Calculates gcd(a,b) and a linear combination such that
        gcd(a,b) = a*x + b*y

        As a side effect:
        If gcd(a,b) = 1 = a*x + b*y
        Then x is multiplicative inverse of a modulo b.
        
        Returns a triple (g, x, y), such that ax + by = g = gcd(a,b).
       Assumes a, b >= 0, and that at least one of them is > 0.
       Bounds on output values: |x|, |y| <= max(a, b)."""
    if a == 0:
        return (b, 0, 1)
    else:
        g, y, x = recursive_egcd(b % a, a)
        return (g, x - (b // a) * y, y)

︡d645ca91-d6ff-4bfc-a50a-88de93ece3bd︡{"done":true}︡
︠b6000f77-0cca-4e72-93cb-a645decfb7cfs︠
egcd = recursive_egcd

def InverseMod26(a):
    if gcd(a,26) != 1:
        print "This number is not relatively prime to 26!"
    else:
        return egcd(a, 26)[1] % 26

︡78ad6fda-4703-42bb-8b36-d09df4c6c0ab︡{"done":true}︡
︠b7bbb855-4586-49bf-9db7-1b3792574200s︠
# test
InverseMod26(11)
InverseMod26(13)
︡2f2d5933-f442-4b05-9677-9377b89c8fcc︡{"stdout":"19\n"}︡{"stdout":"This number is not relatively prime to 26!\n"}︡{"done":true}︡
︠12f80007-5373-4b05-9144-f5d580db6b26s︠

def guess_affine_key():
    c_e = raw_input("Guess ciphertext letter corresponding to e.")
    c_t = raw_input("Guess ciphertext letter corresponding to t.")
    """
    Solve a system of linear congruences of form:
    4 * m + a = c1 mod 26 (1)
    19 * m + a = c2 mod 26 (2)
    for m and a.
    
    pseudocode:
    1. find l = lcm(p1,p2) 
    2. if l = 0, then goto 4 in equation with xcoeff == 0
    2. else multiply equation 1 by l/xcoeff1 and equation 2 by -l/xcoeff2 (by definition, both are integers):
        l * x + l/xcoeff1 * ycoeff1 * y = l/xcoeff1 * b1 mod 26 
        -l * x - l/xcoeff2 * ycoeff2 * y = -l/xcoeff2 * b2 mod 26
    3. add equation 1 to equation 2 and replace equation 2 with this new equation:
        (l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) * y = l/xcoeff1 * b1 - l/xcoeff2 * b2 mod 26
    4. multiply resulting equation by InverseMod26(l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) to solve for y:
        y = InverseMod26(l * ycoeff1/xcoeff1 - l * ycoeff2/xcoeff2) * (l/xcoeff1 * b1 - l/xcoeff2 * b2) % 26
    5. plug y back into equation (1) to solve for x.    
        x = InverseMod26(xcoeff1) * (b1 - ycoeff1 * y) % 26
        
    Where could this algorithm go wrong?
    Under what circumstances would such a system of two congruences not have a solution?
    Well, if they look like:
        x + y = 1 mod 26
        x + y = 2 mod 26
    In this case, l = 1 and step 3 yields
        0 = 1 mod 26
    The problem is that the new y coefficient is 0.
    Account for that with an elif statement.
    """
    
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    C_e = alph.find(c_e)
    C_t = alph.find(c_t)
    a = InverseMod26(15)*(19 * C_e - 4 * C_t) % 26
    m = (C_t - a)*InverseMod26(19) % 26
    if gcd(m,26) != 1:
        return "Your guesses are inconsistent. Try again."
    else:
        return as_numeric(m), as_numeric(a)
︡50480be8-cadb-4cd4-a24a-3de3dd8192de︡{"done":true}︡
︠a857b5ef-303a-44a2-b87f-1dd5f317df48s︠

# test
guess_affine_key()
︡33be29ba-d5dc-43e9-bf95-d39b25139e9e︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to e."}}︡{"delete_last":true}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to e.","submitted":true,"value":"T"}}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to t."}}︡{"delete_last":true}︡{"raw_input":{"prompt":"Guess ciphertext letter corresponding to t.","submitted":true,"value":"L"}}︡{"stdout":"'Your guesses are inconsistent. Try again.'"}︡{"stdout":"\n"}︡{"done":true}︡
︠554c045d-36a2-4bb0-8034-cc89312d8d98s︠
def AffineDecrypt(message, m, a):
    plaintext = ''
    alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    
    for c in message:
        num = alph.find(c)
        # Here, write the code to compute the ciphertext number that we send the plaintext number "num" to. Remember the equation for the affine cipher! Then, append the corresponding character to "decrypted".
        plaintext += alph[Mod(m.inverse_mod(26)*(num - a), 26)]
    print message,'->',plaintext
︡45969860-23fb-45f5-bcc9-2db724328d4e︡{"done":true}︡
︠61493c34-575a-4ab3-a322-9f22e51fd9c8s︠
def freq_analysis(message):
    alphabet = ['A','B','C','D','E','F','G','H','I','J','K','L','M',
                'N','O','P','Q','R','S','T','U','V','W','X','Y','Z']
    # builds empty count_list ([0,0,0...0,0])
    count_list = []
    i = 0
    while i < 26:
        count_list.append(0)
        i += 1
    # converts message string to array
    array = []
    for i in message:
        array.append(i)
    n = len(array) + 0.0
    # counts occurences of each letter
    for x in array:
        i = 0
        while i < 26:
            if x == alphabet[i]:
                count_list[i] += 1
            i += 1
    # normalizes frequencies
    freq_list = []
    for x in count_list:
        freq_list.append(x/n)
    return sorted(zip(alphabet, freq_list), key = lambda x: x[1], reverse = True)

︡33e89cfc-57e3-4e99-9a4f-2986751e3dfb︡{"done":true}︡
︠305c5488-64c8-4b5a-8833-818050a9292bs︠

def affine_crack(ciphertext):
    print freq_analysis(ciphertext)
    m = as_numeric(guess_affine_key()[0])
    a = as_numeric(guess_affine_key()[1])
    AffineDecrypt(ciphertext, m, a)
︡c0e5c868-a8fb-4088-ba81-102a383836e2︡{"done":true}︡
︠010f6448-cb25-4d55-83ae-bf6b77aa5c23s︠
# test
freq_analysis("XLEJTDNRGTRPTNLXT")

︡d85bb75d-a5c3-4319-ae3f-b5e06ea772d4︡{"stdout":"[('T', 0.235294117647059), ('L', 0.117647058823529), ('N', 0.117647058823529), ('R', 0.117647058823529), ('X', 0.117647058823529), ('D', 0.0588235294117647), ('E', 0.0588235294117647), ('G', 0.0588235294117647), ('J', 0.0588235294117647), ('P', 0.0588235294117647), ('A', 0.000000000000000), ('B', 0.000000000000000), ('C', 0.000000000000000), ('F', 0.000000000000000), ('H', 0.000000000000000), ('I', 0.000000000000000), ('K', 0.000000000000000), ('M', 0.000000000000000), ('O', 0.000000000000000), ('Q', 0.000000000000000), ('S', 0.000000000000000), ('U', 0.000000000000000), ('V', 0.000000000000000), ('W', 0.000000000000000), ('Y', 0.000000000000000), ('Z', 0.000000000000000)]\n"}︡{"done":true}︡
︠85ce9a13-c463-4556-94bc-3a71ea580808s︠

affine_crack("XLEJTDNRGTRPTNLXT")
︡25f8bcdb-ba89-4bce-9751-3d5b09f37889︡{"stdout":"[('T', 0.235294117647059), ('L', 0.117647058823529), ('N', 0.117647058823529), ('R', 0.117647058823529), ('X', 0.117647058823529), ('D', 0.0588235294117647), ('E', 0.0588235294117647), ('G', 0.0588235294117647), ('J', 0.0588235294117647), ('P', 0.0588235294117647), ('A', 0.000000000000000), ('B', 0.000000000000000), ('C', 0.000000000000000), ('F', 0.000000000000000), ('H', 0.000000000000000), ('I', 0.000000000000000), ('K', 0.000000000000000), ('M', 0.000000000000000), ('O', 0.000000000000000), ('Q', 0.000000000000000), ('S', 0.000000000000000), ('U', 0.000000000000000), ('V', 0.000000000000000), ('W', 0.000000000000000), ('Y', 0.000000000000000), ('Z', 0.000000000000000)]\n"}︡{"stderr":"Error in lines 1-1\nTraceback (most recent call last):\n  File \"/projects/sage/sage-7.6/local/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 995, in execute\n    exec compile(block+'\\n', '', 'single') in namespace, locals\n  File \"\", line 1, in <module>\n  File \"\", line 3, in affine_crack\nNameError: global name 'as_numeric' is not defined\n"}︡{"done":true}︡









