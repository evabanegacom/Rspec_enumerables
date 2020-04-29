# spec/test_spec.rb

require './lib/module'

describe Enumerable do
  let(:array) { [1, 1, 1, 4, 5] }
  let(:one_array) { [1, 1, 1] }
  let(:arr_text) { %w[ant bear cat] }
  describe '#my_each' do
    it 'if no block is given it should return the enumerator' do
      expect(array.my_each).to be_a(Enumerator)
    end
    it 'expect to return all the items in the array' do
      expect(array.my_each.to_a).to eql(array)
    end
    it 'block_given' do
      expect(array.my_each { |x| puts { x }.to_a }).to \
        eql(array.each { |x| puts { x }.to_a })
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
      expect(array.my_each_with_index { |item, index| puts item, index }).to \
        eql(array.each { |item| puts item, array.index })
    end
    it 'raise error if arguement passed' do
      expect { array.my_each_with_index('argument') }.to \
        raise_error(ArgumentError)
    end
  end

  describe '#my_count' do
    it 'returns the division of two numbers' do
      expect(array.my_count).to eql(5)
    end

    it 'returns the call or conditional call' do
      expect(array.my_count(1)).to eq(3)
    end

    it 'returns the number of odd numbers' do
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
      expect(array.my_map(proc_) { |x| x > 2 }).to \
        eql([false, false, false, true, true])
    end
    it 'for regular expressions it should return their classes' do
      expect(array.my_map(&:class)).to \
        eql([Integer, Integer, Integer, Integer, Integer])
    end
  end

  describe '#my_all?' do
    it 'return true if all element satisfy the condition' do
      expect(arr_text.my_all? { |word| word.length >= 3 }).to eql(true)
    end
    it 'return false if any of the element doesnot satisfy the condition' do
      expect(arr_text.my_all? { |word| word.length >= 4 }).to eql(false)
    end
    it 'return true if all element member of class' do
      expect(array.my_all?(Integer)).to eql(true)
    end
    it 'return true if all of the collection matches the pattern' do
      expect(one_array.my_any?(1)).to eq(true)
    end
  end

  describe '#my_any?' do
    it 'return true if any element satisfy the condition' do
      expect(arr_text.my_any? { |word| word.length >= 4 }).to eql(true)
    end
    it 'return false if no element doesnot satisfy the condition' do
      expect(arr_text.my_any? { |word| word.length >= 5 }).to eql(false)
    end
    it 'return true if any element is member of class' do
      expect(array.my_any?(Integer)).to eql(true)
    end
    it 'return false if no element is member of class' do
      expect(arr_text.my_any?(Integer)).to eql(false)
    end
    it 'return true if any of the collection matches the pattern' do
      expect(array.my_any?(1)).to eq(true)
    end
  end

  describe '#my_none?' do
    it 'return true if none of element satisfy the condition' do
      expect(arr_text.my_none? { |word| word.length >= 5 }).to eql(true)
    end
    it 'return false if any element satisfy the condition' do
      expect(arr_text.my_none? { |word| word.length >= 4 }).to eql(false)
    end
    it 'return false if all element satisfy the condition' do
      expect(arr_text.my_none? { |word| word.length >= 3 }).to eql(false)
    end
    it 'return true if none element is member of class' do
      expect(arr_text.my_none?(Integer)).to eql(true)
    end
    it 'return false if all element is member of class' do
      expect(array.my_none?(Integer)).to eql(false)
    end
    it 'return true if none of the collection matches the pattern' do
      expect(array.my_none?(2)).to eq(true)
    end
  end
  describe '#my_inject' do
    it 'returns the function call of the block' do
      expect(array.my_inject { |x, y| x * y }).to \
        eql(array.inject { |x, y| x * y })
    end
    it ' inject with symbol' do
      expect((5..10).my_inject(:+)).to eql((5..10).inject(:+))
    end
    it 'with a symbol and initial value for' do
      expect((5..10).my_inject(1, :*)).to eql((5..10).inject(1, :*))
    end
    it 'returns function call of the block with initial value' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to \
        eql((5..10).inject(1) { |product, n| product * n })
    end
  end
end
