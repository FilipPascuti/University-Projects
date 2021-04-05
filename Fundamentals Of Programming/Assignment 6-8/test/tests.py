from domain.entities import Student, Subject, Grade
from test.validations import Validator_student, Validator_subject, \
    Validator_grade
from repo.repos import Repo
from errors.exceptions import RepoError
import unittest


class Test_Student(unittest.TestCase):
    
    def test__get_student_id__student__student_id(self):
        student_id = 13
        student_name = "Mike" 
        student = Student(student_id, student_name)
        self.assertEqual(student.get_student_id(), 13)
    
    def test__get_student_name__student__student_name(self):
        student_id = 13
        student_name = "Mike" 
        student = Student(student_id, student_name)
        self.assertEqual(student.get_student_name(), "Mike")

            
class Test_validate_student(unittest.TestCase):
    
    def test__validate_student__invalid_id__Exception(self):
        validator_student = Validator_student()
        student_bad_id = Student(-13, "Mike")
        try:
            validator_student.validate_student(student_bad_id)
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "invalid id!\n")
    
    def test__validate_student__invalid_name__Exception(self):
        validator_student = Validator_student()
        student_bad_name = Student(23, "")
        try:
            validator_student.validate_student(student_bad_name)
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "invalid name!\n")
    
    def test__validate_student__invalid_id_and_name__Exception(self):
        validator_student = Validator_student()
        student_bad = Student(-13, "")
        try:
            validator_student.validate_student(student_bad)
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "invalid id!\ninvalid name!\n") 
    
    def test__validate_student__good_student__no_Exception(self):
        validator_student = Validator_student()
        good_student = Student(23, "John")
        validator_student.validate_student(good_student)

    def test__repo_update_subject__id_new_name__subject_name_changed(self):
        subject = Subject(25, "Math")
        repo_subject = Repo()
        repo_subject.add(subject)
        repo_subject.update_subject(Subject(25, None), "Science")
        self.assertEqual(repo_subject.search(Subject(25, None)), Subject(25, "Science")) 

        
class Test_repo(unittest.TestCase):
    
    def test__repo_add__student__student_at_last_position(self):
        student = Student(23, "John")
        repo_student = Repo()
        repo_student.add(student)
        self.assertEqual(repo_student.get_entities()[0], student)
        
    def test__repo_search__inexisting_student__Exception(self):
        repo_student = Repo()
        key_student = Student(5, None)
        try:
            repo_student.search(key_student)
        except RepoError as re:
            self.assertEqual(str(re), "inexisting id!\n")
        
    def test__repo_search__good_key_student__student(self):
        student = Student(25, "Tonny")
        key_student = Student(25, None)
        repo_student = Repo()
        repo_student.add(student)
        self.assertEqual(repo_student.search(key_student), student)    
        
    def test__repo_add__existing_student__Exception(self):
        student = Student(25, "Tonny")
        repo_student = Repo()
        repo_student.add(student)
        try:
            repo_student.add(student)
            assert False
        except RepoError as re:
            self.assertEqual(str(re), "existing id!\n")
    
    def test__repo_student_remove__element_key__element_not_in_repo(self):
        repo = Repo()
        element_key = Student(13, None)
        self.assertNotIn(element_key, repo.get_entities()) 
    
    def test__repo_update_student__id_new_name__student_name_changed(self):
        student = Student(25, "Tonny")
        repo_student = Repo()
        repo_student.add(student)
        repo_student.update_student(Student(25, None), "Mack")
        self.assertEqual(repo_student.search(Student(25, None)), Student(25, "Mack"))
    
    def test__repo_update_subject__id_new_name__subject_name_changed(self):
        subject = Subject(25, "Math")
        repo_subject = Repo()
        repo_subject.add(subject)
        repo_subject.update_subject(Subject(25, None), "Science")
        self.assertEqual(repo_subject.search(Subject(25, None)), Subject(25, "Science")) 
    
    def test__repo_remove_grade_if_student_is_removed__student_removed__grade_removed(self):
        student = Student(25, "Tonny")
        subject = Subject(25, "Math")
        repo_grade = Repo()
        repo_grade.add(Grade(student, subject, 5))
        repo_grade.remove_grade_if_student_is_removed(Student(25, "Tonny"))
        try:
            repo_grade.search(Grade(Student("25", None), Subject(25, None), None))
            assert False
        except Exception as ex:
            self.assertEqual(str(ex), "inexisting id!\n")
    
    def __repo_remove_grade_if_subject_is_removed__subject_removed__grade_removed(self):
        student = Student(25, "Tonny")
        subject = Subject(25, "Math")
        repo_grade = Repo()
        repo_grade.add(Grade(student, subject, 5))
        repo_grade.remove_grade_if_subject_is_removed(Subject(25, "Math"))
        try:
            repo_grade.search(Grade(Student(25, None), Subject(25, None), None))
            assert False
        except Exception as ex:
            assert str(ex) == "inexisting id!\n"
        
# class Tests(object):
#     
#     def __init__(self):
#         pass
#     
#     def __get_student_id__student__student_id(self):
#         student_id = 13
#         student_name = "Mike" 
#         student = Student(student_id, student_name)
#         assert(student.get_student_id() == 13)
#         
#     def __get_student_name__student__student_name(self):
#         student_id = 13
#         student_name = "Mike" 
#         student = Student(student_id, student_name)
#         assert(student.get_student_name() == "Mike")
#         
#     def __validate_student__invalid_id__Exception(self):
#         validator_student = Validator_student()
#         student_bad_id = Student(-13, "Mike")
#         try:
#             validator_student.validate_student(student_bad_id)
#             assert False
#         except Exception as ex:
#             assert(str(ex) == "invalid id!\n")
#     
#     def __validate_student__invalid_name__Exception(self):
#         validator_student = Validator_student()
#         student_bad_name = Student(23, "")
#         try:
#             validator_student.validate_student(student_bad_name)
#             assert False
#         except Exception as ex:
#             assert str(ex) == "invalid name!\n"
#     
#     def __validate_student__invalid_id_and_name__Exception(self):
#         validator_student = Validator_student()
#         student_bad = Student(-13, "")
#         try:
#             validator_student.validate_student(student_bad)
#             assert False
#         except Exception as ex:
#             assert str(ex) == "invalid id!\ninvalid name!\n"
#     
#     def __validate_student__good_student__no_Exception(self):
#         validator_student = Validator_student()
#         good_student = Student(23, "John")
#         validator_student.validate_student(good_student)
#         
#     def __repo_add__student__student_at_last_position(self):
#         student = Student(23, "John")
#         repo_student = Repo()
#         repo_student.add(student)
#         assert(repo_student.get_entities()[0] == student)
#         
#     def __repo_search__inexisting_student__Exception(self):
#         repo_student = Repo()
#         key_student = Student(5, None)
#         try:
#             repo_student.search(key_student)
#         except RepoError as re:
#             assert(str(re) == "inexisting id!\n")
#         
#     def __repo_search__good_key_student__student(self):
#         student = Student(25, "Tonny")
#         key_student = Student(25, None)
#         repo_student = Repo()
#         repo_student.add(student)
#         assert(repo_student.search(key_student) == student)    
#         
#     def __repo_add__existing_student__Exception(self):
#         student = Student(25, "Tonny")
#         repo_student = Repo()
#         repo_student.add(student)
#         try:
#             repo_student.add(student)
#             assert False
#         except RepoError as re:
#             assert(str(re) == "existing id!\n")
#     
#     def __repo_student_remove__element_key__element_not_in_repo(self):
#         repo = Repo()
#         element_key = Student(13, None)
#         assert element_key not in repo.get_entities()
#     
#     def __repo_update_student__id_new_name__student_name_changed(self):
#         student = Student(25, "Tonny")
#         repo_student = Repo()
#         repo_student.add(student)
#         repo_student.update_student(Student(25, None), "Mack")
#         assert repo_student.search(Student(25, None)) == Student(25, "Mack")
#     
#     def __repo_update_subject__id_new_name__subject_name_changed(self):
#         subject = Subject(25, "Math")
#         repo_subject = Repo()
#         repo_subject.add(subject)
#         repo_subject.update_subject(Subject(25, None), "Science")
#         assert repo_subject.search(Subject(25, None)) == Subject(25, "Science")
#     
#     def __get_subject_id__subject__subject_id(self):
#         subject_id = 13
#         subject_name = "Math" 
#         subject = Subject(subject_id, subject_name)
#         assert(subject.get_subject_id() == 13)
#         
#     def __get_subject_name__subject__subject_name(self):
#         subject_id = 13
#         subject_name = "Math" 
#         subject = Subject(subject_id, subject_name)
#         assert(subject.get_subject_name() == "Math")
#         
#     def __validate_subject__invalid_id__Exception(self):
#         validator_subject = Validator_subject()
#         subject_bad_id = Subject(-13, "Math")
#         try:
#             validator_subject.validate_subject(subject_bad_id)
#             assert False
#         except Exception as ex:
#             assert(str(ex) == "invalid id!\n")
#     
#     def __validate_subject__invalid_name__Exception(self):
#         validator_subject = Validator_subject()
#         subject_bad_name = Subject(23, "")
#         try:
#             validator_subject.validate_subject(subject_bad_name)
#             assert False
#         except Exception as ex:
#             assert str(ex) == "invalid name!\n"
#     
#     def __validate_subject__invalid_id_and_name__Exception(self):
#         validator_subject = Validator_subject()
#         subject_bad = Subject(-13, "")
#         try:
#             validator_subject.validate_subject(subject_bad)
#             assert False
#         except Exception as ex:
#             assert str(ex) == "invalid id!\ninvalid name!\n"
#     
#     def __validate_subject__good_subject__no_Exception(self):
#         validator_subject = Validator_subject()
#         good_subject = Subject(23, "John")
#         validator_subject.validate_subject(good_subject)
#         
#     def __repo_add__subject__subject_at_last_position(self):
#         subject = Subject(23, "John")
#         repo_subject = Repo()
#         repo_subject.add(subject)
#         assert(repo_subject.get_entities()[0] == subject)
#         
#     def __repo_search__inexisting_subject__Exception(self):
#         repo_subject = Repo()
#         key_subject = Subject(5, None)
#         try:
#             repo_subject.search(key_subject)
#         except RepoError as re:
#             assert(str(re) == "inexisting id!\n")
#         
#     def __repo_search__good_key_subject__subject(self):
#         subject = Subject(25, "Math")
#         key_subject = subject(25, None)
#         repo_subject = Repo()
#         repo_subject.add(subject)
#         assert(repo_subject.search(key_subject) == subject)    
#         
#     def __repo_add__existing_subject__Exception(self):
#         subject = Subject(25, "Math")
#         repo_subject = Repo()
#         repo_subject.add(subject)
#         try:
#             repo_subject.add(subject)
#             assert False
#         except RepoError as re:
#             assert(str(re) == "existing id!\n")
#     
#     def __repo_subject_remove__element_key__element_not_in_repo(self):
#         repo = Repo()
#         element_key = Subject(13, None)
#         assert element_key not in repo.get_entities()
#     
#     def __repo_add__grade__grade_at_last_position(self):
#         grade = Grade(Student(25, None), Subject(24, None), 7)
#         repo_grade = Repo()
#         repo_grade.add(grade)
#         assert(repo_grade.get_entities()[0] == grade)
#         
#     def __repo_search__inexisting_grade__Exception(self):
#         repo_grade = Repo()
#         key_grade = Grade(Student(25, None), Subject(24, None), None)
#         try:
#             repo_grade.search(key_grade)
#         except RepoError as re:
#             assert(str(re) == "inexisting id!\n")
#         
#     def __repo_search__good_key_grade__grade(self):
#         grade = Grade(Student(25, None), Subject(24, None), 7)
#         key_grade = Grade(Student(25, None), Subject(24, None), None)
#         repo_grade = Repo()
#         repo_grade.add(grade)
#         assert(repo_grade.search(key_grade) == grade)    
#         
#     def __repo_add__existing_grade__Exception(self):
#         grade = Grade(Student(25, None), Subject(24, None), 7)
#         repo_grade = Repo()
#         repo_grade.add(grade)
#         try:
#             repo_grade.add(grade)
#             assert False
#         except RepoError as re:
#             assert(str(re) == "existing id!\n")
#             
#     def __validate_grade__invalid_value__Exception(self):
#         validator_grade = Validator_grade()
#         grade_bad_value = Grade(Student(25, None), Subject(23, None), 11)
#         try:
#             validator_grade.validate_grade(grade_bad_value)
#             assert False
#         except Exception as ex:
#             assert str(ex) == "invalid grade value!\n"
# 
#     def __repo_remove_grade_if_student_is_removed__student_removed__grade_removed(self):
#         student = Student(25, "Tonny")
#         subject = Subject(25, "Math")
#         repo_grade = Repo()
#         repo_grade.add(Grade(student, subject, 5))
#         repo_grade.remove_grade_if_student_is_removed(Student(25, "Tonny"))
#         try:
#             repo_grade.search(Grade(Student("25", None), Subject(25, None), None))
#             assert False
#         except Exception as ex:
#             assert str(ex) == "inexisting id!\n"
#     
#     def __repo_remove_grade_if_subject_is_removed__subject_removed__grade_removed(self):
#         student = Student(25, "Tonny")
#         subject = Subject(25, "Math")
#         repo_grade = Repo()
#         repo_grade.add(Grade(student, subject, 5))
#         repo_grade.remove_grade_if_subject_is_removed(Subject(25, "Math"))
#         try:
#             repo_grade.search(Grade(Student(25, None), Subject(25, None), None))
#             assert False
#         except Exception as ex:
#             assert str(ex) == "inexisting id!\n"
#                 
#     def run_all_tests(self):
#         self.__get_student_id__student__student_id()
#         self.__get_student_name__student__student_name()
#         self.__validate_student__good_student__no_Exception()
#         self.__validate_student__invalid_id__Exception()
#         self.__validate_student__invalid_id_and_name__Exception()
#         self.__validate_student__invalid_name__Exception()
#         self.__repo_add__student__student_at_last_position()
#         self.__repo_search__inexisting_student__Exception()
#         self.__repo_search__good_key_student__student()
#         self.__repo_add__existing_student__Exception()
#         self.__repo_student_remove__element_key__element_not_in_repo()
#         self.__repo_update_student__id_new_name__student_name_changed()
#         
#         self.__get_student_id__student__student_id()
#         self.__get_student_name__student__student_name()
#         self.__validate_student__good_student__no_Exception()
#         self.__validate_student__invalid_id__Exception()
#         self.__validate_student__invalid_id_and_name__Exception()
#         self.__validate_student__invalid_name__Exception()
#         self.__repo_add__student__student_at_last_position()
#         self.__repo_search__inexisting_student__Exception()
#         self.__repo_search__good_key_student__student()
#         self.__repo_add__existing_student__Exception()
#         self.__repo_student_remove__element_key__element_not_in_repo()
#         self.__repo_update_student__id_new_name__student_name_changed()
#         self.__repo_update_subject__id_new_name__subject_name_changed()
#         
#         self.__repo_add__grade__grade_at_last_position()
#         self.__repo_search__inexisting_grade__Exception()
#         self.__repo_search__good_key_grade__grade()
#         self.__repo_add__existing_grade__Exception()
#         self.__validate_grade__invalid_value__Exception()
#         
#         self.__repo_remove_grade_if_student_is_removed__student_removed__grade_removed()
#         self.__repo_remove_grade_if_subject_is_removed__subject_removed__grade_removed()
