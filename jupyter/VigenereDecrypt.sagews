# Define a Vigenere decryption function
def VigenereDecrypt(ciphertext, key):
    key_length = len(key)
# Convert the key and ciphertext from letters to numbers
    key_as_int = [ord(i) for i in key]
    ciphertext_int = [ord(i) for i in ciphertext]
# Start with an empty string of plaintext 
    plaintext = ''
# Add letters to plaintext one at a time by writing the key repeatedly under the ciphertext, then subtracting the key number from the ciphertext and reducing modulo 26. Return the result.
    for i in range(len(ciphertext_int)):
        value = (ciphertext_int[i] - key_as_int[i % key_length]) % 26
        plaintext += chr(value + 65)
    return plaintext









