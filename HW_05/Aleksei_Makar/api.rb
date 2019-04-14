require_relative 'mentor'
require_relative 'student'

# creates a database and describes its behavior
class Api
  attr_accessor :check_status, :homework_list, :users_list

  def initialize
    @users_list = {}
    @homework_list = []
  end

  def add_user(user)
    if user.class == Mentor
      @users_list[user] = user.class
    else
      @users_list[user.nickname] = user.class
    end
  end

  def add_homework(homework)
    @homework_list << homework.add_check_status
    check_subscriptions(homework.student, homework.pr_title)
  end

  def check_subscriptions(student, title)
    @users_list.each do |user, position|
      if position == Mentor
        send_notification(user, student, title) if user.subscribed_to?(student)
      end
    end
  end

  def send_notification(mentor, student, title)
    mentor.notifications["Student #{student} has sent #{title}"] = 'UNREAD'
  end

  def include?(homework)
    homework_list.include?(homework) ? true : (puts 'Homework not detected')
  end
end
