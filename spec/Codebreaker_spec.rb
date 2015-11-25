require 'spec_helper'

module Codebreaker

  describe Model do

    before(:each) do
      @game = Model.new
    end

    it 'has a version number' do
      expect(Codebreaker::VERSION).not_to be nil
    end

    it 'responds to generate, start' do
        expect(@game).to respond_to(:start)
    end

    context '#initialize' do

    end

    context '#generate' do  
      it 'saves secret code' do
        expect(@game.instance_variable_get(:@code)).not_to be_empty
      end
      it 'saves secret code as an array' do
        expect(@game.instance_variable_get(:@code)).to be_a(Array)
      end
      it 'saves secret code with 4 digits' do
        expect(@game.instance_variable_get(:@code).length).to eq(4)
      end
      it 'saves secret code with numbers from 1 to 6' do
        expect(@game.instance_variable_get(:@code)).to all(be_between(1,6))
      end
    end

    context '#start' do
      it 'generates secret code with #generate method' do 
        expect(@game).to receive(:generate).with(no_args)
        @game.start
      end
    end

    context '#count_pluses' do 
      it 'counts same numbers with the same indexes' do
        @game.instance_variable_set(:@code, [1,2,3,4])
        @game.submit(1234)
        
        expect(@game.send(:count_pluses)).to eq(["+", "+", "+", "+"])
      end
    end

    context '#count_minuses' do
      it 'code=4321, guess=1234. Should return ["-", "-", "-", "-"]' do
        @game.instance_variable_set(:@code, [4,3,2,1])
        @game.instance_variable_set(:@guess, [1,2,3,4])
        expect(@game.send(:count_minuses)).to eq(["-", "-", "-", "-"])
      end

      it 'code=1256, guess=1262. Should return ["-"]' do
        @game.instance_variable_set(:@code, [1,2,5,6])
        @game.instance_variable_set(:@guess, [1,2,6,2])
        expect(@game.send(:count_minuses)).to eq(["-"])
      end

      it 'code=1112, guess=2211. Should return ["-", "-"]' do
        @game.instance_variable_set(:@code, [1,1,1,2])
        @game.instance_variable_set(:@guess, [2,2,1,1])
        expect(@game.send(:count_minuses)).to eq(["-", "-"])
      end

      it 'code=2233, guess=3322. Should return ["-", "-", "-", "-"]' do
        @game.instance_variable_set(:@code, [2,2,3,3])
        @game.instance_variable_set(:@guess, [3,3,2,2])
        expect(@game.send(:count_minuses)).to eq(["-", "-", "-", "-"])
      end

      it 'code=2617, guess=6127. Should return ["-", "-", "-"]' do
        @game.instance_variable_set(:@code, [2,6,1,7])
        @game.instance_variable_set(:@guess, [6,1,2,7])
        expect(@game.send(:count_minuses)).to eq(["-", "-", "-"])
      end

      it 'code=5112, guess=1551. Should return ["-", "-", "-"]' do
        @game.instance_variable_set(:@code, [5,1,1,2])
        @game.instance_variable_set(:@guess, [1,5,5,1])
        expect(@game.send(:count_minuses)).to eq(["-", "-", "-"])
      end

      it 'code=2421, guess=5125. Should return ["-"]' do
        @game.instance_variable_set(:@code, [2,4,2,1])
        @game.instance_variable_set(:@guess, [5,1,2,5])
        expect(@game.send(:count_minuses)).to eq(["-"])
      end

      it 'code=1321, guess=5125. Should return ["-"]' do
        @game.instance_variable_set(:@code, [1,3,2,1])
        @game.instance_variable_set(:@guess, [5,1,2,5])
        expect(@game.send(:count_minuses)).to eq(["-"])
      end

    end

    context '#submit' do
      it 'checks the argument to be Fixnum' do
        expect{@game.submit('5255')}.to raise_error(ArgumentError)
      end

      it 'checks the argument to be 4 digits' do
        expect{@game.submit(612)}.to raise_error(ArgumentError)
        expect{@game.submit(126236)}.to raise_error(ArgumentError)
      end

      it 'saves the guess' do
        @game.submit(1234)
        expect(@game.instance_variable_get(:@guess)).not_to be_empty
      end

      context 'some examples' do
        it 'code=1321, guess=5125. Should return ["+","-"]' do
          @game.instance_variable_set(:@code, [1,3,2,1])
          expect(@game.submit(5125)).to eq(["+", "-"])
        end

        it 'code=2421, guess=5125. Should return ["+","-"]' do
          @game.instance_variable_set(:@code, [2,4,2,1])
          expect(@game.submit(5125)).to eq(["+", "-"])
        end

        it 'code=1135, guess=1155. Should return ["+","+","+"]' do
          @game.instance_variable_set(:@code, [1,1,3,5])
          expect(@game.submit(1155)).to eq(["+", "+", "+"])
        end

        it 'code=1234, guess=2524. Should return ["+","-"]' do
          @game.instance_variable_set(:@code, [1,2,3,4])
          expect(@game.submit(2524)).to eq(["+", "-"])
        end
      end

    end

    context '#win' do
      it 'returnes true when @guess == @code' do
        @game.instance_variable_set(:@code, [1,2,2,1])
        @game.submit(1221)
        expect(@game.win?).to be true
      end
      it 'returnes false when @guess != @code' do
        @game.instance_variable_set(:@code, [1,2,2,1])
        @game.submit(1226)
        expect(@game.win?).to be false
      end
    end

    context '#lose' do
      it 'returnes true when there\'re no tries' do
        10.times { @game.submit(1354) }
        expect(@game.lose?).to be true
      end
      it 'returnes false when there is 1 or more tries' do
        9.times { @game.submit(1267) }
        expect(@game.lose?).to be false
      end
    end

    context '#restart' do
      xit 'restarts the game' do
        expect(@game.restart).to change{@game.instance_variable_get(:@code)}
      end
    end

    context '#hint' do
      it 'gives a hint' do 
        expect(@game.hint).to be_a(Hash)
      end

      it 'only 1 hint is available' do
        expect(@game.instance_variable_get(:@hints)).to eq(1)
      end
      xit 'returns Hash with random secret number and it\'s index' do
        expect(@game.hint).to be_a(Hash)
      end
    end

    context '#save' do
      it 'saves progress to somewhere'
    end

  end
end
