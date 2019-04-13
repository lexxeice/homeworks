require_relative 'mentor'
require_relative 'student'
# require_relative 'homework'
require 'pry'


class Api
	attr_accessor :check_status, :homework_list, :users_list

	def initialize()
		@users_list = {}
		@homework_list = []
	end

	def add_user(user)
		@users_list[user] = user.class unless user_connected?(user)
	end

	def user_connected?(user)
		true ? @users_list.include?(user) : puts {'User not logged in!'}
	end

	def add_homework(homework)
		@homework_list << homework.add_check_status()
		check_subscriptions(homework.student, homework.pr_title)
	end

	def check_subscriptions(student, homework_name)
		@users_list.each do |user_data, position|
			# binding.pry
			if position == Mentor
				send_notification(user_data, student, homework_name) if user_date.subscribed_to?(student)	
			end
		end
	end

	def send_notification(mentor, student, homework_name)
		mentor.notifications["Student #{student.name} #{student.surname} has sent #{homework_name}"] = 'UNREAD'
	end

end