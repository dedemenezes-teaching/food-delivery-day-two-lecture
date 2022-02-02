require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/session_view'
require_relative '../models/order'
require_relative '../views/order_view'


class OrdersController
  def initialize(meal_repo, customer_repo, employee_repo, order_repo)
    @meal_repo = meal_repo
    @customer_repo = customer_repo
    @employee_repo = employee_repo
    @order_repo = order_repo
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @session_view = SessionView.new
    @order_view = OrderView.new
  end

  def add
    # MEAL SITUATION
    # 1. fetch all meals from my meal repository
    meals = @meal_repo.all
    # Display all meals
    @meal_view.display(meals)
    # Ask for the meal in the list
    index = @meal_view.ask_for(:index).to_i - 1
    # store this meal to create my order
    meal = meals[index]

    # CUSTOMER SITUATION
    customers = @customer_repo.all
    # Display all customers
    @customer_view.display(customers)
    # Ask for the customer in the list
    index = @customer_view.ask_for(:index).to_i - 1
    # store this customer to create my order
    customer = customers[index]

    # EMPLOYEE SITUATION
    employees = @employee_repo.all_riders
    # Display all riders
    @session_view.display(employees)
    # Ask for the employee in the list
    index = @session_view.ask_for(:index).to_i - 1
    # store this employee to create my order
    employee = employees[index]

    order = Order.new({meal: meal, customer: customer, employee: employee})
    @order_repo.create(order)
  end

  def list_undelivered_orders
    # FETCH FROM THE DB UNDELIVERED ORDERS
    undelivered_orders = @order_repo.undelivered_orders
    # DISPLAY IN MY VIEW
    @order_view.display(undelivered_orders)
  end

  def list_my_orders(current_user)
    # FETCH THE INFORMATIO
    my_undelivered_orders = @order_repo.my_undelivered_orders(current_user)
    # DISPLAY
    @order_view.display(my_undelivered_orders)
  end

  def mark_as_delivered(current_user)
    list_my_orders(current_user)
    index = @order_view.ask_for(:index).to_i - 1
    my_orders = @order_repo.my_undelivered_orders(current_user)
    order = my_orders[index]
    @order_repo.mark_as_delivered(order)
  end
end
