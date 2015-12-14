class CLI
  def run
    greeting
    instructions

    i = 1
    command = ""
    while i != 0
      command = gets.chomp.upcase
      if command == "HELP"
        help
      elsif command == 'EXIT'
        i = 0
      else
        Intrinio.new(command)
      end
    end
  end

  def greeting
    puts "Welcome to the Bitcoin Stock Index"
  end

  def instructions
    puts "Enter a ticker symbol to receive the spot price in US Dollars and the price in mBTC (1/1000 of a BitCoin)"
  end

  def help
  end

  def exit
  end
end
