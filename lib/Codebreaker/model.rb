require 'yaml'
require 'json'

module Codebreaker

  class Model

    def initialize
      start
    end

    def start
      @name = nil
      @tries = 10
      @hints = 1
      @guesses = Hash.new
      generate
    end
    alias_method :restart, :start

    def to_json
      { :name => @name, :tries => @tries, :hints => @hints, :guesses => @guesses, :code => @code }.to_json
    end

    def validate(guess)
      raise ArgumentError, 'Argument is not a number' if guess =~ /[^0-9]/
      raise ArgumentError, '4 digits required' unless guess.to_s.length == 4
      raise ArgumentError, 'Numbers should be between 1 and 6' if to_arr(guess).any? { |num| num.to_i > 6 || num.to_i < 1 }
      raise ArgumentError, 'Should not be nil' if guess.nil?
    end

    def submit(guess)
      @guess = guess.to_s.chars.map { |num| num.to_i }
      validate(guess)
      @tries -= 1
      result = count_pluses + count_minuses
      @guesses[@guess] = result.empty? ? ['None'] : result
    end

    def hint 
      if @hints > 0 && @code != []
        @hints -= 1
        index = rand(0...4)
        {index => @code[index]}
      else
        false
      end
    end

    def win?
      @guess == @code
    end

    def lose?
      @tries <= 0
    end

    def save(name)
      data = YAML.load_file('data.yml')
      File.open( 'data.yml', 'a' ) do |out|
        self.instance_variable_set(:@name, name)
        out.write self.to_yaml
      end
    end

    private

    def to_arr(inp)
      arr = []
      inp.to_s.split("").each { |n| arr << n }
      arr
    end

    def generate
      @code = (1..4).map { |item| rand(1..6) }
      true
    end

    def count_pluses
      result = []
      @guess.each_with_index do |number, index| 
        if @guess[index] == @code[index]
          result << '+'
        end
      end
      result
    end

    def count_minuses
      result, filtered_code, filtered_guess = [], [], []
      @guess.each_with_index do |number, index|
        if @guess[index] != @code[index]
          filtered_guess << @guess[index]
          filtered_code << @code[index]
        end
      end
      filtered_guess.each do |guess|
        filtered_code.each do |code|
          if guess == code 
            filtered_code.delete_at(filtered_code.index(code))
            result << '-'
            break
          end
        end
      end
      result
    end
  end
end