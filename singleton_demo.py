import threading

class DatabaseConnection:
    _instance = None
    _lock = threading.Lock()

    def __new__(cls):
        if cls._instance is None:
            with cls._lock:  # Double-checked locking
                if cls._instance is None:
                    cls._instance = super().__new__(cls)
                    # Initialize connection here
                    print("Database connection created")
        return cls._instance

    def get_connection(self):
        return "Shared DB Connection Object"

# Test (thread-safe)
def test_singleton():
    conn1 = DatabaseConnection()
    conn2 = DatabaseConnection()
    print(conn1 is conn2)  # True

if __name__ == "__main__":
    test_singleton()
