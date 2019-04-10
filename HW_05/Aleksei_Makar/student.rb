require_relative 'human'
require_relative 'homework'
require 'uri'

class Student < Human
	attr_accessor :source, :title;

	def create_homework(source:, title:)
		Homework.new(homework_source: source, student: "#{name} #{surname}", pr_title: title)
	end

	def submit_homework(homework)

	end
end