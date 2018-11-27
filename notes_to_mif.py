#!/usr/bin/env python
# Years till 100
import sys

notes_arr = sys.argv[1].split(',')

f= open("notes.txt","w+")

f.write("DEPTH = 4096;\n" )
f.write("WIDTH = 32;")
f.write("ADDRESS_RADIX = HEX; ")
f.write("DATA_RADIX = BIN;")
f.write("CONTENT")
f.write("BEGIN")




switcher = { # note: xposition
        Al: 0, 
        Bl: 1, 
        Cl: 2, 
        Dl: 3,
        El: 4, 
        Fl: 5, 
        Gl: 6, 

        Ah: 7, 
        Bh: 8, 
        Ch: 9, 
        Dh: 10,
        Eh: 11, 
        Fh: 12, 
        Gh: 13

    } 

note_position = []

for i in range(0, len(notes_arr), 2):
	note_position[i] = switcher(notes_arr[i], "")

address = 0

for j in range(0, len(note_position))
	hex_addr = hex(address)
	bin_note = bin(note_position[j])
	f.write(hex_addr, " : ", bin_note , ";" )


f.write("END;")

