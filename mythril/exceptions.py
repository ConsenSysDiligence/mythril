"""This module contains general exceptions used by Mythril."""


class MythrilBaseException(Exception):
    """The Mythril exception base type."""


class CompilerError(MythrilBaseException):
    """A Mythril exception denoting an error during code compilation."""


class UnsatError(MythrilBaseException):
    """A Mythril exception denoting the unsatisfiability of a series of
    constraints."""


class SolverTimeOutException(UnsatError):
    """A Mythril exception denoting the unsatisfiability of a series of
    constraints."""


class NoContractFoundError(MythrilBaseException):
    """A Mythril exception denoting that a given contract file was not
    found."""


class CriticalError(MythrilBaseException):
    """A Mythril exception denoting an unknown critical error has been
    encountered."""


class DetectorNotFoundError(MythrilBaseException):
    """A Mythril exception denoting attempted usage of a non-existant
    detection module."""


class IllegalArgumentError(ValueError):
    """The argument used does not exist"""
