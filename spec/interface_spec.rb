require 'spec_helper'

module Codebreaker

  describe Interface do

    let(:interface) { Codebreaker::Interface.new }

    context '#new' do
      it 'calls Codebreaker::Model.new when creating inteface instance' do
        expect(Codebreaker::Model).to receive(:new)
        interface
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
      it 'should call #show' do
        expect(interface).to receive(:show).with(START_MESSAGE)
        interface.play
      end
    end

    context '#menu' do
      it 'should call #show(CHOOSE_MESSAGE)' do
        allow(interface).to receive(:user_input).and_return('smth')
        expect(interface).to receive(:show).with(UNKNOWN_COMMAND)
        interface.menu
      end
      xit 'should call #start_game if "s" received' do
        allow(interface).to receive(:user_input).and_return('s')
        interface.menu
      end

      xit 'test' do
        allow(interface).to receive(:user_input).and_return('s')
        expect(interface.menu).to receive(:start_game)
        interface.menu
      end
    end

    context '#welcome' do
      xit 'should display welcome message' do
        expect{interface.welcome}
        .to output(puts Codebreaker::START_MESSAGE).to_stdout
      end
      xit 'should propose to choose [start], [exit], [hint]' do
        expect{interface.welcome}
        .to output(puts Codebreaker::CHOOSE_MESSAGE).to_stdout
      end
    end

    context 'play' do
      it 'Displays message'
      it 'Propose hint'
      it 'Do some logic'
      it 'win'
      it 'lose'
    end

  end

end
