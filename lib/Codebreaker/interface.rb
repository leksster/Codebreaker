module Codebreaker
  class Interface

    def initialize
      @loop = true
      @game = Codebreaker::Model.new
    end

    def play
      show(START_MESSAGE)
      menu
    end

    def user_input
      gets.chomp.downcase
    end

    def menu
      show(CHOOSE_MESSAGE)
      loop do
        case user_input
        when 's' then start_game
        when 'e' then exit
        when 'h' then show(HINTS_UNAVAILABLE)
        when 'r' then show(CANT_RESTART)
        when '?' then show(CHOOSE_MESSAGE)
        else show(UNKNOWN_COMMAND)
        end
        break if @loop == false
      end
    end

    def show(message)
      puts message
    end

    def game_messages
      show(GENERATED_CODE_MESSAGE)
      show(GUESS_MESSAGE)
    end

    def start_game
      restart
      game_messages
      loop do
        @submit = user_input
        case @submit
        when 'cheat' then show(@game.send(:instance_variable_get, :@code).join)
        when 'h' then hint
        when 'e' then exit
        when 'r' then restart; show(RESTART)
        when '?' then show(CHOOSE_MESSAGE)
        else check
        end
        game_over
        break if @loop == false
      end    
    end

    def restart
      @game.restart
    end

    def game_over
      if @game.win?
        show("#{WIN_MESSAGE} #{@game.send(:instance_variable_get, :@code).join}")
        menu
      elsif @game.lose?
        show("#{LOSE_MESSAGE} #{@game.send(:instance_variable_get, :@code).join}")
        menu
      end
    end

    def check
      begin
        show(@game.submit(@submit).join)
      rescue ArgumentError => e
        show("Wrong Input")
        show e
      end
    end

    def hint
      hint = @game.hint
      return show(NO_HINTS) if !hint
      output = %w(* * * *)
      output[hint.keys[0]] = hint.values[0]
      p output.join
    end

  end
end