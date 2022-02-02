class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @running = true
  end

  def run
    puts 'Welcome to Food Delivery Livecode APP'
    puts '--------'
    # SIGN IN
    while @running
      @current_user = @sessions_controller.sign_in
      while @current_user
        if @current_user.role == 'manager'
          display_manager_menu
          action = gets.chomp
          print `clear`
          route_manager_action(action)
        else
          display_rider_menu
          action = gets.chomp
          print `clear`
          route_rider_action(action)
        end
      end
    end
  end

  def display_rider_menu
    puts '--------'
    puts '1. List all my undelivered orders'
    puts '2. Mark an order as delivered'
    puts '8. Logout'
    puts '9. Quit'
    print '> '
  end

  def route_rider_action(action)
    case action
    when '1' then puts '#TO-DO: List all undelivered order for the specific employee'
    when '2' then puts '#TO-DO: MARk an order as delivered'
    when '8' then @current_user = nil
    when '9'
      @current_user = nil
      @running = false
    else
      'Type something I know how to deal with'
    end
  end

  def route_manager_action(action)
    case action
    when '1' then @meals_controller.add
    when '2' then @meals_controller.list
    when '3' then @customers_controller.add
    when '4' then @customers_controller.list
    when '8' then @current_user = nil
    when '9'
      @current_user = nil
      @running = false
    end
  end

  def display_manager_menu
    puts '--------'
    puts '1. Add a new meal'
    puts '2. List all meals'
    puts '3. Add a new customer'
    puts '4. List all customers'
    puts '8. Logout'
    puts '9. quit'
    print '> '
  end
end
