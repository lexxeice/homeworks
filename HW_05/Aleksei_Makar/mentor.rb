require_relative 'human'
require_relative 'api'
require 'pry'


class Mentor < Human
	attr_accessor :subscriptions, :notifications
	attr_reader :login
	
	def initialize(name:, surname:)
		super
		@subscriptions = []
		@notifications = {}
	end

	def connect_to_api(api)
		api.add_user(self)
		@@login = api
	end

	def subscribe_to_student(student)
		@subscriptions << student if @@login.user_connected?(self)
	end

	def read_notifications!
	end

	def check_homework(homework)
		binding.pry

	end

	def subscribed_to?(student)
		@subscriptions.include?(student)
	end
end