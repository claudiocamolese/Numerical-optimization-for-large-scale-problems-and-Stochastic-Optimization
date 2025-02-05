import math

class Hospital():
    # It will contain all data that characterize the hospital: n° rooms, space, patients...
    def __init__(self, nRooms):
        self.nRooms = nRooms
        self.occupation = [0] * nRooms
    
    def addPatient(self, idxRoom):
        self.occupation[idxRoom] += 1
        
    def removePatient(self, idxRoom):
        self.occupation[idxRoom] -= 1
        
    def fitness(self):
        return math.abs(sum(self.occupation) - 2 * self.nRooms)