from domain.entities import Student, Subject, Grade, Entity_with_Average
from errors.exceptions import ValidError
from itterable_data_stucture.itterator import gnome_sort


class Service_grade(object):
    
    def __init__(self, repo_student, repo_subject, repo_grade, validator_grade, service_undo):
        self.__repo_student = repo_student
        self.__repo_subject = repo_subject
        self.__repo_grade = repo_grade
        self.__validator_grade = validator_grade
        self.__service_undo = service_undo
        
    def add_grade(self, student_id, subject_id, value):
        """
        function that takes a student_id, a subject_id and a value, creates an object of type Grade, validates it ands it to the repo if it is possible
        input: self - object of type Service_grade, student_id - (int) the id of the student, subject_id - (int) the id of the subject, value - (int) the value of the grade
        output: -
        """
        grade = Grade(Student(student_id, None), Subject(subject_id, None), value)
        self.__validator_grade.validate_grade(grade)
        self.__repo_student.search(grade.get_student())
        self.__repo_subject.search(grade.get_subject())
        self.__repo_grade.add_grade(grade)

        function = self.__service_undo.remove_grade
        inverse_function = [[function, grade, "undo is calling"]]
        self.__service_undo.add_undo_function(inverse_function)
        
        self.__service_undo.clear_redo_list()
        
    def remove_grade_if_student_is_removed(self, student_id):
        """
        function that takes a student_id, creates an object student_key with id of student_id and removes from the repo the grade with the same stduent_id as student_key
        input: self - object of type Service_grade, student_id - (int) the id of the stundent 
        output: -
        """
        student_key = Student(student_id, None)
        self.__repo_grade.remove_grade_if_student_is_removed(student_key)
    
    def remove_grade_if_subject_is_removed(self, subject_id):
        """
        function that takes a subject_id, creates an object subject_key with id of subject_id and removes from the repo the grade with the same subject_id as subject_key
        input: self - object of type Service_grade, subject_id - (int) the id of the subject
        output: -
        """
        subject_key = Subject(subject_id, None)
        self.__repo_grade.remove_grade_if_subject_is_removed(subject_key)
    
    def get_grades(self):
        """
        function that returns a list of all the grades
        input: self - object of type Service_grade,
        output: self.__repo_grade.get_all() - the list of all grades
        """
        return self.__repo_grade.get_all()

    def statistics_failing_students(self):
        found_students = []
    
#         grades = self.__repo_grade.get_all()
#         for grade in grades:
#             average = sum(grade.get_value()) / len(grade.get_value())
#             if average < 5:
#                 found_students.append(self.__repo_student.search(grade.get_student()))
        
        grades = self.__repo_grade.get_all()
        students_situation = {}
        students_with_avarages = []
        for grade in grades:
            if grade.get_student().get_student_id() not in students_situation:
                students_situation[grade.get_student().get_student_id()] = []
#             discipline_average = sum(grade.get_value()) / len(grade.get_value())
            students_situation[grade.get_student().get_student_id()].append(grade.get_value())    
        for student_situation in students_situation.items():     
            student_id = student_situation[0]
            average = sum(student_situation[1]) / len(student_situation[1])
            if average < 5:
                student = self.__repo_student.search(Student(student_id, None))
                found_students.append(student)
        return found_students
    
    def statistics_best_students(self):
        grades = self.__repo_grade.get_all()
        students_situation = {}
        students_with_avarages = []
        for grade in grades:
            if grade.get_student().get_student_id() not in students_situation:
                students_situation[grade.get_student().get_student_id()] = []
#             discipline_average = sum(grade.get_value()) / len(grade.get_value())
            students_situation[grade.get_student().get_student_id()].append(grade.get_value())    
        for student_situation in students_situation.items():     
            student_id = student_situation[0]
            average = sum(student_situation[1]) / len(student_situation[1])
            student_name = self.__repo_student.search(Student(student_id, None)).get_student_name()
            student_with_average = Entity_with_Average(student_id, student_name, average)
            students_with_avarages.append(student_with_average)
        # students_with_avarages.sort(key=lambda x:x.get_entity_average(), reverse=True)
        
        students_with_avarages = gnome_sort(students_with_avarages, key=lambda x:x.get_entity_average())
        students_with_avarages.reverse()
        return students_with_avarages

    def statistics_subjects(self):
        grades = self.__repo_grade.get_all()
        subjects_situation = {}
        subjects_with_avarages = []
        for grade in grades:
            if grade.get_subject().get_subject_id() not in subjects_situation:
                subjects_situation[grade.get_subject().get_subject_id()] = []
            subjects_situation[grade.get_subject().get_subject_id()].append(grade.get_value())    
        for subject_situation in subjects_situation.items():     
            subject_id = subject_situation[0]
            average = sum(subject_situation[1]) / len(subject_situation[1])
            subject_name = self.__repo_subject.search(Subject(subject_id, None)).get_subject_name()
            subject_with_average = Entity_with_Average(subject_id, subject_name, average)
            subjects_with_avarages.append(subject_with_average)
        # subjects_with_avarages.sort(key=lambda x:x.get_entity_average(), reverse=True)
        
        subjects_with_avarages = gnome_sort(subjects_with_avarages, key=lambda x:x.get_entity_average())
        subjects_with_avarages.reverse()
        return subjects_with_avarages
    

class Service_student(object):

    def __init__(self, repo_student, repo_grade, validator_student, service_undo):
        self.__repo_student = repo_student
        self.__repo_grade = repo_grade
        self.__validator_student = validator_student
        self.__service_undo = service_undo
        
    def initiate_students(self):
        self.__repo_student.initial_student_entities()
    
    def add_student(self, student_id, student_name):
        """
        function that takes a student_id and a student_name, creates an object of type Student, validates it ands it to the repo if it is possible
        input: self - object of type Service_student, student_id - (int) the id of the student, student_name - (string) the name of the student
        output: -
        """
        student = Student(student_id, student_name)
        self.__validator_student.validate_student(student)
        self.__repo_student.add(student)

        function = self.__service_undo.remove_student
        inverse_function = [[function, student, "undo is calling"]]
        self.__service_undo.add_undo_function(inverse_function)
        
        self.__service_undo.clear_redo_list()

    def get_students(self):
        """
        function that returns a list of all the students
        input: self - object of type Service_student,
        output: self.__repo_student.get_all() - the list of all students
        """
        return self.__repo_student.get_all()
    
    def remove(self, student_id):
        """
        function that takes a student_id, creates an object student_key with id of student_id and removes from the repo the student with the same id as student_key
        input: self - object of type Service_student, student_id - (int) the id of the stundent that will be removed
        output: -
        """
        student_key = Student(student_id, None)
        student = self.__repo_student.search(student_key)
        self.__repo_student.remove(student_key)
        function = self.__service_undo.add_student
        inverse_functions = [[function, student, "undo is calling"]]
        
        grades = self.__repo_grade.get_all()
        
        for grade in grades:
            if student_id == grade.get_student().get_student_id():
                function = self.__service_undo.add_grade
                inverse_function = [function, grade, "undo is calling but don't add to the redo stack"]
                inverse_functions.append(inverse_function) 
        
        self.__service_undo.add_undo_function(inverse_functions)
        
        self.__service_undo.clear_redo_list()
    
    def update_student(self, student_id, new_name):
        """
        function that takes a student_id and a new_name, creates an object student_key with id of student_id and a student object with student_id and new_name, validates the student and updates the student in the repo with the same id as student_key
        input: self - object of type Service_student, student_id - (int) the id of the stundent that will be updated, new_name - (string) the new name of the student
        output: -
        """
        student_name_before_change = self.__repo_student.search(Student(student_id, None)).get_student_name()
        student_for_undo = Student(student_id, student_name_before_change)
        
        student = Student(student_id, new_name)
        self.__validator_student.validate_student(student)
        student_key = Student(student_id, None)
        self.__repo_student.update_student(student_key, new_name)
        
        function = self.__service_undo.update_student
        inverse_function = [[function, student_for_undo, new_name, "undo is calling"]]
        self.__service_undo.add_undo_function(inverse_function)

        self.__service_undo.clear_redo_list()
    
    def search_student_with_id(self, student_id):
        student_key = Student(student_id, None)
        student = self.__repo_student.search(student_key)
        return student
        
    def search_student_with_name(self, student_name):
        students = self.__repo_student.get_all()
        students_found = []
        student_name = student_name.lower()
        for student in students:
            name = student.get_student_name().lower()
            if student_name in name:
                students_found.append(student)
        return students_found

                
class Service_subject(object):

    def __init__(self, repo_subject, repo_grade, validator_subject, service_undo):
        self.__repo_subject = repo_subject
        self.__repo_grade = repo_grade
        self.__validator_subject = validator_subject
        self.__service_undo = service_undo
        
    def get_subjects(self):
        """
        function that returns a list of all the subjects
        input: self - object of type Service_subject,
        output: self.__repo_subject.get_all() - the list of all subjects
        """
        return self.__repo_subject.get_all()
    
    def initiate_subjects(self):
        self.__repo_subject.initial_subject_entities()
    
    def add_subject(self, subject_id, subject_name):
        """
        function that takes a subject_id and a subject_name, creates an object of type subject, validates it ands it to the repo if it is possible
        input: self - object of type Service_subject, subject_id - (int) the id of the subject, subject_name - (string) the name of the subject
        output: -
        """
        subject = Subject(subject_id, subject_name)
        self.__validator_subject.validate_subject(subject)
        self.__repo_subject.add(subject)

        function = self.__service_undo.remove_subject
        inverse_function = [[function, subject, "undo is calling"]]
        self.__service_undo.add_undo_function(inverse_function)
    
        self.__service_undo.clear_redo_list()
        
    def remove(self, subject_id):
        """
        function that takes a subject_id, creates an object subject_key with id of subject_id and removes from the repo the subject with the same id as subject_key
        input: self - object of type Service_subject, subject_id - (int) the id of the stundent that will be removed
        output: -
        """

        subject_key = Subject(subject_id, None)
        subject = self.__repo_subject.search(subject_key)
        self.__repo_subject.remove(subject_key)
        function = self.__service_undo.add_subject
        inverse_functions = [[function, subject, "undo is calling"]]
        
        grades = self.__repo_grade.get_all()
        
        for grade in grades:
            if subject_id == grade.get_subject().get_subject_id():
                function = self.__service_undo.add_grade
                inverse_function = [function, grade, "undo is calling but don't add to the redo stack"]
                inverse_functions.append(inverse_function) 
        
        self.__service_undo.add_undo_function(inverse_functions)
        
        self.__service_undo.clear_redo_list()
        
    def update_subject(self, subject_id, new_name):
        """
        function that takes a subject_id and a new_name, creates an object subject_key with id of subject_id and a subject object with subject_id and new_name, validates the subject and updates the subject in the repo with the same id as subject_key
        input: self - object of type Service_subject, subject_id - (int) the id of the stundent that will be updated, new_name - (string) the new name of the subject
        output: -
        """
        subject_name_before_change = self.__repo_subject.search(Subject(subject_id, None)).get_subject_name()
        subject_for_undo = Subject(subject_id, subject_name_before_change)
        
        subject = Subject(subject_id, new_name)
        self.__validator_subject.validate_subject(subject)
        subject_key = Subject(subject_id, None)
        self.__repo_subject.update_subject(subject_key, new_name)
        
        function = self.__service_undo.update_subject
        inverse_function = [[function, subject_for_undo, new_name, "undo is calling"]]
        self.__service_undo.add_undo_function(inverse_function)
    
        self.__service_undo.clear_redo_list()
        
    def search_subject_with_id(self, subject_id):
        subject_key = Subject(subject_id, None)
        subject = self.__repo_subject.search(subject_key)
        return subject
    
    def search_subject_with_name(self, subject_name):
        subjects = self.__repo_subject.get_all()
        subjects_found = []
        subject_name = subject_name.lower()
        for subject in subjects:
            name = subject.get_subject_name().lower()
            if subject_name in name:
                subjects_found.append(subject)
        return subjects_found


class Service_undo_and_redo():

    def __init__(self, repo_student, repo_subject, repo_grade):
        self.__list_for_undo = []
        self.__list_for_redo = []
        self.__repo_student = repo_student
        self.__repo_subject = repo_subject
        self.__repo_grade = repo_grade

    def get_list(self):
        return self.__list_for_undo

    def set_list(self, value):
        self.__list_for_undo.append(value)
        
    def add_undo_function(self, inverse_functions):
        self.__list_for_undo.append(inverse_functions)
        
    def add_redo_function(self, redo_function):
        self.__list_for_redo.append(redo_function)
        
    # Functions for students     
        
    def add_student(self, student, who_is_calling_the_function):
        self.__repo_student.add(student)    
        
        function = self.remove_student
        inverse_function = [function, student]
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
        
    def remove_student(self, student, who_is_calling_the_function):
        self.__repo_student.remove(student)
        function = self.add_student
        inverse_function = [function, student]
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            inverse_functions = [inverse_function]
            grades = self.__repo_grade.get_all()
            for grade in grades:
                if student.get_student_id() == grade.get_student().get_student_id():
                    function = self.add_grade
                    inverse_function = [function, grade, "undo is calling but don't add to the redo stack"]
                    inverse_functions.append(inverse_function) 
                    self.__repo_grade.remove(grade)
            self.add_undo_function(inverse_functions)
            
    def update_student(self, student, new_name, who_is_calling_the_function):
        student_id = student.get_student_id()
        student_key = Student(student_id, None)
        student_name = student.get_student_name()
        self.__repo_student.update_student(student_key, student_name)
        
        function = self.update_student
        student = Student(student_id, new_name)
        inverse_function = [function, student, student_name]        
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
        
    # Functions for subjects
    
    def add_subject(self, subject, who_is_calling_the_function):
        self.__repo_subject.add(subject)    
        
        function = self.remove_subject
        inverse_function = [function, subject]
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
        
    def remove_subject(self, subject, who_is_calling_the_function):
        self.__repo_subject.remove(subject)
        function = self.add_subject
        inverse_function = [function, subject]
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            inverse_functions = [inverse_function]
            grades = self.__repo_grade.get_all()
            for grade in grades:
                if subject.get_subject_id() == grade.get_subject().get_subject_id():
                    function = self.add_grade
                    inverse_function = [function, grade, "undo is calling but don't add to the redo stack"]
                    inverse_functions.append(inverse_function) 
                    self.__repo_grade.remove(grade)
            self.add_undo_function(inverse_functions)
            
    def update_subject(self, subject, new_name, who_is_calling_the_function):
        subject_id = subject.get_subject_id()
        subject_key = Subject(subject_id, None)
        subject_name = subject.get_subject_name()
        self.__repo_subject.update_subject(subject_key, subject_name)
        
        function = self.update_subject
        subject = Subject(subject_id, new_name)
        inverse_function = [function, subject, subject_name]        
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
    
    # Functions for grades
    
    def add_grade(self, grade, who_is_calling_the_function):
        self.__repo_grade.add(grade)
        
        function = self.remove_grade
        inverse_function = [function, grade]         
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
    
    def remove_grade(self, grade, who_is_calling_the_function):
        self.__repo_grade.remove_grade(grade)
        
        function = self.add_grade
        inverse_function = [function, grade]         
        
        if who_is_calling_the_function == "undo is calling":
            inverse_function.append("redo is calling")
            self.add_redo_function(inverse_function)
        if who_is_calling_the_function == "redo is calling":
            inverse_function.append("undo is calling")
            self.add_undo_function([inverse_function])
        
    def undo(self):
        if len(self.__list_for_undo) == 0:
            raise ValidError("no more undos!")
        inverse_functions = self.__list_for_undo.pop(len(self.__list_for_undo) - 1)
        for inverse_function in inverse_functions:
            if len(inverse_function) == 3:
                inverse_function[0](inverse_function[1], inverse_function[2])
            else:
                inverse_function[0](inverse_function[1], inverse_function[2], inverse_function[3])

    def clear_redo_list(self):
        self.__list_for_redo.clear()
    
    def redo(self):
        if len(self.__list_for_redo) == 0:
            raise ValidError("no more redos!")
        redo_function = self.__list_for_redo.pop(len(self.__list_for_redo) - 1)    
        if len(redo_function) == 3:
            redo_function[0](redo_function[1], redo_function[2])
        else:
            redo_function[0](redo_function[1], redo_function[2], redo_function[3])
                        
