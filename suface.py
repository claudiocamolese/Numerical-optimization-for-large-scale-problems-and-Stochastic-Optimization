import numpy as np
from scipy.optimize import minimize
import matplotlib.pyplot as plt

class PriceOptimizationIndependent:
    def __init__(self, demand, costs):
        """
        :param demand: Lista delle domande fisse o distribuzioni casuali
        :param costs: Lista dei costi unitari per prodotto
        """
        self.demand = demand
        self.costs = costs
        self.n_products = len(demand)
    
    def profit(self, prices):
        """
        Calcola il profitto totale dato un vettore di prezzi.
        :param prices: Lista dei prezzi per ciascun prodotto
        :return: Profitto totale
        """
        return np.sum([(p - c) * q for p, c, q in zip(prices, self.costs, self.demand)])

# Domanda e costi per prodotto
fixed_demand = [100, 150, 200]  # Domanda fissa per prodotto
unit_costs = [20, 30, 40]       # Costi unitari per prodotto

# Crea l'istanza
optimizer = PriceOptimizationIndependent(demand=fixed_demand, costs=unit_costs)

# Ottimizza i prezzi
def objective_function(prices):
    # Negativo del profitto, perché stiamo minimizzando
    return -optimizer.profit(prices)

# Limiti dei prezzi
price_bounds = [(10, 100), (10, 100), (10, 100)]  # Limiti per ciascun prodotto

# Valori iniziali per i prezzi
initial_prices = [50, 50, 50]

# Ottimizzazione
result = minimize(objective_function, initial_prices, bounds=price_bounds)

# Risultati
optimal_prices = result.x
optimal_profit = -result.fun
print(f"Prezzi ottimali: {optimal_prices}")
print(f"Profitto massimo: {optimal_profit:.2f}")

# Genera una griglia per due prodotti (fissando il prezzo del terzo)
p1_vals = np.linspace(10, 100, 50)
p2_vals = np.linspace(10, 100, 50)
p1_grid, p2_grid = np.meshgrid(p1_vals, p2_vals)
fixed_price_p3 = 50

# Calcola i profitti
profit_vals = np.array([[optimizer.profit([p1, p2, fixed_price_p3]) for p2 in p2_vals] for p1 in p1_vals])

# Crea plot 3D
fig = plt.figure(figsize=(10, 6))
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(p1_grid, p2_grid, profit_vals, cmap='viridis', edgecolor='none')
ax.set_title("Superficie del Profitto")
ax.set_xlabel("Prezzo Prodotto 1")
ax.set_ylabel("Prezzo Prodotto 2")
ax.set_zlabel("Profitto")
plt.show()
