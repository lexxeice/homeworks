require_relative 'student'
require_relative 'mentor'
require_relative 'api'
require 'pry'

api = Api.new # connect to 'github'

alex = Student.new(name: 'Alex', surname: 'Makar') # create student

mentor = Mentor.new(name: '‎Yukihiro', surname: 'Matsumoto') # create mentor

# create homework

homework1_alex = alex.create_homework(source: 'ALEX_CODE', title: 'HW_01')

homework2_alex = alex.create_homework(source: 'ALEX_CODE_02', title: 'HW_02')

alex.connect_to_api(api)

mentor.connect_to_api(api) # connect to github api

mentor.subscribe_to_student(alex) # mentor subscribed to student

alex.submit_homework(homework1_alex) # student submit homework

alex.submit_homework(homework2_alex)

p mentor.notifications # show notifications

mentor.check_homework(homework1_alex) # mentor checks homework

mentor.read_notifications! # read all notifications

p mentor.notifications
