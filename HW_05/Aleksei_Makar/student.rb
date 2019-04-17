require_relative 'human'
require_relative 'homework'
require_relative 'api'
require_relative 'authorization'
require 'uri'
require 'net/http'

# creates a student and describes his behavior
class Student < Human
  include Authorization
  attr_reader :nickname

  def initialize(name:, surname:)
    super
    @nickname = "#{name} #{surname}"
  end

  def create_homework(source:, title:)
    Homework.new(homework_source: source, student: @nickname, pr_title: title)
  end

  def submit_homework(homework)
    if homework.owner?(@nickname) && user_connected?
      Net::HTTP.post URI('http://www.example.com/'),
                     homework.json,
                     'Content-Type' => 'application/json'
      @login.add_homework(homework)
      return (puts "#{@nickname} successfully sent #{homework.pr_title}")
    end
    puts "#{@nickname} can not send #{homework.pr_title}"
  end
end
