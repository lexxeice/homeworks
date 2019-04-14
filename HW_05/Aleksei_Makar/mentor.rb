require_relative 'human'
require_relative 'api'
require 'pry'


class Mentor < Human
	attr_accessor :subscriptions, :notifications
	attr_reader :connection_status
	
	def initialize(name:, surname:)
		super
		@subscriptions = []
		@notifications = {}
	end

	def connect_to_api(api)
		api.add_user(self)
		@login = api
		user_connected!(true)

	end

	def subscribe_to_student(student)
		@subscriptions << student.nickname if user_connected?
	end

	def read_notifications!
		@notifications.each do |message, status|
			@notifications[message] = 'READ'
		end
	end

	def check_homework(homework)
		if subscribed_to?(homework.student) && @login.include?(homework)
			puts "Succeeded(Y) or Failed(N) #{homework.pr_title}, the creator #{homework.student}? Press Y/N"
			if entered_result(gets.chomp.upcase) 
				(homework.check_status = 'Succeeded') 
			else
				 (homework.check_status = 'Failed' )
			end
			puts 'DONE!'
		end
	end

	def subscribed_to?(student)
		@subscriptions.include?(student) ? true : (puts 'You are not subscribed to this student')
	end

	private

		def user_connected!(status)
			@connection_status = status
		end

		def user_connected?
			@connection_status ? true : (puts 'User not logged in!')
		end

		def entered_result(value)
			if value == 'Y'
				return true 
			elsif value == 'N'
				# binding.pry
				return false
			else
				puts 'Wrong input, try again'
				puts 'Succeeded(Y) or Failed(N) homework? Press Y/N'
				entered_result(gets.chomp.upcase)
			end
		end
end