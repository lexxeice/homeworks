require_relative 'mentor'
require_relative 'student'
require 'pry'


class Api
	attr_accessor :check_status, :homework_list, :users_list

	def initialize()
		@users_list = []
		@homework_list = []
	end

	def add_user(user)
		@users_list << user unless user_connected?(user)
	end

	def user_connected?(user)
		@users_list.include?(user)
	end

	def add_homework(homework)
		@homework_list << homework
		send_notification!()
	end

	def send_notification!()
		
	end

end