# spec/test_spec.rb

require './lib/module'

describe Enumerable do
  let(:array) { [1, 1, 1, 4, 5] }
  describe '#my_each' do
    it 'if no block is given it should return the enumerator' do
      expect(array.my_each).to be_a(Enumerator)
    end
    it 'expect to be the array' do
      expect(array.my_each.to_a).to eql(array)
    end
    it 'block_given' do
      expect(array.my_each { |x| puts {x}.to_a }).to eql(array.each { |x| puts {x}.to_a })
    end
    it 'raise error if argument passed' do
      expect { array.my_each('argument') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_each_with_index' do
    it 'if no block is given it should return the enumerator' do
      expect(array.my_each_with_index).to be_a(Enumerator)
    end
    it 'expect to be the array and index' do
      expect(array.my_each_with_index { |item, index| puts item, index }).to eql(array.each_with_index { |item| puts item, array.index})
    end
    it 'raise error if arguement passed' do
      expect { array.my_each_with_index('argument') }.to raise_error(ArgumentError)
    end
  end

  describe '#my_count' do
    it 'returns the division of two numbers' do
      expect(array.my_count).to eql(5)
    end

    it 'returns the ' do
      expect(array.my_count(1)).to eq(3)
    end

    it 'returns even nimbers' do
      expect(array.my_count(&:odd?)).to eq(4)
    end
  end

  describe '#my_select' do
    it 'if no block is given it should return the enumerator' do
      expect(array.my_each).to be_a(Enumerator)
    end
    it 'returns the subtraction of two numbers' do
      expect(array.my_select { |x| x > 3 }).to eql([4, 5])
    end
  end

  describe '#my_map' do
    it 'if no block is given it should be an enumerator' do
      expect(array.my_each).to be_a(Enumerator)
    end
    it 'if block given should return calling conditions' do
      expect(array.my_map { |x| x * x }).to eql([1, 1, 1, 16, 25])
    end
    proc_ = proc { |x| x > 2 }
    it 'if a proc is given' do
      expect(array.my_map(proc_) {|x| x > 2}).to eql([false, false, false, true, true])
    end
    it 'for regular expressions it should return their classes' do
      expect(array.my_map(&:class)).to eql([Integer, Integer, Integer, Integer, Integer])
    end
  end



end
