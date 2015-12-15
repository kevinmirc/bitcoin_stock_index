class CLI

  def run
    greeting
    sleep(0.6)
    instructions
    ticker_symbol_input
  end

  def ticker_symbol_input
    command = " "
    while command
      puts "Enter a ticker symbol"
      command = gets.chomp.upcase
      if command == "HELP"
        help
      elsif command == "EXIT"
        puts "Goodbye"
        break
      else
        puts ""
        options(command)
      end
    end
  end

  def options(ticker)
    i=1
    puts "Select a number below for the data point."
    list_options

    while i != 0
      company = Intrinio.new(ticker)
      command = gets.chomp
      puts ""
      if command == "1"
        puts 'Finding spot price...'
        company.spot_price
        puts ""
      elsif command == "2"
        puts 'Finding 2014 revenue...'
        company.revenue_2014
        puts ""
      elsif command == 'options'
        list_options
      elsif command == "back"
        break
      elsif command == "help"
        options_help
      elsif command == "exit"
        break
      else
        puts "Not a valid Command. Type 'help' for list of commands."
        puts ""
      end
      puts "Enter another command:"
    end
  end

  def list_options
    puts "1. Current Stock Value"
    puts "2. Total Revenue in 2014"
    puts "Type 'back' to enter another symbol"
    puts ""
  end

  def greeting
    puts "Welcome to the Bitcoin Stock Index"
  end

  def instructions
    puts "Find a company's data in US Dollars & mBTC (1/1000 of a BitCoin)"
  end

  def help
    puts ""
    puts "Enter a ticker symbol to find data"
    puts "Type 'exit' to leave program"
    puts ""
  end

  def options_help
    puts ""
    puts "Enter 'back' to return to the main menu."
    puts "Type the number of the data you'd like to run (Type 'options' list types of data points)."
    puts ""
  end
end
