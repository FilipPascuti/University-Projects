from errors.exceptions import RepoError
from domain.entities import Student, Subject
import random
import string
import pickle
import mysql.connector
import json
from itterable_data_stucture.itterator import My_data_structure


class Repo():

    def __init__(self):
        self._entities = My_data_structure()

    def get_entities(self):
        return self._entities
    
    def initial_student_entities(self):
        """
        method that adds 10 randomly generated students to the self._entities
        input: self - an object of type Repo
        output: -
        """
        lower_letters = string.ascii_lowercase
        uppercase_letters = string.ascii_uppercase
        while 10 > len(self._entities):
            try:
                self.add(Student(random.randint(1, 100), ''.join(random.choice(uppercase_letters)) + ''.join(random.choice(lower_letters) for i in range(5))))
            except Exception as ex:
                pass
 
    def initial_subject_entities(self):
        """
        method that adds 10 randomly generated subjects to the self._entities
        input: self - an object of type Repo
        output: -
        """
        lower_letters = string.ascii_lowercase
        uppercase_letters = string.ascii_uppercase
        while 10 > len(self._entities):
            try:
                self.add(Subject(random.randint(1, 100), ''.join(random.choice(uppercase_letters)) + ''.join(random.choice(lower_letters) for i in range(5))))
            except Exception as ex:
                pass
    
    def get_all(self):
        return self._entities[:]
    
    def search(self, key_entity):
        """
        method that searches for a entity in the self._entities based on it's id
        input - key_entity - an object that has an id and the other instances as None
        output: the entity with that specific id
        raises: if key_entity not in the self._entities
                    -> "inexisting id!\n"
        """
        if key_entity not in self._entities:
            raise RepoError("inexisting id!\n")
        for current_entity in self._entities:
            if current_entity == key_entity:
                return current_entity
    
    def add(self, entity):
        """
        method that adds an entity to the self._entities if the id is not taken
        input: entity - an object of type: Student, Subject or Grade
        output: -
        raises: if entity in self._entities:
                    -> "existing id!\n"
        """
        if entity in self._entities:
            raise RepoError("existing id!\n")
        self._entities.append(entity)
    
    def add_grade(self, grade):
        """
        method that adds a grade to the self._entities
        input: grade - an object of type: Grade
        output: -
        """
        self._entities.append(grade)
    
    def remove(self, entity_key):
        """
        method that takes an entity_key and removes the entity in self._entities that has the same id
        input: entity_key - an object that has an id and the other instances as None
        output: -
        """
        i = 0
        while i < len(self._entities):
            if self._entities[i] == entity_key:
                self._entities.pop(i) 
            else:
                i += 1
    
    def remove_grade(self, grade):        
        i = 0
        while i < len(self._entities):
            if self._entities[i] == grade:
                self._entities.pop(i) 
                return 
            else:
                i += 1
        
    def remove_grade_if_student_is_removed(self, student_key):
        """
        method that takes a student_key and removes the grades in self._entities that has the same student_id as the student_key
        input: student_key - an object of type Student that has an id and the name instances as None
        output: -
        """
        i = 0
        while i < len(self._entities):
            if student_key == self._entities[i].get_student():
                self._entities.pop(i)
            else:
                i += 1 
                
    def remove_grade_if_subject_is_removed(self, subject_key):
        """
        method that takes a subject_key and removes the grades in self._entities that has the same subject_id as the student_key
        input: subject_key - an object of type Subject that has an id and the name instances as None
        output: -
        """
        i = 0
        while i < len(self._entities):
            if subject_key == self._entities[i].get_subject():
                self._entities.pop(i)
            else:
                i += 1 
                            
    def update_student(self, student_key, new_name):
        """
        method that takes a student_key and a new_name and updates the student_name to new_name for the student that has the same id as student_key 
        input: student_key - an object of type Student that has an id and the name instances as None, new_name - a sting that will be the new student_name 
        output: -
        """
        for student in self._entities:
            if student == student_key:
                student.set_student_name(new_name)
                
    def update_subject(self, subject_key, new_name):
        """
        method that takes a subject_key and a new_name and updates the subject_name to new_name for the subject that has the same id as subject_key 
        input: subject_key - an object of type Subject that has an id and the name instances as None, new_name - a sting that will be the new subject_name 
        output: -
        """
        for subject in self._entities:
            if subject == subject_key:
                subject.set_subject_name(new_name)


class File_repository(Repo):

    def __init__(self, file_name, read_entity, write_entity):
        Repo.__init__(self)
        self.__file_name = file_name
        self.__read_entity = read_entity
        self.__write_entity = write_entity
        
    def __read_all_from_file(self):
        self._entities = []
        with open(self.__file_name, "r") as file:
            lines = file.readlines()
            for line in lines:
                line = line.strip()
                if line != "":
                    entity = self.__read_entity(line)
                    self._entities.append(entity)
    
    def __write_all_to_file(self):
        with open(self.__file_name, "w") as file:
            for entity in self._entities:
                line = self.__write_entity(entity)
                file.write(line + "\n")

    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def add(self, entity):
        self.__read_all_from_file()
        Repo.add(self, entity)
        self.__write_all_to_file()
    
    def search(self, keyStudent):
        self.__read_all_from_file()
        return Repo.search(self, keyStudent)
        
    def get_all(self):
        self.__read_all_from_file()
        return Repo.get_all(self)

    def add_grade(self, grade):
        self.__read_all_from_file()
        Repo.add_grade(self, grade)
        self.__write_all_to_file()
        
    def remove(self, entity_key):
        self.__read_all_from_file()
        Repo.remove(self, entity_key)
        self.__write_all_to_file()
        
    def remove_grade_if_student_is_removed(self, student_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_student_is_removed(self, student_key)
        self.__write_all_to_file()
        
    def remove_grade_if_subject_is_removed(self, subject_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_subject_is_removed(self, subject_key)
        self.__write_all_to_file()
    
    def update_student(self, student_key, new_name):
        self.__read_all_from_file()
        Repo.update_student(self, student_key, new_name)
        self.__write_all_to_file()
        
    def update_subject(self, subject_key, new_name):
        self.__read_all_from_file()
        Repo.update_subject(self, subject_key, new_name)
        self.__write_all_to_file()
        
    def remove_grade(self, grade):
        self.__read_all_from_file()
        Repo.remove_grade(self, grade)
        self.__write_all_to_file()


class Pickle_repository(Repo):
    
    def __init__(self, file_name):
        self.__filename = file_name
        Repo.__init__(self)

    def __read_all_from_file(self):
        self._entities = []    
        try:
            file = open(self.__filename, "rb")
            self._entities = pickle.load(file)
        except EOFError:
            return []
        except IOError as e:
            print("An error occured - " + str(e))
            raise e
    
    def __write_all_to_file(self):
        file = open(self.__filename, "wb")
        pickle.dump(self._entities, file)
        file.close()

    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def add(self, entity):
        self.__read_all_from_file()
        Repo.add(self, entity)
        self.__write_all_to_file()
    
    def search(self, keyStudent):
        self.__read_all_from_file()
        return Repo.search(self, keyStudent)
        
    def get_all(self):
        self.__read_all_from_file()
        return Repo.get_all(self)

    def add_grade(self, grade):
        self.__read_all_from_file()
        Repo.add_grade(self, grade)
        self.__write_all_to_file()
        
    def remove(self, entity_key):
        self.__read_all_from_file()
        Repo.remove(self, entity_key)
        self.__write_all_to_file()
        
    def remove_grade_if_student_is_removed(self, student_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_student_is_removed(self, student_key)
        self.__write_all_to_file()
        
    def remove_grade_if_subject_is_removed(self, subject_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_subject_is_removed(self, subject_key)
        self.__write_all_to_file()
    
    def update_student(self, student_key, new_name):
        self.__read_all_from_file()
        Repo.update_student(self, student_key, new_name)
        self.__write_all_to_file()
        
    def update_subject(self, subject_key, new_name):
        self.__read_all_from_file()
        Repo.update_subject(self, subject_key, new_name)
        self.__write_all_to_file()
        
    def remove_grade(self, grade):
        self.__read_all_from_file()
        Repo.remove_grade(self, grade)
        self.__write_all_to_file()


class DBRepo_for_students(Repo):

    def __initialize_db(self):
        pass
    
    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def __init__(self, db_name, read_entity, write_entity):
        Repo.__init__(self)
        self.__db_name = db_name
        self.__read_entity = read_entity
        self.__write_entity = write_entity
        self.__initialize_db()
        
    def __read_all_from_db(self):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        self._entities = []
        mycursor = self.__mydb.cursor()
        mycursor.execute("SELECT * FROM students")
        myresult = mycursor.fetchall()
        for entity in myresult:
            self._entities.append(self.__read_entity(entity))
            
    def __insert_entity_in_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()

        sql = "INSERT INTO students(student_name, student_id) valUES (%s, %s)"
        val = self.__write_entity(entity)
        mycursor.execute(sql, val)

        self.__mydb.commit()
    
    def __remove_entity_from_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()
        sql = "DELETE FROM students WHERE student_id = %s"
        val = self.__write_entity(entity)
        mycursor.execute(sql, (val[1],))
        self.__mydb.commit()
    
    def __update_entity_in_db(self, entity):
        sql = "UPDATE students SET student_name = %s WHERE student_id = %s"
        val = self.__write_entity(entity)
        cursor = self.__mydb.cursor()
        cursor.execute(sql, val)
        self.__mydb.commit()
    
    def add(self, student):
        self.__read_all_from_db()
        Repo.add(self, student)
        self.__insert_entity_in_db(student)

    def remove(self, keyStudent):
        self.__read_all_from_db()
        Repo.remove(self, keyStudent)
        self.__remove_entity_from_db(keyStudent)
    
    def update_student(self, student_key, new_name):
        self.__read_all_from_db()
        Repo.update_student(self, student_key, new_name)
        new_student = Student(student_key.get_student_id(), new_name)
        self.__update_entity_in_db(new_student)
    
    def get_all(self):
        self.__read_all_from_db()
        return Repo.get_all(self)
    
    def search(self, keyStudent):
        self.__read_all_from_db()
        return Repo.search(self, keyStudent)


class DBRepo_for_subjects(Repo):
    
    def __initialize_db(self):
        pass
    
    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def __init__(self, db_name, read_entity, write_entity):
        Repo.__init__(self)
        self.__db_name = db_name
        self.__read_entity = read_entity
        self.__write_entity = write_entity
        self.__initialize_db()
        
    def __read_all_from_db(self):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        self._entities = []
        mycursor = self.__mydb.cursor()
        mycursor.execute("SELECT * FROM subjects")
        myresult = mycursor.fetchall()
        for entity in myresult:
            self._entities.append(self.__read_entity(entity))
            
    def __insert_entity_in_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()

        sql = "INSERT INTO subjects(subject_name,subject_id) valUES (%s, %s)"
        val = self.__write_entity(entity)
        mycursor.execute(sql, val)

        self.__mydb.commit()
    
    def __remove_entity_from_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()
        sql = "DELETE FROM subjects WHERE subject_id = %s"
        val = self.__write_entity(entity)
        mycursor.execute(sql, (val[1],))
        self.__mydb.commit()
    
    def __update_entity_in_db(self, entity):
        sql = "UPDATE subjects SET subject_name = %s WHERE subject_id = %s"
        val = self.__write_entity(entity)
        cursor = self.__mydb.cursor()
        cursor.execute(sql, val)
        self.__mydb.commit()
    
    def add(self, subject):
        self.__read_all_from_db()
        Repo.add(self, subject)
        self.__insert_entity_in_db(subject)

    def remove(self, key_subject):
        self.__read_all_from_db()
        Repo.remove(self, key_subject)
        self.__remove_entity_from_db(key_subject)
    
    def update_subject(self, subject_key, new_name):
        self.__read_all_from_db()
        Repo.update_subject(self, subject_key, new_name)
        new_subject = Subject(subject_key.get_subject_id(), new_name)
        self.__update_entity_in_db(new_subject)
    
    def get_all(self):
        self.__read_all_from_db()
        return Repo.get_all(self)
    
    def search(self, key_subject):
        self.__read_all_from_db()
        return Repo.search(self, key_subject)    


class DBRepo_for_grade(Repo):
    
    def __initialize_db(self):
        pass
    
    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def __init__(self, db_name, read_entity, write_entity):
        Repo.__init__(self)
        self.__db_name = db_name
        self.__read_entity = read_entity
        self.__write_entity = write_entity
        self.__initialize_db()
        
    def __read_all_from_db(self):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        self._entities = []
        mycursor = self.__mydb.cursor()
        mycursor.execute("SELECT * FROM grades")
        myresult = mycursor.fetchall()
        for entity in myresult:
            self._entities.append(self.__read_entity(entity))
            
    def __insert_entity_in_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()

        sql = "INSERT INTO grades(student_id,subject_id, value) valUES (%s, %s, %s)"
        val = self.__write_entity(entity)
        mycursor.execute(sql, val)

        self.__mydb.commit()
    
    def __remove_entity_from_db(self, entity):
        self.__mydb = mysql.connector.connect(
            host="localhost",
            user="root",
            passwd="",
            database="school"
            )
        mycursor = self.__mydb.cursor()
        sql = "DELETE FROM grades WHERE student_id = %s and subject_id = %s"
        val = self.__write_entity(entity)
        mycursor.execute(sql, (val[0], val[1],))
        self.__mydb.commit()
        
    def add_grade(self, grade):
        self.__read_all_from_db()
        Repo.add_grade(self, grade)
        self.__insert_entity_in_db(grade)

    def remove_grade(self, key_grade):
        self.__read_all_from_db()
        Repo.remove_grade(self, key_grade)
        self.__remove_entity_from_db(key_grade)
        
    def get_all(self):
        self.__read_all_from_db()
        return Repo.get_all(self)
    
    def search(self, key_grade):
        self.__read_all_from_db()
        return Repo.search(self, key_grade) 


class Json_repository(Repo):

    def __init__(self, filename, read_entity, write_entity, entity_type):
        Repo.__init__(self)
        self.__entity_type = entity_type    
        self.__filename = filename
        self.__read_entity = read_entity
        self.__write_entity = write_entity
        
    def __read_all_from_file(self):
        self._entities.clear()
        with open(self.__filename, 'r') as file:
            try:
                entities_dictionary = json.load(file)
            except Exception as ex:
                return
        for i in range(len(entities_dictionary[self.__entity_type])):
            entity = self.__read_entity(entities_dictionary[self.__entity_type][i])
            self._entities.append(entity)

    def __write_all_to_file(self):
        entities_dictionary = {self.__entity_type:[]}
        for entity in self._entities:
            entity_dictionary = self.__write_entity(entity)
            entities_dictionary[self.__entity_type].append(entity_dictionary)
        with open(self.__filename, 'w') as file:
            json.dump(entities_dictionary, file)   
            
    def initial_student_entities(self):
        pass
     
    def initial_subject_entities(self):
        pass
    
    def add(self, entity):
        self.__read_all_from_file()
        Repo.add(self, entity)
        self.__write_all_to_file()
    
    def search(self, keyStudent):
        self.__read_all_from_file()
        return Repo.search(self, keyStudent)
        
    def get_all(self):
        self.__read_all_from_file()
        return Repo.get_all(self)

    def add_grade(self, grade):
        self.__read_all_from_file()
        Repo.add_grade(self, grade)
        self.__write_all_to_file()
        
    def remove(self, entity_key):
        self.__read_all_from_file()
        Repo.remove(self, entity_key)
        self.__write_all_to_file()
        
    def remove_grade_if_student_is_removed(self, student_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_student_is_removed(self, student_key)
        self.__write_all_to_file()
        
    def remove_grade_if_subject_is_removed(self, subject_key):
        self.__read_all_from_file()
        Repo.remove_grade_if_subject_is_removed(self, subject_key)
        self.__write_all_to_file()
    
    def update_student(self, student_key, new_name):
        self.__read_all_from_file()
        Repo.update_student(self, student_key, new_name)
        self.__write_all_to_file()
        
    def update_subject(self, subject_key, new_name):
        self.__read_all_from_file()
        Repo.update_subject(self, subject_key, new_name)
        self.__write_all_to_file()
        
    def remove_grade(self, grade):
        self.__read_all_from_file()
        Repo.remove_grade(self, grade)
        self.__write_all_to_file()
