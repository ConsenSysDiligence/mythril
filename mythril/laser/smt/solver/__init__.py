import z3

from mythril.laser.smt.solver.independence_solver import IndependenceSolver
from mythril.laser.smt.solver.solver import BaseSolver, Optimize, Solver
from mythril.laser.smt.solver.solver_statistics import SolverStatistics
from mythril.support.support_args import args

if args.parallel_solving:
    z3.set_param("parallel.enable", True)
