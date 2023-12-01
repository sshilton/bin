#! /usr/bin/env python
#print ("Hi Che")
import sys
CheState = sys.argv[1]
#print (CheState)
match CheState:
    case "Activated":
        print ("Chibi Che is Activate - poke boto now!!")
        exit (0)
    case "NotActivated":
        print ("Che is not activated :(")
        exit (1)
    case _:
        print ("I do not know what state Che is in, it is reported she is " + CheState)
