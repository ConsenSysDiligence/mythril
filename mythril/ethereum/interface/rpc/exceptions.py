"""This module contains exceptions regarding JSON-RPC communication."""


class EthJsonRpcError(Exception):
    """The JSON-RPC base exception type."""


class ConnectionError(EthJsonRpcError):
    """An RPC exception denoting there was an error in connecting to the RPC
    instance."""


class BadStatusCodeError(EthJsonRpcError):
    """An RPC exception denoting a bad status code returned by the RPC
    instance."""


class BadJsonError(EthJsonRpcError):
    """An RPC exception denoting that the RPC instance returned a bad JSON
    object."""


class BadResponseError(EthJsonRpcError):
    """An RPC exception denoting that the RPC instance returned a bad
    response."""
