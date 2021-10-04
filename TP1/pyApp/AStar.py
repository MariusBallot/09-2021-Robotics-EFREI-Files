# -*- coding: utf-8 -*-
"""
Created on Tue Jul 07 15:56:00 2015
@author: S. Bertrand

ASSUMPTION on coordinate system for the map :

        y
        ^(0, dimY-1)  (dimX-1, dimY-1)
        |
        |(0,0)           (dimX-1,0)
        ------------------------>  x

ASSUMPTION on node  numerotation :

        y
        ^....    ....      ...dimX*dimY-1
        |dimX  dimX+1 .... ....
        |0   1   2   ...   dimX-1
        ------------------------>  x

"""

import random
import matplotlib.pyplot as plt
import matplotlib.patches as patches
import numpy as np
import math


class Node:

    def __init__(self, no, x, y, g=np.inf, f=0.0):
        self.no = no
        self.x = x
        self.y = y
        self.g = g
        self.f = f
        self.parentNo = None

    def __repr__(self):
        """Display in command line"""
        message = "Node: no:{}".format(self.no)
        message += " x={}, y={}, g={}, f={}, parentNo: {}".format(
            self.x, self.y, self.g, self.f, self.parentNo)
        return message

    def __str__(self):
        """Display with print function"""
        message = "Node: no:{}".format(self.no)
        message += " x={}, y={}, g={}, f={}, parentNo: {}".format(
            self.x, self.y, self.g, self.f, self.parentNo)
        return message

# --- end of node class -------------------------


class Graph:

    def __init__(self, nbOfNodes, adjacency=4):
        self.nbOfNodes = nbOfNodes
        self.listOfNodes = []
        self.adjacencyMatrix = np.zeros([nbOfNodes, nbOfNodes])
        self.adjacency = adjacency  # 4 or 8-adjacencies

    # return list of numeros of successor nodes of node no nodeNo
    def succNoOfNode(self, nodeNo):
        succ = []
        for i in range(0, self.nbOfNodes):
            if ((self.adjacencyMatrix[nodeNo, i] == 1) & (i != nodeNo)):
                succ.append(i)
        return succ


# --- end of graph class -------------------------


class Map:

    def __init__(self, dimX, dimY, adjacency=4):
        self.dimX = dimX
        self.dimY = dimY
        # occupancy grid. 0 : free cell, 1 : obstacle
        self.occupancy = np.zeros([dimX, dimY])
        self.coordinateX = np.zeros([dimX, dimY])  # coordinate x of the point
        self.coordinateY = np.zeros([dimX, dimY])  # coordinate y of the point
        self.graph = Graph(dimX*dimY, adjacency)

    # init coordinates (see assumption at the begining of this file)
    def initCoordinates(self):
        for y in range(0, self.dimY):
            for x in range(0, self.dimX):
                self.coordinateX[x, y] = x
                self.coordinateY[x, y] = y

    # assign occupancy matrix
    def loadOccupancy(self, occupancyMatrix):
        for y in range(0, self.dimY):
            for x in range(0, self.dimX):
                self.occupancy[x, y] = occupancyMatrix[x, y]

    # generate random obstacles
    def generateRandObstacles(self):
        for y in range(0, self.dimY):
            for x in range(0, self.dimX):
                if random.random() > 0.8:
                    self.occupancy[x, y] = 1.0
                else:
                    self.occupancy[x, y] = 0.0

    # generate graph and adjacency matrix
    def generateGraph(self):
        self.graph.nbOfNodes = self.dimX * self.dimY
        no = 0
        for y in range(0, self.dimY):
            for x in range(0, self.dimX):
                newNode = Node(no, x, y)
                self.graph.listOfNodes.append(newNode)
                no = no + 1
        self.generateAdjacencyMatrix()

    # generate adjacency matrix

    def generateAdjacencyMatrix(self):
        nc = 0  # numero of current node
        for y in range(0, self.dimY):
            for x in range(0, self.dimX):

                # connetivity only for node with no obstacles
                if (self.occupancy[x, y] == 0):

                    nc = x + y*self.dimX  # numero of current node

                    if (x+1 < self.dimX):  # right neighbour
                        if (self.occupancy[x+1, y] == 0):
                            self.graph.adjacencyMatrix[nc, nc+1] = 1

                    if (x-1 >= 0):  # left neighbour
                        if (self.occupancy[x-1, y] == 0):
                            self.graph.adjacencyMatrix[nc, nc-1] = 1

                    if (y+1 < self.dimY):  # up neighbour
                        if (self.occupancy[x, y+1] == 0):
                            self.graph.adjacencyMatrix[nc, nc+self.dimX] = 1

                    if (y-1 >= 0):  # down neighbour
                        if (self.occupancy[x, y-1] == 0):
                            self.graph.adjacencyMatrix[nc, nc-self.dimX] = 1

                    if (self.graph.adjacency == 8):
                        if (y-1 >= 0 and x-1 >= 0):  # down-left neighbour
                            if (self.occupancy[x-1, y-1] == 0):
                                self.graph.adjacencyMatrix[nc,
                                                           nc-self.dimX-1] = 1

                        if (y-1 >= 0 and x+1 < self.dimX):  # down-right neighbour
                            if (self.occupancy[x+1, y-1] == 0):
                                self.graph.adjacencyMatrix[nc,
                                                           nc+1-self.dimX] = 1

                        if (y+1 < self.dimY and x-1 >= 0):  # up-left neighbour
                            if (self.occupancy[x-1, y+1] == 0):
                                self.graph.adjacencyMatrix[nc,
                                                           nc+self.dimX-1] = 1

                        if (y+1 < self.dimY and x+1 < self.dimX):  # up-right neighbour
                            if (self.occupancy[x+1, y+1] == 0):
                                self.graph.adjacencyMatrix[nc,
                                                           nc+1+self.dimX] = 1
    # plot map

    def plot(self, noFig=1):
        fig1 = plt.figure(noFig)
        axPlt = fig1.add_subplot(111, aspect='equal', autoscale_on=False,
                                 xlim=(-1.5, self.dimX+0.5), ylim=(-1.5, self.dimY+0.5))
        plt.xticks(np.arange(-1, self.dimX+1, 1.0))
        plt.yticks(np.arange(-1, self.dimY+1, 1.0))
        # draw obstacles
        for i in range(0, self.dimX):
            for j in range(0, self.dimY):
                if self.occupancy[i, j] == 1:
                    axPlt.add_patch(patches.Rectangle(
                        (self.coordinateX[i, j]-0.5, self.coordinateY[i, j]-0.5), 1, 1, color='gray'))
                    # plt.plot( , , 's', color='r', markersize=40)
        # draw borders
        for j in range(-1, self.dimX+2):
            axPlt.add_patch(patches.Rectangle(
                (j-0.5, -1.5), 1, 1, color='gray'))
            axPlt.add_patch(patches.Rectangle(
                (j-0.5, self.dimY-0.5), 1, 1, color='gray'))
        for j in range(-1, self.dimY+2):
            axPlt.add_patch(patches.Rectangle(
                (-1.5, j-0.5), 1, 1, color='gray'))
            axPlt.add_patch(patches.Rectangle(
                (self.dimX-0.5, j-0.5), 1, 1, color='gray'))

        axPlt.grid(True)

    # weighted Astar
    # parent node of each node is modified durring path finding and can be used to built path from closedList
    def AStarFindPath(self, startNodeNo, goalNodeNo, epsilon=1.0):

        iterationNb = 0

        goalNode = self.graph.listOfNodes[goalNodeNo]

        closedList = []  # will contain nodes
        openList = []  # will contain node numeros

        self.graph.listOfNodes[startNodeNo].g = 0.0

        openList.append(self.graph.listOfNodes[startNodeNo])

        successFlag = False

        while (len(openList) > 0):

            # find node with lowest score f in openList
            nc = openList[0]
            ncNo = 0
            for i in range(0, len(openList)):
                if (openList[i].f < nc.f):
                    ncNo = i
            # remove this node from openList
            nc = openList.pop(ncNo)

            # put its numero into closedList
            closedList.append(nc.no)

            # if it corresponds to the goal node: end of algo with success
            if (nc.no == goalNodeNo):
                successFlag = True
                print("  - Nb of iterations: " + str(iterationNb))
                print("  - Nb of nodes explored: "+str(len(closedList)))
                return closedList, successFlag

            # list of numeros of successors of node nc
            S = self.graph.succNoOfNode(nc.no)

            # for each successor of node nc in S
            for succNo in S:
                s = self.graph.listOfNodes[succNo]

                if (s.g > (nc.g + distance(nc, s))):
                    s.g = nc.g + distance(nc, s)
                    s.f = s.g + epsilon*heuristic(s, goalNode)

                    # nc delclared as parent node for s -> used to build the path in a backward way
                    s.parentNo = nc.no

                    openList.append(s)

                    iterationNb = iterationNb+1

        print("  - Nb of iterations: " + str(iterationNb))
        print("  - Nb of nodes explored: "+str(len(closedList)))

        return closedList, successFlag

    # return a list with node numbers from stert to goal node along path found by AStar

    def builtPath(self, closedList):
        # local copy to not modify closedList parameter => work with cList inside this function
        cList = list(closedList)
        distance = 0
        path = []

        path.insert(0, cList[-1])
        parentExits = True

        while parentExits:
            parNode = self.graph.listOfNodes[path[0]].parentNo

            if parNode == None:
                parentExits = False
            else:
                distance += euclidianDist(
                    self.graph.listOfNodes[path[0]], self.graph.listOfNodes[parNode])
                path.insert(0, parNode)

        print("DISTANCE " + str(distance))
        return path, distance

    def plotPathOnMap(self, path, noFig=1):
        self.plot(noFig)
        nodeStart = self.graph.listOfNodes[path[0]]
        for i in range(0, len(path)-1):
            node = self.graph.listOfNodes[path[i]]
            nodeNext = self.graph.listOfNodes[path[i+1]]
            plt.plot([node.x, nodeNext.x], [node.y, nodeNext.y], 'ro-')
        plt.plot([nodeStart.x], [nodeStart.y], 'bo')

    def plotExploredTree(self, closedList, noFig=1):
        # local copy to not modify closedList parameter
        cList = list(closedList)
        self.plot(noFig)
        while (len(cList) > 0):
            node = self.graph.listOfNodes[cList.pop()]
            if (node.parentNo != None):
                nodeParent = self.graph.listOfNodes[node.parentNo]
                plt.plot([node.x, nodeParent.x], [node.y, nodeParent.y], 'k-')
            else:
                plt.plot([node.x], [node.y], 'bo')


# --- end of map class ---------------------------


# ---- define heuristic function and distance cost function for ASTAR -----
def heuristic(node, nodeGoal):
    return euclidianDist(node, nodeGoal)


def distance(node1, node2):
    return euclidianDist(node1, node2)
# --- end of Astar ------------------------------

# distances


def manhattanDist(node1, node2):
    distance = abs(node1.x - node2.x) + abs(node1.y - node2.y)
    return distance


def euclidianDist(node1, node2):
    distance = math.sqrt(pow((node1.x-node2.x), 2) + pow((node1.y-node2.y), 2))
    return distance


# main  (executed if this file is runned)
if __name__ == '__main__':

    # occupancy grid (0: free, 1: obstacle)
    occupancyGrid = np.array([
        [0, 0, 0, 0, 0, 0, 0],
        [0, 1, 1, 0, 1, 1, 0],
        [0, 0, 1, 0, 0, 1, 0],
        [1, 0, 0, 0, 0, 1, 0],
        [0, 1, 1, 1, 0, 1, 0],
        [0, 0, 0, 0, 0, 1, 0]])

    # max adjacency degree
    adjacency = 8

    # dimensions of the map
    dimX = occupancyGrid.shape[0]
    dimY = occupancyGrid.shape[1]

    # create and plot map
    carte = Map(dimX, dimY, adjacency)
    carte.initCoordinates()
    # carte.generateRandObstacles()
    carte.loadOccupancy(occupancyGrid)
    carte.generateGraph()
    noFig = 2
    carte.plot(noFig)

    # weighted A* algorithm

    startNodeNo = 0
    goalNodeNo = 5
    closedList, successFlag = carte.AStarFindPath(
        startNodeNo, goalNodeNo, epsilon=6.0)

    path, pathLength = carte.builtPath(closedList)
    # print(path)

    noFig = 1
    carte.plotPathOnMap(path, noFig)
    plt.text(0, -2.5, "Path size :" + str(pathLength))

# noFig = 3
# carte.plotExploredTree(closedList, noFig)

plt.show()
