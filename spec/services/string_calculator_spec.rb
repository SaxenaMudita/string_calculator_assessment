require 'rails_helper'

RSpec.describe StringCalculator do
  describe '.add' do
    context 'when given an empty string' do
      it 'returns 0' do
        expect(StringCalculator.add('')).to eq(0)
      end
    end

    context 'when given a single number' do
      it 'returns the number itself' do
        expect(StringCalculator.add('5')).to eq(5)
      end
    end

    context 'when two numbers are given' do
      it 'returns the sum of the numbers' do
        expect(StringCalculator.add('1,2')).to eq(3)
      end
    end

    context 'when multiple numbers are given' do
      it 'returns the sum of all the numbers' do
        expect(StringCalculator.add('1,2,3,4,5')).to eq(15)
      end
    end

    context 'when given a string with new lines' do
      it 'handles new lines between numbers' do
        expect(StringCalculator.add("1\n2,3")).to eq(6)
      end
    end

    context 'when given a string with custom delimiters' do
      it 'handles custom delimiters' do
        expect(StringCalculator.add("//;\n1;2;3")).to eq(6)
      end
    end

    context 'when given a string with negative numbers' do
      it 'raises an error' do
        expect { StringCalculator.add("1,-2,3") }.to raise_error(RuntimeError, "Negative numbers not allowed: -2")
      end

      it 'raises an error for multiple negative numbers' do
        expect { StringCalculator.add("1,-2,-3") }.to raise_error(RuntimeError, "Negative numbers not allowed: -2, -3")
      end
    end
  end
end
