require 'json'

class Homework
	attr_accessor :homework_source, :student, :pr_title

	def initialize(homework_source:, student:, pr_title:)
		@homework_source = homework_source
	  @student = student
	  @pr_title = pr_title
	end

	def convert_to_json
		hw_file = {homework_source: @homework_source, student: @student, pr_title: @pr_title}
		File.open('homework.json', 'a') do |file|
      file.write(JSON.pretty_generate(hw_file))
    end
	end
end