require_relative 'student'
require_relative 'mentor'
require_relative 'api'
require 'pry'


alex = Student.new(name: 'Alex', surname: 'Makar')

maks = Student.new(name: 'Maks', surname: 'Minsk')

mentor = Mentor.new(name: '‎Yukihiro', surname: 'Matsumoto')

api = Api.new()

homework_alex_01 = alex.create_homework(source: 'ALEX_CODE', title: 'HW_01')

homework_alex_02 = alex.create_homework(source: 'ALEX_CODE_2', title: 'HW_02')

homework_maks_01 = maks.create_homework(source: 'MAKS_CODE', title: 'HW_01')

homework_maks_02 = maks.create_homework(source: 'MAKS_CODE_2', title: 'HW_02')

alex.connect_to_api(api)

maks.connect_to_api(api)

mentor.connect_to_api(api)

alex.submit_homework(homework_alex_01)

mentor.subscribe_to_student(alex)

mentor.subscribe_to_student(maks)

maks.submit_homework(homework_maks_01)

# alex.submit_homework(homework_maks_02)

# mentor.notifications

# mentor.check_homework(homework)