import random


class Student(object):
    """
    Represents a student
    """

    def __init__(self, student_id, student_name):
        self.__student_id = student_id
        self.__student_name = student_name

    def get_student_id(self):
        return self.__student_id

    def get_student_name(self):
        return self.__student_name

    def set_student_name(self, value):
        self.__student_name = value

    def __eq__(self, other):        
        return self.__student_id == other.__student_id
    
    def __str__(self):
        return str(self.get_student_id()) + " " + self.get_student_name()
    
    @staticmethod
    def read_student(line):
        parts = line.split(",")
        return Student(int(parts[0]), parts[1])
    
    @staticmethod
    def write_student(student):
        return str(student.get_student_id()) + "," + student.get_student_name()

    @staticmethod
    def read_student_db(line):
        return Student(int(line[0]), line[1])

    @staticmethod
    def write_student_db(student):
        return (student.get_student_name(), str(student.get_student_id()))
    
    @staticmethod
    def read_student_json(entity_dictionary):
        return Student(int(entity_dictionary["id"]), entity_dictionary["name"])
    
    @staticmethod
    def write_student_json(student):
        entity_dictionary = {"id":student.get_student_id(), "name": student.get_student_name()}
        return entity_dictionary


class Subject(object):
    """
    Represents a subject
    """

    def __init__(self, subject_id, subject_name):
        self.__subject_id = subject_id
        self.__subject_name = subject_name

    def get_subject_id(self):
        return self.__subject_id

    def get_subject_name(self):
        return self.__subject_name

    def set_subject_name(self, value):
        self.__subject_name = value

    def __eq__(self, other):        
        return self.__subject_id == other.__subject_id
    
    def __str__(self):
        return str(self.get_subject_id()) + " " + self.get_subject_name()
    
    @staticmethod
    def read_subject(line):
        parts = line.split(",")
        return Subject(int(parts[0]), parts[1])
    
    @staticmethod
    def write_subject(subject):
        return str(subject.get_subject_id()) + "," + subject.get_subject_name()
    
    @staticmethod
    def read_subject_db(line):
        return Subject(int(line[0]), line[1])

    @staticmethod
    def write_subject_db(subject):
        return (subject.get_subject_name(), str(subject.get_subject_id()))    
    
    @staticmethod
    def read_subject_json(entity_dictionary):
        return Subject(int(entity_dictionary["id"]), entity_dictionary["name"])
    
    @staticmethod
    def write_subject_json(subject):
        entity_dictionary = {"id":subject.get_subject_id(), "name": subject.get_subject_name()}
        return entity_dictionary

    
class Grade(object):
    """
    Represents a grade
    """

    def __init__(self, student, subject, value):
        self.__id = random.randint(1, 100)
        self.__student = student
        self.__subject = subject
        self.__value = value

    def get_student(self):
        return self.__student

    def get_subject(self):
        return self.__subject

    def get_value(self):
        return self.__value

    def set_value(self, new_value):
        self.__value.append(new_value)
    
    def delete_last_value(self):
        self.__value.pop()
    
    def __eq__(self, other):
        return self.__student == other.__student and self.__subject == other.__subject and self.__value == other.__value

    def __str__(self):
        return "student " + str(self.__student.get_student_id()) + " at the discipline " + str(self.__subject.get_subject_id()) + " has a " + str(self.__value)
    
    @staticmethod
    def read_grade(line):
        parts = line.split(",")
        parts[2] = parts[2].replace("[", "") 
        parts[2] = parts[2].replace("]", "")
        grade = Grade(Student(int(parts[0]), ""), Subject(int(parts[1]), ""), float(parts[2]))
        for part in parts[3:]:
            part = part.replace("[", "")
            part = part.replace("]", "")
            grade.set_value(float(part))
        return grade
        
    @staticmethod
    def write_grade(grade):
        return str(grade.get_student().get_student_id()) + "," + str(grade.get_subject().get_subject_id()) + "," + str(grade.get_value())     

    @staticmethod
    def read_grade_db(line):
        return Grade(Student(int(line[0]), None), Subject(int(line[1]), None), float(line[2]))

    @staticmethod
    def write_grade_db(grade):
        return (str(grade.get_student().get_student_id()), str(grade.get_subject().get_subject_id()), str(grade.get_value())) 

    @staticmethod
    def read_grade_json(entity_dictionary):
        return Grade(Student(int(entity_dictionary["student_id"]), None), Subject(int(entity_dictionary["subject_id"]), None), entity_dictionary["value"])
    
    @staticmethod
    def write_grade_json(grade):
        entity_dictionary = {"student_id":grade.get_student().get_student_id(), "subject_id": grade.get_subject().get_subject_id(), "value": grade.get_value()}
        return entity_dictionary

    
class Entity_with_Average(object):

    def __init__(self, entity_id, entity_name, entity_average):
        self.__entity_id = entity_id
        self.__entity_name = entity_name
        self.__entity_average = entity_average

    def get_entity_id(self):
        return self.__entity_id

    def get_entity_name(self):
        return self.__entity_name

    def get_entity_average(self):
        return self.__entity_average

    def set_entity_average(self, value):
        self.__entity_average = value
    
    def __str__(self):
        return str(self.__entity_id) + " and name " + self.__entity_name + " with the average " + str(self.__entity_average) + "\n"
    
    
class Settings():

    def __init__(self, filename):
        self.__settings_filename = filename
        instance_variables = []
        file = open(self.__settings_filename, encoding="utf8")
        lines = file.readlines()
        for line in lines:
            line = line.strip()
            if line != "":
                parts = line.split("=")
                variable = parts[1]
                variable = variable.replace('"', '')
                variable = variable.strip()
                instance_variables.append(variable)
        self.__repo_type, self.__repo_student_filename, self.__repo_subject_filename, self.__repo_grade_filename = instance_variables[:]

    def get_repo_type(self):
        return self.__repo_type

    def get_repo_student_filename(self):
        return self.__repo_student_filename

    def get_repo_subject_filename(self):
        return self.__repo_subject_filename

    def get_repo_grade_filename(self):
        return self.__repo_grade_filename
    
