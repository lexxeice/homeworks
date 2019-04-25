require_relative 'human'
require_relative 'authorization'
require_relative 'homework'
require_relative 'api'
require 'uri'
require 'net/http'

# creates a student and describes his behavior
class Student < Human
  include Authorization

  def create_homework(source:, title:)
    Homework.new(homework_source: source, student: self, pr_title: title)
  end

  def submit_homework(homework, api)
    title = homework.pr_title
    if homework.owner?(self) && api.user_connected?(self)
      Net::HTTP.post URI('http://www.example.com/'),
                     homework.json,
                     'Content-Type' => 'application/json'
      api.add_homework(self, homework)
      return puts "#{name} successfully sent #{title}"
    end
    puts "#{name} could not send #{title}"
  end
end
