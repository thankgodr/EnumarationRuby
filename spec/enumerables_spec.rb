require './enumerable'

RSpec.describe Enumerable do
  let(:testArray) { [1, 2, 3, 4, 5] }
  describe '#my_each' do
    it 'Return a valid enumerable' do
      expect(testArray.my_each).not_to be_a(String)
    end

    it 'Return a valid enumerable' do
      expect(testArray.my_each { |element| element }).not_to eql(nil)
    end

    it 'Return an array equalt to the original [1,2,3,4,5]' do
      expect(testArray.my_each { |element| element }).to eql(testArray)
    end

    it 'Returns a valid Enumerable when no vlock is given' do
      expect(testArray.my_each).to be_a(Enumerable)
    end
  end

  describe '#my_each_with_index' do
    it 'Return a  valid enumerable if no block given' do
      expect(testArray.my_each_with_index).to be_a(Enumerable)
    end

    it 'Returns an Valid Enumerable' do
      expect(testArray.my_each_with_index).not_to be_a(String)
    end
    let(:expected_testArray) { [] }

    it 'Returns a new array substracting 1 from each array' do
      testArray.my_each_with_index { |_x, i| expected_testArray[i] = testArray[i] - 1 }
      expect(expected_testArray).to eql([0, 1, 2, 3, 4])
    end

    it 'Does block instructions on each element (negative)' do
      testArray.my_each_with_index { |_x, i| expected_testArray[i] = testArray[i] - 1 }
      expect(expected_testArray).not_to eql(testArray)
    end
  end

  describe '#my_select' do
    let(:expected_testArray) { testArray.my_select(&:even?) }

    it 'Expected all even numbers from [1,2,3,4,5]' do
      expect(expected_testArray).to eql([2, 4])
    end

    it 'Expected all even numbers from [1,2,3,4,5' do
      expect(expected_testArray).not_to eql([])
    end

    let(:tempArr) { testArray.my_select }

    it 'Return valid enumerable when no block is passed' do
      expect(tempArr).not_to be_a(Integer)
    end
  end

  describe '#my_all?' do
    let(:tempArr) { testArray.my_all?(&:even?) }

    it 'Return false if not all elements fill criteria' do
      expect(tempArr).to eql(false)
    end

    it 'Returns false if not all elements fill criteria (negative)' do
      expect(tempArr).not_to eql(true)
    end

    let(:expected_testArray) { testArray.my_all? { |x| x > 0 } }

    it 'Returns true if all elements fill criteria' do
      expect(expected_testArray).to eql(true)
    end

    it 'Returns true if all elements fill criteria (negative)' do
      expect(expected_testArray).not_to eql(false)
    end

    let(:expected_testArray) { testArray.my_all? }

    it 'Returns true if no block is given and none of the elements are false or nil' do
      expect(expected_testArray).to eql(true)
    end

    it 'Returns true if no block is given and none of the elements are false or nil (negative)' do
      expect(expected_testArray).not_to eql(false)
    end
  end

  describe '#my_any?' do
    let(:tempArr) { testArray.my_any?(&:even?) }

    it 'Returns true if any of the elements fill criteria' do
      expect(tempArr).to eql(true)
    end

    it 'Returns true if any of the elements fill criteria (negative)' do
      expect(tempArr).not_to eql(false)
    end

    let(:expected_testArray) { testArray.my_any? { |x| x < 0 } }

    it 'Returns false if none of the elements fill criteria' do
      expect(expected_testArray).to eql(false)
    end

    it 'Returns false if none of the elements fill criteria (negative)' do
      expect(expected_testArray).not_to eql(true)
    end
  end

  describe '#my_none?' do
    let(:tempArr) { testArray.my_none?(&:even?) }

    it 'Returns false if any of the elements fill criteria' do
      expect(tempArr).to eql(false)
    end

    it 'Returns false if any of the elements fill criteria (negative)' do
      expect(tempArr).not_to eql(true)
    end

    let(:expected_testArray) { testArray.my_none? { |x| x < 0 } }

    it 'Return true if none of the elements fill criteria' do
      expect(expected_testArray).to eql(true)
    end

    it 'Return true if none of the elements fill criteria (negative)' do
      expect(expected_testArray).not_to eql(false)
    end
  end

  describe '#my_count' do
    it 'Return the size of the testArray' do
      expect(testArray.my_count).not_to eql(0)
    end

    it 'Return number of even elements' do
      expect(testArray.my_count(&:even?)).to eql(2)
    end

    it 'Return number of even elements' do
      expect(testArray.my_count(&:even?)).not_to eql(0)
    end

    it 'Return the count of value equal to 5' do
      expect(testArray.my_count(5)).to eql(1)
    end

    it 'Return the count of value equal to 5' do
      expect(testArray.my_count(5)).not_to eql(5)
    end
  end

  describe '#my_map' do
    it 'Return a valid enumerator if no block given' do
      expect(testArray.my_map).to be_a(Enumerator)
    end

    it 'Return a valid enumerator if no block given' do
      expect(testArray.my_map).not_to be_a(String)
    end

    it 'Return a modified testArray if block is given' do
      expect(testArray.my_map { |x| x * 2 }).to eql([2, 4, 6, 8, 10])
    end

    it 'Return a modified testArray if block is given' do
      expect(testArray.my_map { |x| x * 2 }).not_to eql(testArray)
    end
  end

  describe '#my_inject' do
    it 'Add all numbers with initial 5 injected' do
      expect(testArray.my_inject(5, :+)).to eql(20)
    end

    it 'Add all numbers with initial 5 injected' do
      expect(testArray.my_inject(5, :+)).not_to eql(10)
    end

    it 'Add all numbers using symbol' do
      expect(testArray.my_inject(:+)).to eql(15)
    end

    it 'Add all numbers using symbol' do
      expect(testArray.my_inject(:+)).not_to eql(200)
    end

    it 'Use and injected number with a block' do
      expect(testArray.my_inject(5) { |acumulator, x| acumulator + x }).to eql(20)
    end

    it 'Use and injected number with a block' do
      expect(testArray.my_inject(5) { |acumulator, x| acumulator + x }).not_to eql(150)
    end

    it 'Use Symbol for opeartions' do
      expect(testArray.my_inject { |accumulator, x| accumulator + x }).to eql(15)
    end

    it 'Use Symbol for opeartions' do
      expect(testArray.my_inject { |accumulator, x| accumulator + x }).not_to eql(200)
    end
  end
end
