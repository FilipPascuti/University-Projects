# A faculty stores information about:
#     Student: <studentID>, <name>.
#     Discipline: <disciplineID>, <name>.
#     Grade: <disciplineID>, <studentID>, <grade_value>.
# Create an application which allows to:
#     1. Manage the list of students and available disciplines. The application must allow the user to add,
# remove, update, and list both students and disciplines.
#     2. Grade students at a given discipline. Any student may receive one or several grades at any of the
# disciplines. Deleting a student also removes their grades. Deleting a discipline deletes all grades at
# that discipline for all students.
from service.services import Service_student, Service_subject, Service_grade, \
    Service_undo_and_redo
from test.validations import Validator_student, Validator_subject, Validator_grade
from repo.repos import Repo, File_repository, Pickle_repository, \
    DBRepo_for_students, DBRepo_for_subjects, DBRepo_for_grade, Json_repository
from ui.console import Console
from domain.entities import Settings, Student, Subject, Grade


def main():
    
    validator_student = Validator_student()
    validator_subject = Validator_subject()
    validator_grade = Validator_grade()
    
    settings = Settings("settings.properties")
    
    if settings.get_repo_type() == 'inmemory':
        repo_student = Repo()
        repo_subject = Repo()
        repo_grade = Repo()
        
    if settings.get_repo_type() == 'textfile':
        repo_student = File_repository(settings.get_repo_student_filename(), Student.read_student, Student.write_student)
        repo_subject = File_repository(settings.get_repo_subject_filename(), Subject.read_subject, Subject.write_subject)
        repo_grade = File_repository(settings.get_repo_grade_filename(), Grade.read_grade, Grade.write_grade)
     
    if settings.get_repo_type() == 'picklefile':
        repo_student = Pickle_repository(settings.get_repo_student_filename())
        repo_subject = Pickle_repository(settings.get_repo_subject_filename())
        repo_grade = Pickle_repository(settings.get_repo_grade_filename())
    
    if settings.get_repo_type() == "database":
        repo_student = DBRepo_for_students("school", Student.read_student_db, Student.write_student_db)
        repo_subject = DBRepo_for_subjects("school", Subject.read_subject_db, Subject.write_subject_db)
        repo_grade = DBRepo_for_grade("school", Grade.read_grade_db, Grade.write_grade_db)
    
    if settings.get_repo_type() == "jsonfile":
        repo_student = Json_repository(settings.get_repo_student_filename(), Student.read_student_json, Student.write_student_json, "students")
        repo_subject = Json_repository(settings.get_repo_subject_filename(), Subject.read_subject_json, Subject.write_subject_json, "subjects")
        repo_grade = Json_repository(settings.get_repo_grade_filename(), Grade.read_grade_json, Grade.write_grade_json, "grades")
    
    service_undo = Service_undo_and_redo(repo_student, repo_subject, repo_grade)
    
    service_student = Service_student(repo_student, repo_grade, validator_student, service_undo,)
    service_subject = Service_subject(repo_subject, repo_grade, validator_subject, service_undo)
    service_grade = Service_grade(repo_student, repo_subject, repo_grade, validator_grade, service_undo)
    
    console = Console(service_student, service_subject, service_grade, service_undo)
    console.run()
    

main()
