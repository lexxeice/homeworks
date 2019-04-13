require 'json'
require 'pry'

class Homework
	attr_accessor :homework_source, :student, :pr_title, :check_status

	def initialize(homework_source:, student:, pr_title:)
		@homework_source = homework_source
	  @student = student
	  @pr_title = pr_title
	end

	def convert_to_json
		{homework_source: @homework_source, student: @student, pr_title: @pr_title}.to_json
	end

	def owner?(user)
		true ? self.student.eql?(user) : puts {"No access to this homework!"}
	end

	def add_check_status()
		@check_status = 'No checked'
		self
	end

end
