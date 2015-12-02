require 'spec_helper'

module Codebreaker

  describe Interface do

    let(:interface) { Interface.new }
    before { interface.instance_variable_set(:@loop, false) }

    context '#new' do
      it 'calls Codebreaker::Model.new when creating inteface instance' do
        expect(Model).to receive(:new)
        Interface.new
      end
    end

    context '#play' do
      before do 
        allow(interface).to receive(:menu)
        allow(interface).to receive(:show)
      end
      it 'should call #menu' do
        expect(interface).to receive(:menu).with(no_args)
        interface.play
      end
      it 'should call #show START_MESSAGE' do
        expect(interface).to receive(:show).with(START_MESSAGE)
        interface.play
      end
    end

    context '#menu' do
      it 'should call #show(UNKNOWN_COMMAND) for any non defined command' do
        allow(interface).to receive(:user_input).and_return('smth')
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        expect(interface).to receive(:show).with(UNKNOWN_COMMAND)
        interface.menu
      end
      it 'should call #start_game if "s" received' do
        allow(interface).to receive(:user_input).and_return('s')
        expect(interface).to receive(:start_game)
        interface.menu
      end

      it 'should call #exit if "e" received' do
        allow(interface).to receive(:exit)
        allow(interface).to receive(:user_input).and_return('e')
        expect(interface).to receive(:exit)
        interface.menu
      end
      it 'should call #show(HINTS_UNAVAILABLE) if "h" received' do
        allow(interface).to receive(:user_input).and_return('h')
        expect(interface).to receive(:show).with(HINTS_UNAVAILABLE)
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        interface.menu
      end
      it 'should call #show(CANT_RESTART) if "r" received' do
        allow(interface).to receive(:user_input).and_return('r')
        expect(interface).to receive(:show).with(CANT_RESTART)
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        interface.menu
      end
      it 'should call #show(CHOOSE_MESSAGE) if "?" received' do
        allow(interface).to receive(:user_input).and_return('?')
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        interface.menu
      end
    end

    context '#start_game' do
      before do
        allow(interface).to receive(:restart)
        allow(interface).to receive(:game_messages)
        allow(interface).to receive(:check)
        allow(interface).to receive(:show).with(RESTART)
      end
      it 'should call #game_messages when #start_game' do
        allow(interface).to receive(:user_input).and_return('smth')
        expect(interface).to receive(:game_messages)
        interface.start_game
      end
      it 'should call #hint when "h" received' do
        allow(interface).to receive(:user_input).and_return('h')
        expect(interface).to receive(:hint)
        interface.start_game
      end
      it 'should call #exit when "e" received' do
        allow(interface).to receive(:user_input).and_return('e')
        allow(interface).to receive(:exit)
        expect(interface).to receive(:exit)
        interface.start_game
      end
      it 'should call #restart when "r" received' do
        allow(interface).to receive(:user_input).and_return('r')
        expect(interface).to receive(:restart)
        interface.start_game
      end
      it 'should call #show(CHOOSE_MESSAGE) when "?" received' do
        allow(interface).to receive(:user_input).and_return('?')
        expect(interface).to receive(:show).with(CHOOSE_MESSAGE)
        interface.start_game
      end
      it 'should call #check when something else is inputted' do
        allow(interface).to receive(:user_input).and_return('5213')
        expect(interface).to receive(:check)
        interface.start_game
      end
      it 'should call #game_over when #start_game' do
        allow(interface).to receive(:user_input).and_return('5176')
        expect(interface).to receive(:game_over)
        interface.start_game
      end
    end

    context '#restart' do
      it 'should call #restart on game instance' do
        expect(interface.instance_variable_get(:@game)).to receive(:restart)
        interface.restart
      end
    end

    context '#game_over' do
      it 'should #show win message if @game.win? is true and call #menu' do
        allow(interface).to receive(:menu)
        allow(interface.instance_variable_get(:@game)).to receive(:win?).and_return(true)
        expect(interface).to receive(:show).with("#{WIN_MESSAGE} #{interface.instance_variable_get(:@game).send(:instance_variable_get, :@code).join}")
        expect(interface).to receive(:menu)
        interface.game_over
      end
      it 'should #show lose message if @game.lose? is true and call #menu' do
        allow(interface).to receive(:menu)
        allow(interface.instance_variable_get(:@game)).to receive(:lose?).and_return(true)
        expect(interface).to receive(:show).with("#{LOSE_MESSAGE} #{interface.instance_variable_get(:@game).send(:instance_variable_get, :@code).join}")
        expect(interface).to receive(:menu)
        interface.game_over
      end
    end

    context '#check' do
      it 'should call #submit on game instance' do
        interface.instance_variable_set(:@submit, 1245)
        expect(interface).to receive(:show).and_return(interface.instance_variable_get(:@game).submit(interface.instance_variable_get(:@submit)).join)
        interface.check
      end
    end

    context '#hint' do
      before do
        allow(interface).to receive(:show).with(NO_HINTS)
      end
      it 'should call @game#hint' do
        expect(interface.instance_variable_get(:@game)).to receive(:hint)
        interface.hint
      end
      it 'should return NO_HINTS when hints == 0' do
        allow(interface.instance_variable_get(:@game)).to receive(:hint).and_return(false)
        expect(interface).to receive(:show).with(NO_HINTS)
        interface.hint
      end
      it 'should show hint if hints != 0' do
        allow(interface.instance_variable_get(:@game)).to receive(:hint).and_return(0 => 4)
        expect(interface.hint).to eq('4***')
      end

    end

  end

end
