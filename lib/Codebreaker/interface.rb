require "Codebreaker"

module Codebreaker
  class Interface

    def play
      welcome
      menu
    end

    def menu
      puts CHOOSE_MESSAGE
      loop do
        case gets.chomp.downcase
        when 's' then start_game
        when 'e' then exit
        when 'h' then puts HINTS_UNAVAILABLE
        when 'r' then puts CANT_RESTART
        when '?' then puts CHOOSE_MESSAGE
        else puts UNKNOWN_COMMNAND
        end
      end
    end

    def start_game
      @game = Codebreaker::Model.new
      puts GENERATED_CODE_MESSAGE
      puts GUESS_MESSAGE
      loop do
        @submit = gets.chomp
        case @submit
        when 'cheat' then puts @game.send(:instance_variable_get, :@code).join
        when 'h' then hint
        when 'e' then exit
        when 'r' then @game.restart; puts RESTART
        when '?' then puts CHOOSE_MESSAGE
        else input
        end
        game_over
      end
    end

    def game_over
      if @game.win?
        puts "#{WIN_MESSAGE} #{@game.send(:instance_variable_get, :@code).join}"
        menu
      elsif @game.lose?
        puts "#{LOSE_MESSAGE} #{@game.send(:instance_variable_get, :@code).join}"
        menu
      end
    end

    def input
      begin
        puts @game.submit(@submit.to_i).join
      rescue ArgumentError => e
        puts "Wrong Input"
        puts e
      end
    end

    def hint
      hint = @game.hint
      return puts NO_HINTS if !hint
      output = %w(* * * *)
      output[hint.keys[0]] = hint.values[0]
      p output.join
    end

    def welcome
      puts START_MESSAGE
    end

  end
end