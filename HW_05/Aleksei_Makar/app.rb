require_relative 'homework'
require_relative 'student'
require_relative 'mentor'

alex = Student.new(name: 'Alex', surname: 'Makar')

homework = alex.create_homework(source: "CODE", title: "GG")

homework.convert_to_json

alex.submit_homework(homework)

# mentor.subscribe_to_student(alex)

# mentor.check_homework(homework)