from mythril.laser.smt import K, Concat, simplify
from copy import copy, deepcopy


class TransientStorage:
    """
    Implements transient storage using an SMT Array.
    This class tracks set operations in a journal and dynamically constructs SMT queries based on the journal entries.
    """

    def __init__(self, journal=None):
        """
        Initializes the TransientStorage object.

        Args:
            journal (list): A list to track set operations. Defaults to an empty list.
        """
        self.journal = journal or []

    def get(self, addr, index):
        """
        Constructs and returns an SMT query using the journal.

        Args:
            addr: Address component of the key.
            index: Index component of the key.

        Returns:
            An SMT query representing the value associated with the given key.
        """
        key = Concat(addr, index)  # Size: 256 + 256
        dynamic_storage = K(512, 256, 0)

        # Construct an SMT array based on journal entries
        for entry in self.journal:
            current_key, current_value = entry["key"], entry["value"]
            dynamic_storage[current_key] = current_value
        return dynamic_storage[key]

    def set(self, addr, index, value):
        """
        Logs the set operation in the journal.

        Args:
            addr: Address component of the key.
            index: Index component of the key.
            value: Value to be associated with the key.
        """
        key = simplify(Concat(addr, index))
        self.journal.append({"key": key, "value": value})

    def clear(self):
        """
        Clears the journal.
        This method should be called before user transactions.
        """
        self.journal = []

    def __copy__(self):
        """
        Returns a shallow copy of the TransientStorage object.
        """
        return TransientStorage(copy(self.journal))

    def __deepcopy__(self):
        """
        Returns a deep copy of the TransientStorage object.
        """
        return TransientStorage(deepcopy(self.journal))
