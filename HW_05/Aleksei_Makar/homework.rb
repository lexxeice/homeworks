require 'json'
require 'pry'

# creates a homework and describes his behavior
class Homework
  attr_reader :homework_source, :student, :pr_title
  attr_accessor :check_status

  def initialize(homework_source:, student:, pr_title:)
    @homework_source = homework_source
    @student = student
    @pr_title = pr_title
  end

  def json
    { source: @homework_source, student: @student, pr_title: @pr_title }.to_json
  end

  def owner?(user)
    student.eql?(user) ? true : (puts 'No access to this homework!')
  end

  def add_check_status
    @check_status = 'No checked'
    self
  end
end
