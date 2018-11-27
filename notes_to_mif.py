
notes_arr =["Al", "Bl", "Cl","Al", "Bl", "Cl", "Al", "Bl", "Cl","Al", "Bl", "Cl" ]

f= open("notes.txt","w+")

f.write("DEPTH = 4096;\n" )
f.write("WIDTH = 32;\n")
f.write("ADDRESS_RADIX = HEX;\n")
f.write("DATA_RADIX = BIN;\n")
f.write("CONTENT\n")
f.write("BEGIN\n")

switcher = { # note: xposition
        "Al": 0, 
        "Bl": 1, 
        "Cl": 2, 
        "Dl": 3,
        "El": 4, 
        "Fl": 5, 
        "Gl": 6, 

        "Ah": 7, 
        "Bh": 8, 
        "Ch": 9, 
        "Dh": 10,
        "Eh": 11, 
        "Fh": 12, 
        "Gh": 13

    } 

note_position = []
size = '{:032b}'.format(len(notes_arr))

for i in range(0, len(notes_arr)):
	note_position.append(switcher.get(notes_arr.pop(),0))
        #print switcher.get(notes_arr.pop(), 0)


f.write(format(0, '02x'))
f.write(" : ")
f.write(size)
f.write(";\n")
address = 1

for j in range(0, len(note_position), 1):
	hex_addr = format(address, '02x')
	bin_note = '{:032b}'.format(note_position.pop())
	f.write(hex_addr)
	f.write(" : ")
	f.write(bin_note)
	f.write(";\n")
	address+=1


f.write("END;")

f.close()

