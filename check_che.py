#! /usr/bin/env python
#print ("Hi Che")
import sys
CheState = sys.argv[1]
#print (CheState)
match CheState:
    case "Activated":
        print ("OK: Chibi Che is Activated - poke boto now!!")
        exit (0)
    case "NotActivated":
        print ("WARNING: Che is not activated :(")
        exit (1)
    case _:
        print ("UNKNOWN: I do not know what state Che is in, it is reported she is " + CheState)
        exit (3)

