cat     START   0

loop    RD      #0
        COMP    #27     . ESC
        JEQ     halt
        WD      #1
        J       loop

halt    J       halt

        END     cat