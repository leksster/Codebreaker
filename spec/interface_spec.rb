require 'spec_helper'

module Codebreaker

  describe Interface do

    let(:interface) { Codebreaker::Interface.new }

    context '#new' do
      it 'calls Codebreaker::Model.new when creating inteface instance' do
        expect(Codebreaker::Model).to receive(:new)
        Codebreaker::Interface.new
      end
    end

    context '#play' do
      before {allow(interface).to receive(:menu).and_return(CHOOSE_MESSAGE)}
      it 'should call #menu' do
        expect(interface).to receive(:menu).with(no_args)
        interface.play
      end
    end

    context '#menu' do
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
