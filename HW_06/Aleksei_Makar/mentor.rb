require_relative 'human'
require_relative 'authorization'

# creates a mentor and describes his behavior
class Mentor < Human
  attr_reader :subscriptions, :notifications

  include Authorization

  def initialize(name)
    super
    @notifications = {}
    @subscriptions = []
  end

  def subscribe_to(student, api)
    @subscriptions << student if api.subscription_possible?(self, student)
  end

  def subscribed_to?(student)
    @subscriptions.include?(student)
  end

  def read_notifications!
    @notifications.each do |message, _status|
      @notifications[message] = 'READ'
    end
  end

  def check(homework, api)
    student = homework.student
    if api.include?(homework) && subscribed_to?(student)
      puts "Succeeded or Failed #{student.name} #{homework.pr_title}? Press Y/N"
      api.entered_result(homework)
      return (puts 'DONE!')
    end
    puts "You can't check this homework!"
  end
end
