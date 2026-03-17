"""This module contains EVM exception types used by LASER."""


class VmException(Exception):
    """The base VM exception type."""


class StackUnderflowException(IndexError, VmException):
    """A VM exception regarding stack underflows."""


class StackOverflowException(VmException):
    """A VM exception regarding stack overflows."""


class InvalidJumpDestination(VmException):
    """A VM exception regarding JUMPs to invalid destinations."""


class InvalidInstruction(VmException):
    """A VM exception denoting an invalid op code has been encountered."""


class OutOfGasException(VmException):
    """A VM exception denoting the current execution has run out of gas."""


class WriteProtection(VmException):
    """A VM exception denoting that a write operation is executed on a write protected environment"""
