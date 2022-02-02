require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  def sign_in
    # 1. Ask for the username
    username = @session_view.ask_for(:username)
    # 2. Ask for the password
    password = @session_view.ask_for(:password)
    # 3. compare the username provided with the username in the DB
    current_user = @employee_repository.find_by_username(username)
    # current_user variable is an instance of Employee
    # Two scenarios
    if current_user && current_user.password == password
      @session_view.signed_in_successfully(current_user)
      return current_user
    else
      # 1. Tel the user he sent us some wrong credentials
      @session_view.wrong_credentials
      # 2. TRY AGAIN!
      sign_in # => Recursive call
    end
  end
end
