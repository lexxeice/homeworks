require_relative 'human'
require_relative 'api'
require_relative 'authorization'

# creates a mentor and describes his behavior
class Mentor < Human
  include Authorization
  attr_reader :subscriptions, :notifications

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

  def check_homework(hmwk)
    if subscribed_to?(hmwk.student) && @login.include?(hmwk)
      puts "Succeeded or Failed #{hmwk.student} #{hmwk.pr_title}? Press Y/N"
      entered_result(hmwk)
      return (puts 'DONE!')
    end
    puts "You can't check this homework #{hmwk.pr_title}"
  end

  def subscribed_to?(student)
    @subscriptions.include?(student) ? true : (puts 'You are not subscribed')
  end

  private

  def entered_result(hmwk)
    case gets.chomp.upcase
    when 'Y'
      hmwk.check_status = 'Succeeded'
    when 'N'
      hmwk.check_status = 'Failed'
    else
      puts 'Wrong input, try again'
      puts 'Succeeded(Y) or Failed(N)? Press Y/N'
      entered_result(hmwk)
    end
  end
end
