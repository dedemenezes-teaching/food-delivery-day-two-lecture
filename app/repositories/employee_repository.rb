require_relative 'base_repository'
require_relative '../models/employee'

class EmployeeRepository < BaseRepository
  def initialize(csv_file_path)
    super(csv_file_path, Employee)
  end

  def find_by_username(username)
    @elements.find { |employee| employee.username == username }
  end
end
