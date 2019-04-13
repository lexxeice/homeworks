require_relative 'human'
require_relative 'homework'
require_relative 'api'
require 'uri'
require 'net/http'
require 'pry'

class Student < Human
	attr_reader :login

	def create_homework(source:, title:)
		Homework.new(homework_source: source, student: self, pr_title: title) #self?
	end

	def connect_to_api(api)
		api.add_user(self)
		@@login = api
	end

	def submit_homework(homework)
		if homework.owner?(self) && @@login.user_connected?(self)
			# Net::HTTP.post URI('http://www.example.com/'),
   #            	 homework.convert_to_json,
   #             	"Content-Type" => "application/json"
      @@login.add_homework(homework)
  	end
	end
end