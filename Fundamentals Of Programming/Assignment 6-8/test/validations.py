from errors.exceptions import ValidError


class Validator_grade(object):
    """
        function that validates a grade object that has a student_id, a subject_id and a value as instance variables
        input: grade - an object of type Grade
        output: -
        raises: if value <= 0 or value > 10:
                    -> "invalid grade value!\n"
    """

    def validate_grade(self, grade):
        errors = ""
        if grade.get_value() <= 0 or grade.get_value() > 10:
            errors += "invalid grade value!\n"
        if len(errors) > 0:
            raise ValidError(errors)
        

class Validator_student(object):

    def validate_student(self, student):
        """
        function that validates an student object that has an id and name instance variables
        input: student - an object of type Student
        output: -
        raises: if student_id <= 0:
                    -> "invalid id!\n"
                if student_name() == "":
                    -> "invalid name!\n"
        """
        
        errors = ""
        if student.get_student_id() <= 0:
            errors += "invalid id!\n"
        if student.get_student_name() == "":
            errors += "invalid name!\n"
        if len(errors) > 0:
            raise ValidError(errors)


class Validator_subject(object):
    """
        function that validates an subject object that has an id and name instance variables
        input: subject - an object of type Subject
        output: -
        raises: if subject_id <= 0:
                    -> "invalid id!\n"
                if subject_name() == "":
                    -> "invalid name!\n"
    """

    def validate_subject(self, subject):
        errors = ""
        if subject.get_subject_id() <= 0:
            errors += "invalid id!\n"
        if subject.get_subject_name() == "":
            errors += "invalid name!\n"
        if len(errors) > 0:
            raise ValidError(errors)

