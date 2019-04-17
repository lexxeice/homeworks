require_relative 'human'
require_relative 'api'
require_relative 'authorization'

# creates a mentor and describes his behavior
class Mentor < Human
  include Authorization
  attr_accessor :subscriptions, :notifications

  def initialize(name:, surname:)
    super
    @subscriptions = []
    @notifications = {}
  end

  def subscribe_to_student(student)
    @subscriptions << student.nickname if user_connected?
  end

  def read_notifications!
    @notifications.each do |message, _status|
      @notifications[message] = 'READ'
    end
  end

  def check_homework(homew)
    if subscribed_to?(homew.student) && @login.include?(homew)
      puts "Succeeded or Failed #{homew.student} #{homew.pr_title}? Press Y/N"
      if entered_result(gets.chomp.upcase)
        (homew.check_status = 'Succeeded')
      else
        (homew.check_status = 'Failed')
      end
      return (puts 'DONE!')
    end
    puts "You can't check this homework #{homew.pr_title}"
  end

  def subscribed_to?(student)
    @subscriptions.include?(student) ? true : (puts 'You are not subscribed')
  end

  private

  def entered_result(value)
    if value == 'Y'
      true
    elsif value == 'N'
      false
    else
      puts 'Wrong input, try again'
      puts 'Succeeded(Y) or Failed(N)? Press Y/N'
      entered_result(gets.chomp.upcase)
    end
  end
end
