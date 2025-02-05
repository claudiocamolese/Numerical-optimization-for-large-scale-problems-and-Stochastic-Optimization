class GaSolver():
    def __init__(self, solverSettings):
        self.nIndividual = solverSettings['nIndividual']
        self.mutationProb = solverSettings['mutationProb'] # probability
        self.nGeneration = solverSettings['nGeneration']
        self.timeLimit = solverSettings['timeLimit']
        
    def solve(self):
        pass