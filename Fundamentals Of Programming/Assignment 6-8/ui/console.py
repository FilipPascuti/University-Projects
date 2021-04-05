from errors.exceptions import ValidError, RepoError


class Console(object):
    
    def __init__(self, service_student, service_subject, service_grade, service_undo):
        self.__service_student = service_student
        self.__service_subject = service_subject
        self.__service_grade = service_grade
        self.__service_undo = service_undo

    def __print_menu(self):
        print(
            """First functionality:
            1. Add student
            2. Remove student
            3. Update student
            4. List students
            5. Add subjects
            6. Remove subjects
            7. Update subjects
            8. List subjects
            9. Add a grade
            10. Print the grades
            11. Search for a student or a discipline
            12. Do statistics
            13. Undo last operation
            """
            ) 
    
    def read_numerical(self, message, function):
        number = input(message)
        while True:
            try:
                number = function(number)
                return number
            except Exception as ex:
                print("invalid numerical value!")
                number = input(message)

    def __ui_add_student(self):
        student_id = self.read_numerical("insert student id:", int)
        student_name = input("insert student name:")
        self.__service_student.add_student(student_id, student_name)
        
    def __ui_remove_student(self):
        student_id = self.read_numerical("insert student id:", int)
        self.__service_student.remove(student_id)
        self.__service_grade.remove_grade_if_student_is_removed(student_id)
    
    def __ui_update_student(self):
        student_id = self.read_numerical("insert student id:", int)
        new_name = input("insert new name")
        self.__service_student.update_student(student_id, new_name)
    
    def __ui_list_students(self):
        students = self.__service_student.get_students()
        for student in students:
            print(student)
    
    def __ui_add_subject(self):
        subject_id = self.read_numerical("insert subject id:", int)
        subject_name = input("insert subject name:")
        self.__service_subject.add_subject(subject_id, subject_name)
    
    def __ui_remove_subject(self):
        subject_id = self.read_numerical("insert subject id:", int)
        self.__service_subject.remove(subject_id)
        self.__service_grade.remove_grade_if_subject_is_removed(subject_id)
        
    def __ui_update_subject(self):
        subject_id = self.read_numerical("insert subject id:", int)
        new_name = input("insert new name")
        self.__service_subject.update_subject(subject_id, new_name)
    
    def __ui_list_subjects(self):
        subjects = self.__service_subject.get_subjects()
        for subject in subjects:
            print(subject)

    def __ui_add_grade(self):
        student_id = self.read_numerical("insert student id:", int)
        subject_id = self.read_numerical("insert subject id:", int)
        value = self.read_numerical("insert the grade: ", float)
        self.__service_grade.add_grade(student_id, subject_id, value)
    
    def __ui_print_grades(self):
        grades = self.__service_grade.get_grades()
        for grade in grades:
            print(grade)

    def __ui_search_student_using_id(self):
        student_id = self.read_numerical("insert student id:", int)
        print(self.__service_student.search_student_with_id(student_id))
        
    def __ui_search_student_using_name(self):
        student_name = input("insert student name:\n")
        students_found = self.__service_student.search_student_with_name(student_name)
        for student in students_found:
            print(student)
        
    def __ui_search_subject_using_id(self):
        subject_id = self.read_numerical("insert subject id:", int)
        print(self.__service_subject.search_subject_with_id(subject_id))
    
    def __ui_search_subject_using_name(self):
        subject_name = input("insert subject name:\n")
        subjects_found = self.__service_subject.search_subject_with_name(subject_name)
        for subject in subjects_found:
            print(subject)
    
    def __print_search_menu(self):
        print(
            """
                1. Search student using the id
                2. Search student using the name
                3. Search discipline using the id
                4. Search discipline using the name
            """
            )
        
    def __ui_search(self):
        self.__print_search_menu()
        commands = {
            "1": self.__ui_search_student_using_id,
            "2": self.__ui_search_student_using_name,
            "3": self.__ui_search_subject_using_id,
            "4": self.__ui_search_subject_using_name,
            }
        while True:
            command = input(">>>")
            if command == 'x':
                return
            elif command in commands:
                try:
                    commands[command]()
                except ValueError as ve:
                    print("Ui Error:\n" + str(ve))
                except ValidError as valer:
                    print("Validation Error:\n" + str(valer))
                except RepoError as re:
                    print("Repo Error:\n" + str(re))
            else:
                print("invalid command!")

    def __print_statistics_menu(self):
        print(
            """
                1. All students failing at one or more disciplines (students having an average <5 for 
                    a discipline are considered to be failing)
                2. Students with the best school situation, sorted in descending order of their 
                    aggregated average (the average between their average grades per discipline).
                3. All disciplines at which there is at least one grade, sorted in descending order of 
                    the average grade received by all students enrolled at that discipline.    
            """
            )

    def __ui_statistics_failing_students(self):
        students_found = self.__service_grade.statistics_failing_students()
        for student in students_found:
            print(student)
    
    def __ui_statistics_best_students(self):
        students_with_averages = self.__service_grade.statistics_best_students()
        for student_with_average in students_with_averages:
            print("The student with id ", student_with_average)
    
    def __ui_statistics_subjects(self):
        subjects_with_averages = self.__service_grade.statistics_subjects()
        for subject_with_average in subjects_with_averages:
            print("The discipline with id ", subject_with_average)
        
    def __ui_statistics(self):
        self.__print_statistics_menu()
        commands = {
            "1": self.__ui_statistics_failing_students,
            "2": self.__ui_statistics_best_students,
            "3": self.__ui_statistics_subjects
            }
        while True:
            command = input(">>>")
            if command == 'x':
                return
            elif command in commands:
                try:
                    commands[command]()
                except ValueError as ve:
                    print("Ui Error:\n" + str(ve))
                except ValidError as valer:
                    print("Validation Error:\n" + str(valer))
                except RepoError as re:
                    print("Repo Error:\n" + str(re))
            else:
                print("invalid command!")

    def __ui_undo(self):
        self.__service_undo.undo()

    def __ui_redo(self):
        self.__service_undo.redo()
    
    def run(self):
        self.__service_student.initiate_students()
        self.__service_subject.initiate_subjects()
        self.__print_menu()
        commands_dictionary = {
            "1": self.__ui_add_student,
            "2": self.__ui_remove_student,
            "3": self.__ui_update_student,
            "4": self.__ui_list_students,
            "5": self.__ui_add_subject,
            "6": self.__ui_remove_subject,
            "7": self.__ui_update_subject,
            "8": self.__ui_list_subjects,
            "9": self.__ui_add_grade,
            "10": self.__ui_print_grades,
            "11": self.__ui_search,
            "12": self.__ui_statistics,
            "13": self.__ui_undo,
            "14": self.__ui_redo
            }
        while True:
            command = input(">>>")
            if command == 'x':
                return
            elif command in commands_dictionary:
                try:
                    commands_dictionary[command]()
#                 except ValueError as ve:
#                     print("Ui Error:\n" + str(ve))
                except ValidError as valer:
                    print("Validation Error:\n" + str(valer))
                except RepoError as re:
                    print("Repo Error:\n" + str(re))
            else:
                print("invalid command!")
