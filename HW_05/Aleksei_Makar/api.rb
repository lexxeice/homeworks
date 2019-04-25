require_relative 'student'
require_relative 'mentor'

# creates a database and describes its behavior
class Api
  attr_reader :users_list, :homework_list

  def initialize
    @users_list = {}
    @homework_list = {}
  end

  def add_user(user)
    @users_list[user] = user.class
  end

  def add_homework(student, homework)
    @homework_list[homework] = 'No checked'
    send_notification(student, homework.pr_title)
  end

  def send_notification(student, title)
    @users_list.each do |user, position|
      if position == Mentor && user.subscribed_to?(student)
        user.notifications["#{student.name} has sent #{title}"] = 'UNREAD'
      end
    end
  end

  def user_connected?(user)
    @users_list.include?(user) ? true : (puts "#{user.name} not logged in!")
  end

  def subscription_possible?(mentor, student)
    user_connected?(mentor) && user_connected?(student)
  end

  def include?(homework)
    homework_list.include?(homework) ? true : (puts 'Homework not detected')
  end

  def entered_result(homework)
    case gets.chomp.upcase
    when 'Y'
      @homework_list[homework] = 'Succeeded'
    when 'N'
      @homework_list[homework] = 'Failed'
    else
      puts 'Wrong input, try again'
      puts 'Succeeded(Y) or Failed(N)? Press Y/N'
      entered_result(homework)
    end
  end
end
