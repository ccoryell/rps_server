class Worksheet:
    def __init__(self):
        self.emptiness = True

    @property
    def is_empty(self):
        return self.emptiness

    def store_value(self, row_number, column_name, value):
        self.emptiness = False

    def delete_value(self, row_number, column_name):
        self.emptiness = True
    
    def read_value(self, row_number, column_name):
        return None