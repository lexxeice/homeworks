require_relative 'student'
require_relative 'mentor'
require_relative 'api'
require 'pry'

api = Api.new()

alex = Student.new(name: 'Alex', surname: 'Makar')

maks = Student.new(name: 'Maks', surname: 'Minsk')

mentor = Mentor.new(name: '‎Yukihiro', surname: 'Matsumoto')

homework_alex_01 = alex.create_homework(source: 'ALEX_CODE', title: 'HW_01')

homework_alex_02 = alex.create_homework(source: 'ALEX_CODE_2', title: 'HW_02')

homework_maks_01 = maks.create_homework(source: 'MAKS_CODE', title: 'HW_01')

homework_maks_02 = maks.create_homework(source: 'MAKS_CODE_2', title: 'HW_02')

alex.submit_homework(homework_alex_01)

alex.connect_to_api(api)

maks.connect_to_api(api)

mentor.connect_to_api(api)

alex.submit_homework(homework_alex_01)

homework_alex_02 = alex.create_homework(source: 'ALEX_CODE_2', title: 'HW_02')

mentor.subscribe_to_student(alex)

mentor.subscribe_to_student(maks)

maks.submit_homework(homework_maks_01)

alex.submit_homework(homework_maks_02)

mentor.check_homework(homework_maks_01)

mentor.check_homework(homework_maks_02)

p mentor.notifications

mentor.read_notifications!

p mentor.notifications





