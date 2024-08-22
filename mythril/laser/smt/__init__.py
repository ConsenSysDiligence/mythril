from typing import Any, Generic, Optional, Set, TypeVar, Union

import z3

from mythril.laser.smt.array import Array, BaseArray, K
from mythril.laser.smt.bitvec import BitVec
from mythril.laser.smt.bitvec_helper import (
    UGE,
    UGT,
    ULE,
    ULT,
    BVAddNoOverflow,
    BVMulNoOverflow,
    BVSubNoUnderflow,
    Concat,
    Extract,
    If,
    LShR,
    SRem,
    Sum,
    UDiv,
    URem,
)
from mythril.laser.smt.bool import And, Not, Or, is_false, is_true
from mythril.laser.smt.bool import Bool as SMTBool
from mythril.laser.smt.expression import Expression, simplify
from mythril.laser.smt.function import Function
from mythril.laser.smt.model import Model
from mythril.laser.smt.solver import Optimize, Solver, SolverStatistics

Annotations = Optional[Set[Any]]
T = TypeVar("T", bound=Union[SMTBool, z3.BoolRef])
U = TypeVar("U", bound=Union[BitVec, z3.BitVecRef])


class SymbolFactory(Generic[T, U]):
    """A symbol factory provides a default interface for all the components of mythril to create symbols"""

    @staticmethod
    def Bool(value: "__builtins__.bool", annotations: Annotations = None) -> T:
        """
        Creates a Bool with concrete value
        :param value: The boolean value
        :param annotations: The annotations to initialize the bool with
        :return: The freshly created Bool()
        """
        raise NotImplementedError

    @staticmethod
    def BoolSym(name: str, annotations: Annotations = None) -> T:
        """
        Creates a boolean symbol
        :param name: The name of the Bool variable
        :param annotations: The annotations to initialize the bool with
        :return: The freshly created Bool()
        """
        raise NotImplementedError

    @staticmethod
    def BitVecVal(value: int, size: int, annotations: Annotations = None) -> U:
        """Creates a new bit vector with a concrete value.

        :param value: The concrete value to set the bit vector to
        :param size: The size of the bit vector
        :param annotations: The annotations to initialize the bit vector with
        :return: The freshly created bit vector
        """
        raise NotImplementedError()

    @staticmethod
    def BitVecSym(name: str, size: int, annotations: Annotations = None) -> U:
        """Creates a new bit vector with a symbolic value.

        :param name: The name of the symbolic bit vector
        :param size: The size of the bit vector
        :param annotations: The annotations to initialize the bit vector with
        :return: The freshly created bit vector
        """
        raise NotImplementedError()


class _SmtSymbolFactory(SymbolFactory[SMTBool, BitVec]):
    """
    An implementation of a SymbolFactory that creates symbols using
    the classes in: mythril.laser.smt
    """

    @staticmethod
    def Bool(value: "__builtins__.bool", annotations: Annotations = None) -> SMTBool:
        """
        Creates a Bool with concrete value
        :param value: The boolean value
        :param annotations: The annotations to initialize the bool with
        :return: The freshly created Bool()
        """
        raw = z3.BoolVal(value)
        return SMTBool(raw, annotations)

    @staticmethod
    def BoolSym(name: str, annotations: Annotations = None) -> SMTBool:
        """
        Creates a boolean symbol
        :param name: The name of the Bool variable
        :param annotations: The annotations to initialize the bool with
        :return: The freshly created Bool()
        """
        raw = z3.Bool(name)
        return SMTBool(raw, annotations)

    @staticmethod
    def BitVecVal(value: int, size: int, annotations: Annotations = None) -> BitVec:
        """Creates a new bit vector with a concrete value."""
        raw = z3.BitVecVal(value, size)
        return BitVec(raw, annotations)

    @staticmethod
    def BitVecSym(name: str, size: int, annotations: Annotations = None) -> BitVec:
        """Creates a new bit vector with a symbolic value."""
        raw = z3.BitVec(name, size)
        return BitVec(raw, annotations)


class _Z3SymbolFactory(SymbolFactory[z3.BoolRef, z3.BitVecRef]):
    """
    An implementation of a SymbolFactory that directly returns
    z3 symbols
    """

    @staticmethod
    def Bool(value: "__builtins__.bool", annotations: Annotations = None) -> z3.BoolRef:
        """Creates a new bit vector with a concrete value"""
        return z3.BoolVal(value)

    @staticmethod
    def BitVecVal(
        value: int, size: int, annotations: Annotations = None
    ) -> z3.BitVecRef:
        """Creates a new bit vector with a concrete value."""
        return z3.BitVecVal(value, size)

    @staticmethod
    def BitVecSym(
        name: str, size: int, annotations: Annotations = None
    ) -> z3.BitVecRef:
        """Creates a new bit vector with a symbolic value."""
        return z3.BitVec(name, size)


# This is the instance that other parts of mythril should use

# Type hints are not allowed here in 3.5
# symbol_factory: SymbolFactory = _SmtSymbolFactory()
symbol_factory = _SmtSymbolFactory()
