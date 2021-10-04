# -*- coding: utf-8 -*-
"""
Robot Class, WPManager class, Simulation class

(c) S. Bertrand
"""

import math
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation

class Robot:
    
    def __init__(self, x0, y0, theta0, id=0):
        self.id = id        
        # state
        self.x = x0  # x position coordinate in meters
        self.y = y0  # y position coordinate in meters
        self.theta = theta0  # orientation angle in rad

        #input
        self.V = 0.0  # module of linear speed in m/s (>=0)
        self.omega = 0.0  # angular speed in rad/s
    
    
    # integrate robot motion over one sampling period (Euler discretization)
    def integrateMotion(self, Te):        
        self.x = self.x + Te * self.V * math.cos(self.theta)    
        self.y = self.y + Te * self.V * math.sin(self.theta)
        self.theta = self.theta + Te * self.omega

    # set V control input (in m/s)
    def setV(self, V):
        self.V = V        
        
    # set omega control imput (in rad/s)
    def setOmega(self, omega):
        self.omega = omega
    
        
    def __repr__(self):
        """Display in command line"""
        message = "Robot: id:{}\n".format(self.id)
        message += " x: {}(m), y: {}(m), theta: {}(deg)".format(self.x, self.y, self.theta*180.0/math.pi)        
        return message
    

    def __str__(self):
        """Display with print function"""
        message = "Robot: id:{}\n".format(self.id)
        message += " x: {}(m), y: {}(m), theta: {}(deg)".format(self.x, self.y, self.theta*180.0/math.pi)        
        return message

# *** end of class Robot ****************************************************



class WPManager:
# Assumption: WPList is a list of [ [x coord, y coord]  ]    
    
    def __init__(self, WPList, epsilonWP):
        self.WPList = list(WPList)
        self.epsilonWP = epsilonWP  # threshold for switching test to next WP
        self.currentWP = self.WPList.pop(0) # current WP
        self.xr = self.currentWP[0] # x coordinate of current WP
        self.yr = self.currentWP[1] # y coordinate of current WP
        
        
    def switchToNextWP(self):
        if not(self.isWPListEmpty()):
            self.currentWP = self.WPList.pop(0)        
            self.xr = self.currentWP[0]
            self.yr = self.currentWP[1]


    def isWPListEmpty(self):
        if (len(self.WPList)==0):
            return True
        else:
            return False

        
    def distanceToCurrentWP(self, x, y):
        return np.sqrt( math.pow(x-self.xr,2) + math.pow(y-self.yr,2))


# *** end of class WPManager **************************************************


class RobotSimulation:
    
    def __init__(self, robot, t0=0.0, tf=10.0, dt=0.01):
        self.t0 = t0 # init time of simulation (in sec)
        self.tf = tf # final time of simulation (in sec)
        self.dt = dt # sampling period for numerical integration (in sec)
        self.t = np.arange(t0, tf, dt) # vector of time stamps

        # to save robot state and input during simulation
        self.x = np.zeros_like(self.t)
        self.y = np.zeros_like(self.t)
        self.theta = np.zeros_like(self.t)
        self.V = np.zeros_like(self.t)
        self.omega = np.zeros_like(self.t)
        
        # to save reference position of current WP during simulation
        self.xr = np.zeros_like(self.t)
        self.yr = np.zeros_like(self.t)
        
        # to save intermediate and computed values in control computation
        self.Vr = np.zeros_like(self.t)
        self.thetar = np.zeros_like(self.t)
        self.omegar = np.zeros_like(self.t)
        
        # index of current stored data (from 0 to len(self.t)-1 )
        self.currentIndex = 0



    def addDataFromRobot(self, robot):
        self.x[self.currentIndex] = robot.x
        self.y[self.currentIndex] = robot.y
        self.theta[self.currentIndex] = robot.theta
        self.V[self.currentIndex] = robot.V
        self.omega[self.currentIndex] = robot.omega
        self.currentIndex = self.currentIndex + 1


    def addData(self, robot, WPManager, Vr, thetar, omegar):
        self.x[self.currentIndex] = robot.x
        self.y[self.currentIndex] = robot.y
        self.theta[self.currentIndex] = robot.theta
        self.V[self.currentIndex] = robot.V
        self.omega[self.currentIndex] = robot.omega

        self.xr[self.currentIndex] = WPManager.xr
        self.yr[self.currentIndex] = WPManager.yr
        
        self.Vr[self.currentIndex] = Vr
        self.thetar[self.currentIndex] = thetar
        self.omegar[self.currentIndex] = omegar

        self.currentIndex = self.currentIndex + 1

        

    def plotXY(self, figNo = 1, xmin=-5, xmax=5, ymin=-5, ymax=5):
        fig1 = plt.figure(figNo)
        graph = fig1.add_subplot(111, aspect='equal', autoscale_on=False, xlim=(xmin, xmax), ylim=(ymin, ymax))
        graph.plot(self.x, self.y, color = 'r')
        graph.grid(True)
        graph.set_ylabel('y (m)')
        graph.set_xlabel('x (m)')


    def plotXYTheta(self, figNo = 1):
        fig2, graphTab2 = plt.subplots(3)
        graphTab2[0].plot(self.t, self.x, color = 'r')
        graphTab2[0].plot(self.t, self.xr, color = 'b')
        graphTab2[0].grid(True)
        graphTab2[0].set_ylabel('x (m)')
        graphTab2[1].plot(self.t, self.y, color = 'r')
        graphTab2[1].plot(self.t, self.yr, color = 'b')        
        graphTab2[1].grid(True)
        graphTab2[1].set_ylabel('y (m)')
        graphTab2[2].plot(self.t, self.theta*180/math.pi, color = 'r')
        graphTab2[2].plot(self.t, self.thetar*180/math.pi, color = 'b')
        graphTab2[2].grid(True)
        graphTab2[2].set_ylabel('theta (deg)')
        graphTab2[2].set_xlabel('t (s)')


    def plotVOmega(self, figNo=1):
        fig22, graphTab22 = plt.subplots(2)
        graphTab22[0].plot(self.t, self.V, color = 'r')
        graphTab22[0].grid(True)
        graphTab22[0].set_ylabel('V (m/s)')
        graphTab22[1].plot(self.t, self.omega*180/math.pi, color = 'r')
        graphTab22[1].grid(True)
        graphTab22[1].set_ylabel('omega (deg/s)')
        graphTab22[1].set_xlabel('t (s)')

   
        
if __name__=='__main__':
    robot = Robot(0.0, 0.0, 0.0)
    print(robot)        
    robot.integrateMotion(0.05)
    print(robot)
    