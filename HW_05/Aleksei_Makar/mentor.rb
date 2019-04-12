require_relative 'human'
require_relative 'api'
require 'pry'


class Mentor < Human
	attr_accessor :subscriptions, :notifications
	attr_reader :login
	
	def initialize(name:, surname:)
		super
		@subscriptions = []
		@notifications = []
	end

	def connect_to_api(api)
		@@login = api.add_user(self)
	end

	# def check_homework(homework)
	# end

	def subscribe_to_student(student)
		@subscriptions << student
	end

	# def notifications
	# end

	# def read_notifications!
	# end
end