# import library
import gurobipy as gp
from gurobipy import GRB
import matplotlib.pyplot as plt
import numpy as np
from scipy.optimize import maximize

##  Esempio di applicazione
#   brand fashion
#   2 tipi di prodotti: Felpa, Jeans
#   3 ingredienti: Stoffa, Cerniera, Bottone
#   1 macchina

# costanti
I = ['Stoffa', 'Cerniera', 'Bottone']
J = ['Felpa', 'Jeans']
M = ['M1']
C = np.array([1, 1, 1])
P = np.array([75, 100])
Lm = [8]
Tim = np.array([[0.5, 1.33, 0.14]])
Gij = np.array([[1,1,0],[1,1,1]])

# scenari
a = 4
# b = 0 # dipende dalla clientela: attenti al prezzo: b a valore assoluto piccolo, prodotti di prima necessita: b a valore assoluto alto
np.random.seed(1)
n_scenarios = 100
prob = 1/n_scenarios
demand = np.round(np.clip(np.random.normal(loc=a, scale=2, size=len(J)*n_scenarios), a_min=0, a_max=np.inf).reshape((len(J), n_scenarios))) # domanda indipende dal prezzo
print(demand)

# Create a new model
model = gp.Model("fashon")

x = model.addVars(len(I), vtype=GRB.INTEGER, name="x")
y = model.addVars(len(J), n_scenarios, vtype=GRB.INTEGER, name="y")

# Objective function: minimize fixed costs + transportation costs
model.setObjective(
    - gp.quicksum(C[i] * x[i] for i in range(len(I)))
    + prob * gp.quicksum(P[j] * y[j, s] for j in range(len(J)) for s in range(n_scenarios)),
    GRB.MAXIMIZE
)

# Constraint 1: 
model.addConstrs(
    (gp.quicksum(Tim[m, i] * x[i] for i in range(len(I))) <= Lm[m] for m in range(len(M))), 
    name="production_capacity_constraint"
)

# Constraint 2: 
model.addConstrs(
    (y[j, s] <= demand[j, s] for j in range(len(J)) for s in range(n_scenarios)), 
    name="constraint_on_demand"
)

# Constraint 3: 
model.addConstrs(
    (gp.quicksum(Gij[j, i] * y[j, s] for j in range(len(J))) <= x[i] for i in range(len(I)) for s in range(n_scenarios)), 
    name="constraint_on_amount_of_components"
)

# Constraint 4: 
model.addConstrs(
    (y[j, s] >= 0 for j in range(len(J)) for s in range(n_scenarios)), 
    name="feasible_space_on_y"
)

# Constraint 5: 
model.addConstrs(
    (x[i] >= 0 for i in range(len(I))), 
    name="feasible_space_on_x"
)

model.optimize()

if model.status == GRB.OPTIMAL:
    print("\nOptimal Solution Found:")
    print(x)