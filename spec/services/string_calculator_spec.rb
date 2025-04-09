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
  end
end
