require_relative 'human'
require_relative 'homework'
require_relative 'api'
require 'uri'
require 'net/http'
require 'pry'

class Student < Human
	attr_reader :nickname, :connection_status

	def initialize(name:, surname:)
		super
		@nickname = "#{name} #{surname}"
	end

	def create_homework(source:, title:)
		Homework.new(homework_source: source, student: @nickname, pr_title: title)
	end

	def connect_to_api(api)
		api.add_user(self)
		@login = api
		user_connected!(true)
	end

	def submit_homework(homework)
		if homework.owner?(@nickname) && user_connected?
			# Net::HTTP.post URI('http://www.example.com/'),
   #            	 homework.convert_to_json,
   #             	"Content-Type" => "application/json"
      @login.add_homework(homework)
  	end
	end

	private

	def user_connected!(status)
		@connection_status = status
	end

	def user_connected?
		@connection_status ? true : (puts 'User not logged in!')
	end
end