require 'spec_helper'

module Codebreaker

  describe Interface do

    let(:interface) { Codebreaker::Interface.new }

    context '#play' do
      it 'should call #welcome' do
        expect(interface).to receive(:welcome).with(no_args)
        allow(interface).to receive(:submit).and_return('s')
        interface.play
      end
      it 'should call #start' do
        expect(interface).to receive(:submit).with(no_args)
        allow(interface).to receive(:submit).and_return('s')
        interface.play
      end
    end

    context '#submit' do
      it 'test' do
        allow(interface).to receive(:submit).and_return('s')
      end
    end

    context '#welcome' do
      it 'should display welcome message' do
        expect{interface.welcome}
        .to output(puts Codebreaker::START_MESSAGE).to_stdout
      end
      it 'should propose to choose [start], [exit], [hint]' do
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
