require_relative 'student'
require_relative 'mentor'
require_relative 'api'

api = Api.new # create GitHub

student_alex = Student.new('Alex Makar')

mentor_petrov = Mentor.new('Petr Petrov')

hmwk_01_alex = student_alex.create_homework(source: 'Code_01', title: 'HW_01')

hmwk_02_alex = student_alex.create_homework(source: 'Code_02', title: 'HW_02')

student_alex.submit_homework(hmwk_01_alex, api)

student_alex.connect_to(api)

mentor_petrov.connect_to(api)

student_alex.submit_homework(hmwk_01_alex, api)

mentor_petrov.subscribe_to(student_alex, api)

student_alex.submit_homework(hmwk_02_alex, api)

p mentor_petrov.notifications

mentor_petrov.read_notifications!

p mentor_petrov.notifications

mentor_petrov.check(hmwk_01_alex, api)
