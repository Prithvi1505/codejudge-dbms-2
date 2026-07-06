from abc import ABC, abstractmethod

class EnrollmentRepository(ABC):
    @abstractmethod
    def save(self, enrollment):
        pass

class Student:
    def __init__(self, student_id, name, department):
        self.student_id = student_id
        self.name = name
        self.department = department

class Enrollment:
    def __init__(self, student_id, course_code, marks):
        self.student_id = student_id
        self.course_code = course_code
        self.marks = marks

    def get_details(self):
        return f"Student {self.student_id} enrolled in {self.course_code} with {self.marks} marks"
