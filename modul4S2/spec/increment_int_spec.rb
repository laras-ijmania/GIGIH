require_relative '../src/increment_int'

RSpec.describe IncrementInt do
    it 'return 2' do
        increment_int = IncrementInt.new([1])

        result = increment_int.increment

        expect(result).to eq ([2])
    end

    it 'return 3' do
        increment_int = IncrementInt.new([2])

        result = increment_int.increment

        expect(result).to eq ([3])
    end

    it 'return [2,4]' do
        increment_int = IncrementInt.new([2,3])

        result = increment_int.increment

        expect(result).to eq ([2,4])
    end

    it 'return [3,0]' do
        increment_int = IncrementInt.new([2,9])

        result = increment_int.increment

        expect(result).to eq ([3,0])
    end

    it 'return [1,0,0]' do
        increment_int = IncrementInt.new([9,9])

        result = increment_int.increment

        expect(result).to eq ([1,0,0])
    end
end