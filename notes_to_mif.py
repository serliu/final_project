

#notes_arr =["Al", "4", "16", "Bl", "8", "0", "Cl", "10", "8", "Asl", "10", "8", "Bl", "12", "18", "Cl", "8", "16", "Ash", "12", "20", "Csl","12", "18", "Cl", "12", "12","Al","12", "12", "Bl","12", "12", "Cl", "10", "18" ]
#seqhw
#ode to joy 
notes_arr = ["El", "4", "4","El", "4", "4", "Fl", "4", "4", "Gl", "4", "4",
"Gl", "4", "4", "Fl", "4", "4","El", "4", "4","Dl", "4", "4","Cl", "4", "4",
"Cl", "4", "4", "Dl", "4", "4", "El", "4", "4", "El", "6", "6", "Dl", "2", "2",
"Dl", "8", "8",
"El", "4", "4","El", "4", "4", "Fl", "4", "4", "Gl", "4", "4",
"Gl", "4", "4", "Fl", "4", "4","El", "4", "4","Dl", "4", "4","Cl", "4", "4",
"Cl", "4", "4", "Dl", "4", "4", "El", "4", "4","Dl", "6", "6", "Cl", "2", "2",
"Cl", "8", "8", 
"Dl", "4", "4","Dl", "4", "4", "El", "4", "4", "Cl", "4", "4",
"Dl", "4", "4", "El", "2", "2", "Fl", "2", "2", "El", "4", "4", "Cl", "4", "4",
"Dl", "4", "4", "El", "2", "2", "Fl", "2", "2", "El", "4", "4", "Dl", "4", "4",
"Cl", "4", "4", "Dl", "4", "4", "Gl", "8", "8",
"El", "4", "4","El", "4", "4", "Fl", "4", "4", "Gl", "4", "4",
"Gl", "4", "4", "Fl", "4", "4","El", "4", "4","Dl", "4", "4","Cl", "4", "4",
"Cl", "4", "4", "Dl", "4", "4", "El", "4", "4", "El", "6", "6", "Dl", "2", "2",
"Dl", "8", "8"]
f= open("notes.mif","w+")

f.write("DEPTH = 4096;\n" )
f.write("WIDTH = 32;\n")
f.write("ADDRESS_RADIX = HEX;\n")
f.write("DATA_RADIX = BIN;\n")
f.write("CONTENT\n")
f.write("BEGIN\n")

note_switcher = { # note: xposition
        
        "Cl": 1,
        "Csl": 2, 
        "Dl": 3,
        "Dsl": 4,
        "El": 5, 
        "Fl": 6, 
        "Fsl": 7, 
        "Gl": 8, 
        "Gsl": 9, 
        "Al": 10,
        "Asl": 11,
        "Bl": 12,
        
        "Ch": 13,
        "Csh": 14,
        "Dh": 15,
        "Dsh": 16,
        "Eh": 17,
        "Fh": 18,
        "Fsh": 19,
        "Gh": 20,
        "Gsh": 21,
        "Ah": 22, 
        "Ash": 23, 
        "Bh": 24
}

duration_switcher = {
        "0": 0,
        "1": 1,
        "2": 2,
        "3": 3,
        "4": 4,
        "5": 5,
        "6": 6,
        "7": 7,
        "8": 8,
        "9": 9,
        "10": 10,
        "11": 11,
        "12": 12,
        "13": 13,
        "14": 14,
        "15": 15,
        "16": 16,
        "17": 17,
        "18": 18, 
        "19": 19,
        "20": 20

}

    
 

note_position = []
size = '{:032b}'.format(len(notes_arr)/3)

for i in range(0, len(notes_arr)/3):
	
        note_position.append(duration_switcher.get(notes_arr.pop(),0))
        note_position.append(duration_switcher.get(notes_arr.pop(),0))
        note_position.append(note_switcher.get(notes_arr.pop(),0))


f.write(format(0, '02x'))
f.write(" : ")
f.write(size)
f.write(";\n")
address = 1
zeroes = '{:017b}'.format(0)
for j in range(0, len(note_position)/3, 1):
	hex_addr = format(address, '02x')
	bin_note = '{:05b}'.format(note_position.pop())
	bin_dur_note = '{:05b}'.format(note_position.pop())
	bin_dur_next = '{:05b}'.format(note_position.pop())
	f.write(hex_addr)
	f.write(" : ")
	f.write(bin_note)
	f.write(bin_dur_note)
	f.write(bin_dur_next)
	f.write(zeroes)
	f.write(";\n")
	address+=1


f.write("END;")

f.close()

