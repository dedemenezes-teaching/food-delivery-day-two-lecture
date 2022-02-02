class SessionView
  def ask_for(item)
    puts "#{item.capitalize}?"
    gets.chomp
  end

  def wrong_credentials
    puts "Wrong credentials...Try again!"
  end

  def signed_in_successfully(employee)
    puts "WELCOME, #{employee.username}!"
  end
end
