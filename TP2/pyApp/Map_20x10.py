# -*- coding: utf-8 -*-
"""
Created on Mon Oct 05 18:05:06 2015
@author: S. Bertrand
"""

import numpy as np
import matplotlib.pyplot as plt
import AStar


dimX = 20
dimY = 10

occupancyGrid = np.zeros([dimX, dimY])
occupancyGrid[2:4, 2:4] = 1
occupancyGrid[6, 1:3] = 1
occupancyGrid[4:7, 3] = 1
occupancyGrid[8:10, 2:6] = 1
occupancyGrid[4:6, 6:8] = 1
occupancyGrid[6, 5:7] = 1
occupancyGrid[10:12, 7:10] = 1
occupancyGrid[11, 0:3] = 1
occupancyGrid[11:15, 4:6] = 1
occupancyGrid[13:15, 2:5] = 1
occupancyGrid[15, 3:5] = 1
occupancyGrid[16:18, 3] = 1
occupancyGrid[18:20, 5] = 1
occupancyGrid[14, 7:9] = 1
occupancyGrid[16, 7:10] = 1


adjacency = 8

carte = AStar.Map(dimX, dimY, adjacency)
carte.initCoordinates()
carte.loadOccupancy(occupancyGrid)
carte.generateGraph()
carte.plot(1)


epsilon = 3


print("A* algorithm running ...")
closedList, successFlag = carte.AStarFindPath(0, 199, epsilon)
# print closedList
if (successFlag == True):
    print("  - A* terminated with success: path found")

    path = carte.builtPath(closedList)
    carte.plotExploredTree(closedList, 3)
    carte.plotPathOnMap(path, 2)

plt.show()
