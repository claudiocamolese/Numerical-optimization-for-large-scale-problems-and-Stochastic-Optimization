import numpy as np
from collections import deque 
import matplotlib.pyplot as plt
import gurobipy as gp
from gurobipy import GRB
from scipy.optimize import minimize

from mpl_toolkits.mplot3d import Axes3D
from sklearn.preprocessing import MinMaxScaler
from sklearn.linear_model import LinearRegression

class ATO():
    def __init__(self):
        self.I = ['Stoffa', 'Cerniera', 'Bottone']
        self.J = ['Felpa', 'Jeans']
        self.M = ['M1']
        self.C = np.array([5, 3, 2])
        self.Lm = np.array([24])
        self.Tim = np.array([[0.5, 1.33, 1.9]])
        self.Gij = np.array([[1,1,0], [1,1,1]])
        
        self.n_items = len(self.I)
        self.n_products = len(self.J)
        self.n_machines = len(self.M)
        
        self.n_scenarios = 100
        self.prob = 1/self.n_scenarios
        
        self.distr_mean = 1
        self.distr_std = 1
        
        self.a = 5
        self.b = 0.04
        self.eps = np.random.normal(
                    loc=self.distr_mean,
                    scale=self.distr_std,
                    size=(self.n_products, self.n_scenarios))
        
        self.model = gp.Model("ATO")
        
        self.model.setParam('OutputFlag', 0)

        self.x = self.model.addVars(self.n_items, vtype=GRB.INTEGER, name="x")
        self.y = self.model.addVars(self.n_products, self.n_scenarios, vtype=GRB.INTEGER, name="y")

        # Constraint 1: 
        self.model.addConstrs(
            (gp.quicksum(self.Tim[m, i] * self.x[i] for i in range(self.n_items)) <= self.Lm[m] for m in range(self.n_machines)), 
            name="production_capacity_constraint"
        )

        # Constraint 3: 
        self.model.addConstrs(
            (gp.quicksum(self.Gij[j, i] * self.y[j, s] for j in range(self.n_products)) <= self.x[i] for i in range(self.n_items) for s in range(self.n_scenarios)), 
            name="constraint_on_amount_of_components"
        )

        # Constraint 4: 
        self.model.addConstrs(
            (self.y[j, s] >= 0 for j in range(self.n_products) for s in range(self.n_scenarios)), 
            name="feasible_space_on_y"
        )

        # Constraint 5: 
        self.model.addConstrs(
            (self.x[i] >= 0 for i in range(self.n_items)), 
            name="feasible_space_on_x"
        )
    
    def demandDistribution(self, P):
        Prices = np.array(P).reshape(-1, 1)
        self.demand_distr = np.round(
        np.clip(
            200 / Prices + self.eps,
            a_min=0,
            a_max=np.inf))
        return self.demand_distr
    
    
    def run_simulation(self, P, seed=None):
        np.random.seed(seed)
        demand = self.demandDistribution(P)
        
        # Constraint 2: 
        self.model.addConstrs(
            (self.y[j, s] <= demand[j, s] for j in range(self.n_products) for s in range(self.n_scenarios)), 
            name="constraint_on_demand"
        )
        
        # Objective function: minimize fixed costs + transportation costs
        self.model.setObjective(
            - gp.quicksum(self.C[i] * self.x[i] for i in range(self.n_items))
            + self.prob * gp.quicksum(P[j] * self.y[j, s] for j in range(self.n_products) for s in range(self.n_scenarios)),
            GRB.MAXIMIZE
        )
    
        self.model.optimize()

        if self.model.status == GRB.OPTIMAL:
            # print("\nOptimal Solution Found:")
            # print(self.x)
            # for v in self.model.getVars():
            #     print(f'{v.varName} = {v.x}')
            # print(self.model.ObjVal)
            return self.model.ObjVal
        return np.nan
    

ato = ATO()

n_products = 2
n_reps = 3

P = np.array([[30.0, 50.0], [40.0, 60.0]])

dict_res = {(s,d): {} for s in range(int(P[0][0]), int(P[0][1])+1) for d in range(int(P[1][0]), int(P[1][1])+1)}

for p1 in range(int(P[0][0]), int(P[0][1])+1):
    for p2 in range(int(P[1][0]), int(P[1][1])+1):
        tmp = np.zeros(n_reps)
        for i in range(n_reps):
            tmp[i] = ato.run_simulation([p1, p2], seed=i)
            
        dict_res[p1, p2] = np.average(tmp)

print(dict_res)


effect_s = ((dict_res[P[0][1], P[1][1]] - dict_res[P[0][0], P[1][1]]) + (dict_res[P[0][1], P[1][0]] - dict_res[P[0][0], P[1][0]])) / 2 
effect_d = ((dict_res[P[0][1], P[1][1]] - dict_res[P[0][1], P[1][0]]) + (dict_res[P[0][0], P[1][1]] - dict_res[P[0][0], P[1][0]])) / 2 
effect_sd = ((dict_res[P[0][1], P[1][1]] - dict_res[P[0][0], P[1][1]]) - (dict_res[P[0][1], P[1][0]] - dict_res[P[0][0], P[1][0]])) / 2 

print(f"effect_s: {effect_s:.2f}")
print(f"effect_d: {effect_d:.2f}")
print(f"effect_sd: {effect_sd:.2f}")


# create dataset for metamodel
X = np.zeros((len(dict_res),5))
y = np.zeros(len(dict_res))

count = 0
for key, ele in dict_res.items(): 
    X[count, 0] = key[0] 
    X[count, 1] = key[1] 
    X[count, 2] = key[0] * key[1] 
    X[count, 3] = key[0] ** 2
    X[count, 4] = key[1] ** 2
    y[count] = ele 
    count += 1

scaler = MinMaxScaler(feature_range=(-1, 1))

X_normalized = scaler.fit_transform(X)
print(X_normalized)

# Create and fit the Linear Regression model
model = LinearRegression()
model.fit(X_normalized, y)

# Get the model parameters
slope = model.coef_        # Coefficient (slope)
intercept = model.intercept_   # Intercept

# Print the parameters
print(f"Slope (Coefficient): {slope}")
print(f"Intercept: {intercept}")
response_function = lambda p1, p2: intercept + slope[0]*p1 + slope[1]*p2 + slope[2]*p1*p2 + slope[3]*p1**2 + slope[4]*p2**2

x1_grad_0 = (2 * slope[0] * slope[4] - slope[1] * slope[2]) / (slope[2] ** 2 - 4 * slope[3] * slope[4])
x2_grad_0 = (2 * slope[1] * slope[3] - slope[0] * slope[2]) / (slope[2] ** 2 - 4 * slope[3] * slope[4])

autoval_1 = slope[3] + slope[4] + np.sqrt(slope[3] ** 2 + slope[4] ** 2 - 2 * slope[3] * slope[4] + slope[2] ** 2)
autoval_2 = slope[3] + slope[4] - np.sqrt(slope[3] ** 2 + slope[4] ** 2 - 2 * slope[3] * slope[4] + slope[2] ** 2)

print(f'Il punto ({x1_grad_0},{x2_grad_0}) è un punto di ', end = '')
if autoval_1 > 0 and autoval_2 > 0:
    print('minimo')
elif autoval_1 < 0 and autoval_2 < 0:
    print('massimo')
else:
    print('sella')

# Optimize metamodel

# Create mesh grid for x1 and x2 for surface visualization
x1_vals = np.linspace(-1, 1, 100)
x2_vals = np.linspace(-1, 1, 100)
x1_grid, x2_grid = np.meshgrid(x1_vals, x2_vals)

# Compute the response values for the mesh grid
z_vals = response_function(x1_grid, x2_grid)
print(np.max(z_vals))

# Create a 3D plot for the response surface
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(x1_grid, x2_grid, z_vals, cmap='viridis', edgecolor='none')
ax.set_title("Response Surface")
ax.set_xlabel("x1")
ax.set_ylabel("x2")
ax.set_zlabel("Response f(x1, x2)")
plt.show()

# Create a contour plot
plt.figure(figsize=(8, 6))
contour = plt.contourf(x1_grid, x2_grid, z_vals, cmap='viridis', levels=50)
plt.colorbar(contour)
plt.title("Contour Plot of the Response Surface")
plt.xlabel("x1")
plt.ylabel("x2")
plt.show()

# Optimization: Find the optimal values for x1 and x2
def objective_function(x):
    return -response_function(x[0], x[1])

# Initial guess for optimization
initial_guess = [0, 0]

# Perform optimization
bnds = ((-1, 1), (-1,1))
result = minimize(objective_function, initial_guess, bounds=bnds)

# Display the optimal solution
optimal_x1, optimal_x2 = result.x
optimal_response = response_function(optimal_x1, optimal_x2)

optimalp1 = scaler.inverse_transform(np.array([[optimal_x1, optimal_x2, optimal_x1 * optimal_x2, optimal_x1*2, optimal_x2*2]]))

print(f"Optimal s: {optimalp1[0,0]}")
print(f"Optimal d: {optimalp1[0,1]}")
print(f"Optimal response: {optimal_response}")