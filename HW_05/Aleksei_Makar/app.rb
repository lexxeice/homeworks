require_relative 'student'
require_relative 'mentor'
require_relative 'api'
require 'pry'

api = Api.new

alex = Student.new(name: 'Alex', surname: 'Makar')

mentor = Mentor.new(name: '‎Yukihiro', surname: 'Matsumoto')

homework1_alex = alex.create_homework(source: 'ALEX_CODE', title: 'HW_01')

homework2_alex = alex.create_homework(source: 'ALEX_CODE_02', title: 'HW_02')

alex.connect_to_api(api)

mentor.connect_to_api(api)

mentor.subscribe_to_student(alex)

alex.submit_homework(homework1_alex)

alex.submit_homework(homework2_alex)

p mentor.notifications

mentor.check_homework(homework1_alex)

mentor.read_notifications!

p mentor.notifications
