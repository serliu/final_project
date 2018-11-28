
notes_arr =["Al", "4", "16", "Bl", "8", "0", "Cl", "10", "8", "Asl", "10", "8", 
"Bl", "12", "18", "Cl", "8", "16", "Ash", "12", "20", "Csl","12", "18", 
"Cl", "12", "12","Al","12", "12", "Bl","12", "12", "Cl", "10", "18" ]
#seqhw
f= open("notes.txt","w+")

f.write("DEPTH = 4096;\n" )
f.write("WIDTH = 32;\n")
f.write("ADDRESS_RADIX = HEX;\n")
f.write("DATA_RADIX = BIN;\n")
f.write("CONTENT\n")
f.write("BEGIN\n")

note_switcher = { # note: xposition
        
        "Cl": 0,
        "Csl": 1, 
        "Dl": 2,
        "Dsl": 3,
        "El": 4, 
        "Fl": 5, 
        "Fsl": 6, 
        "Gl": 7, 
        "Gsl": 8, 
        "Al": 9,
        "Asl": 10,
        "Bl": 11,
        
        "Ch": 12,
        "Csh": 13,
        "Dh": 14,
        "Dsh": 15,
        "Eh": 16,
        "Fh": 17,
        "Fsh": 18,
        "Gh": 19,
        "Gsh": 20,
        "Ah": 21, 
        "Ash": 22, 
        "Bh": 23
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

