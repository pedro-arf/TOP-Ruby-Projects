class Board
  COLORS = (1..6).to_a
  CODE_LENGTH = 4
  CODE_PEGS = %w[M P].freeze # M - exact match, P - partial match
  TURNS = 12

  def initialize(player, computer)
    @player = player
    @computer = computer
    @guess = []
    @possible_solutions = COLORS.repeated_permutation(CODE_LENGTH).to_a
  end

  def start_game
    @computer.codemaker ? computer_codemaker : computer_codebreaker
  end

  private

  def computer_codemaker
    puts "\nThe computer is the Code Maker!\n"

    code = Array.new(CODE_LENGTH) { rand(1..6) }

    TURNS.times do
      puts "\n#{@player.name}, make your guess!\n"

      new_guess = enter_code

      @guess = new_guess.digits.reverse

      display_board

      @guess.each_with_index do |number, index|
        if code[index] == number
          @guess[index] = CODE_PEGS[0]
        elsif code.include?(number)
          @guess[index] = CODE_PEGS[1]
        end
      end

      display_board

      if @guess.all?('M')
        puts "\nCongrats #{@player.name}!! You have guessed the code!\n\n"
        break
      end
    end

    unless @guess.all?('M')
      @computer.update_points
      puts "\nYou have not guessed the code! The computer has won this round!\n" \
           "The code was: #{code.join}\n"
    end
  end

  def computer_codebreaker
    partial_match = {}
    exact_match = {}
    wrong_numbers = []

    puts "\nThe computer is the Code Breaker!\n"
    puts "\n#{@player.name}, enter a code:\n"

    code = enter_code.digits.reverse

    computer_guess = @possible_solutions.sample

    ai_codebreaker_loop(computer_guess, code, exact_match, partial_match, wrong_numbers)
  end

  def ai_codebreaker_loop(computer_guess, code, exact_match, partial_match, wrong_numbers)
    TURNS.times do
      puts "\nThe computer has made a guess!\n"

      @guess = computer_guess

      display_board

      find_matches(computer_guess, code, exact_match, partial_match, wrong_numbers)

      display_board

      if @guess.all?('M')
        puts "\nThe computer has guessed the code!!\n\n"
        return true
      end
      computer_guess = update_guess(wrong_numbers, exact_match)
    end

    @player.update_points
    puts "\nCongrats #{@player.name}, you've won this round!! The computer has not guessed the code!\n" \
         "The code was: #{code.join}\n"
  end

  def find_matches(computer_guess, code, exact_match, partial_match, wrong_numbers)
    computer_guess.each_with_index do |number, index|
      if code[index] == number
        @guess[index] = CODE_PEGS[0]
        exact_match[index] = number
      elsif code.include?(number)
        @guess[index] = CODE_PEGS[1]
        partial_match[index] = number
      else
        wrong_numbers << number end
    end
  end

  def update_guess(wrong_numbers, exact_match)
    return exact_match.sort.to_h.values.to_a if exact_match.length == 4

    @possible_solutions.reject! do |solution|
      solution == @guess || solution.any? { |number| wrong_numbers.include?(number) }
    end

    @possible_solutions.sample
  end

  def enter_code
    while true
      begin
        code = Integer(gets.chomp)
        break if code.to_s.match(/[1-6]{4}/) && code.digits.length == CODE_LENGTH

        puts 'Please type a 4 digit code comprised of numbers from 1 to 6!'
      rescue ArgumentError, TypeError
        puts 'Please type a 4 digit code comprised of numbers from 1 to 6!'
      end
    end
    code
  end

  def display_board
    puts @guess.join(' | ')
  end
end
