from mythril.laser.smt import K, Concat
from copy import copy, deepcopy


class TransientStorage:
    def __init__(self, journal=None):
        self.journal = journal or []  # Tracks all set operations as a list

    def get(self, addr, index):
        """Dynamically constructs and returns an SMT query using the journal."""
        key = Concat(addr, index)  # Size: 160 + 256 
        dynamic_storage = K(416, 256, 0)
        
        # Construct to an SMT array
        for entry in self.journal:
            current_key, current_value = entry['key'], entry['value']
            dynamic_storage[current_key] = current_value
            
        return dynamic_storage[key]

    def set(self, addr, index, value):
        """Logs the set operation in the journal."""
        key = Concat(addr, index)  
        self.journal.append({'key': key, 'value': value})

    
    def __copy__(self):
        return TransientStorage(copy(self.journal))
    
    def __deepcopy__(self):
        return TransientStorage(deepcopy(self.journal))
