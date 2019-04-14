require_relative 'mentor'
require_relative 'student'
# require_relative 'homework'
require 'pry'


class Api
	attr_accessor :check_status, :homework_list, :users_list

	def initialize
		@users_list = {}
		@homework_list = []
	end

	def add_user(user)
		if user.class == Mentor
			@users_list[user] = user.class
		else
			@users_list[user.nickname] = user.class
		end
	end

	def add_homework(homework)
		@homework_list << homework.add_check_status
		check_subscriptions(homework.student, homework.pr_title)
	end

	def check_subscriptions(student, homework_title)
		@users_list.each do |user_data, position|
			if position == Mentor
				# binding.pry
				send_notification(user_data, student, homework_title) if user_data.subscribed_to?(student)	
			end
		end
	end

	def send_notification(mentor, student, homework_title)
		mentor.notifications["Student #{student} has sent #{homework_title}"] = 'UNREAD'
	end

	def include?(homework)
		homework_list.include?(homework) ? true : (puts 'Homework not detected')
	end

end