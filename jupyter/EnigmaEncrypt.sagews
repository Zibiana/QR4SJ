︠d55efa63-de6b-45c8-bedd-bdeeec20a13ds︠
# For a fancier version, https://py-enigma.readthedocs.io/en/latest/overview.html

# -*- coding: utf-8 -*-  
from random import shuffle,randint,choice
from copy import copy
alphabet=range(0,26)

def shift(l, n): # Method to rotate arrays/cogs
	return l[n:] + l[:n]
	
class cog: # Simple substitution cipher for each cog
	def create(self):
		self.transformation=copy(alphabet)
		shuffle(self.transformation)
		return 
	def passthrough(self,i):
		return self.transformation[i]
	def passthroughrev(self,i):
		return self.transformation.index(i)
	def rotate(self):
		self.transformation=shift(self.transformation, 1)
	def setcog(self,a):
		self.transformation=a

class enigma: # Enigma class	
	def __init__(self, nocogs,printspecialchars):
		self.printspecialchars=printspecialchars
		self.nocogs=nocogs
		self.cogs=[]
		self.oCogs=[] # Create backup of original cog positions for reset
		
		for i in range(0,self.nocogs): # Create cogs
			self.cogs.append(cog())
			self.cogs[i].create()
			self.oCogs.append(self.cogs[i].transformation)
		
		# Create reflector
		refabet=copy(alphabet)
		self.reflector=copy(alphabet)
		while len(refabet)>0:
			a=choice(refabet)
			refabet.remove(a)
			b=choice(refabet)
			refabet.remove(b)
			self.reflector[a]=b
			self.reflector[b]=a

	def print_setup(self): # To print the enigma setup for debugging/replication
		print("Enigma Setup:\nCogs: ",self.nocogs,"\nCog arrangement:")
		for i in range(0,self.nocogs):
			print(self.cogs[i].transformation)
︡c2ad8b63-9d6d-48b9-95a8-499768992679︡{"done":true}
︠826e2f68-c9fa-4031-9ff4-0e244bb95d2bs︠
		print("Reflector arrangement:\n",self.reflector,"\n")
		
	def reset(self):
		for i in range(0,self.nocogs):
			self.cogs[i].setcog(self.oCogs[i])
			
	def encode(self,text):
		ln=0
		ciphertext=""
		for l in text.lower():
			num=ord(l)%97
			if (num>25 or num<0):
				if (self.printspecialchars): # readability
					ciphertext+=l 
				else:
					pass # security
			else:
				ln+=1
				for i in range(0,self.nocogs): # Move thru cogs forward...
					num=self.cogs[i].passthrough(num)
					
				num=self.reflector[num] # Pass thru reflector
				
				for i in range(0,self.nocogs): # Move back thru cogs...
					num=self.cogs[self.nocogs-i-1].passthroughrev(num)
				ciphertext+=""+chr(97+num) # add encrypted letter to ciphertext
				
				for i in range(0,self.nocogs): # Rotate cogs...
					if ( ln % ((i*6)+1) == 0 ): # in a ticker clock style
						self.cogs[i].rotate()
		return ciphertext

plaintext="""The most common arrangement used a ratchet and pawl mechanism. 
Each rotor had a ratchet with 26 teeth and, every time a key was pressed, each 
of the pawls corresponding to a particular rotor would move forward in unison, 
trying to engage with a ratchet, thus stepping the attached rotor once. A thin 
metal ring attached to each rotor upon which the pawl rode normally prevented 
this. As this ring rotated with its rotor, a notch machined into it would 
eventually align itself with the pawl, allowing it to drop into position, engage 
with the ratchet, and advance the rotor. The first rotor, having no previous 
rotor (and therefore no notched ring controlling a pawl), stepped with every 
key press. The five basic rotors (I–V) had one notch each, while the additional 
naval rotors VI, VII and VIII had two notches. The position of the notch on each 
rotor was determined by the letter ring which could be adjusted in relation to 
the core containing the interconnections. The points on the rings at which they 
caused the next wheel to move were as follows"""

x=enigma(4,True)
#x.print_setup()

print("Plaintext:\n"+plaintext+"\n")
ciphertext=x.encode(plaintext)
print("Ciphertext:\n"+ciphertext+"\n")

# To proove that encoding and decoding are symmetrical
# we reset the enigma to starting conditions and enter
# the ciphertext, and get out the plaintext
x.reset()
plaintext=x.encode(ciphertext)
print("Plaintext:\n"+plaintext+"\n")
︡367a3dbc-781a-49f3-a543-68562f888479︡{"stderr":"Error in lines 0-1\nTraceback (most recent call last):\n  File \"/cocalc/lib/python2.7/site-packages/smc_sagews/sage_server.py\", line 1234, in execute\n    flags=compile_flags), namespace, locals)\n  File \"\", line 1, in <module>\nNameError: name 'self' is not defined\n"}︡{"done":true}
︠de013dd7-31b7-433d-ac49-b6ed39be89ae︠









