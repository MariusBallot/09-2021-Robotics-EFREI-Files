# -*- coding: utf-8 -*-
"""
Timer class

(c) S. Bertrand
"""

import numpy as np

class Timer:
    
    def __init__(self, delay, t0=0.0):
        self.delay = delay        
        self.lastTime = t0
        
    def reset(self, t0):
        self.lastTime = t0
        
    def setDelay(self, delay):
        self.delay = delay
        
    def isEllapsed(self, t):
        # numerical precision to be fixed in this test
        if (t-(self.lastTime + self.delay)>=-0.00000001):
            self.lastTime = t
            return True
        else:
            return False

        
    def __repr__(self):
        """Display in command line"""
        message = "Time: \n"
        message += " delay: {}(s)".format(self.delay)        
        return message
    

    def __str__(self):
        """Display with print function"""
        message = "Time: \n"
        message += " delay: {}(s)".format(self.delay)   
        return message



if __name__=='__main__':
    t0 = 0.0    
    dt = 0.1
    tspan = np.arange(0.0, 5.0, dt)
    timer1 = Timer(0.5)
    timer2 = Timer(0.3, t0)

    for t in tspan:
        print(t)
        if timer1.isEllapsed(t):
            print(" -timer1")
        if timer2.isEllapsed(t):
            print(" -       timer2")