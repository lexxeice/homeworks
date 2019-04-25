require 'json'

# creates a homework and describes his behavior
class Homework
  attr_reader :source, :student, :pr_title

  def initialize(homework_source:, student:, pr_title:)
    @source = homework_source
    @student = student
    @pr_title = pr_title
  end

  def json
    { source: @source, student: @student.name, pr_title: @pr_title }.to_json
  end

  def owner?(user)
    student.eql?(user) ? true : (puts "#{user.name} doesn't have access!")
  end
end
