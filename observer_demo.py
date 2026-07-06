class MarksUpdateNotifier:
    def __init__(self):
        self.observers = []

    def register_observer(self, observer):
        self.observers.append(observer)

    def notify(self, student_id, new_marks):
        for observer in self.observers:
            observer.update(student_id, new_marks)

class EmailNotifier:
    def update(self, student_id, new_marks):
        print(f"Email sent to student {student_id}: New marks = {new_marks}")

class AuditLogNotifier:
    def update(self, student_id, new_marks):
        print(f"Audit log: Student {student_id} marks updated to {new_marks}")

# Usage
notifier = MarksUpdateNotifier()
notifier.register_observer(EmailNotifier())
notifier.register_observer(AuditLogNotifier())
notifier.notify(1001, 92)
