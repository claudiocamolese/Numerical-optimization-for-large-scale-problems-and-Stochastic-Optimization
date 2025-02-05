import numpy as np
from instances import *
from solvers import *
import json

nRooms = 10
hospital = Hospital(nRooms)
print(hospital.occupation)

hospital.addPatient(3)
print(hospital.occupation)

hospital.removePatient(3)
print(hospital.occupation)

with open("./prj_temp/settings/solver_setting.json") as f:
    solverSetting = json.load(f)

ga = GaSolver(solverSetting)
ga.solve()