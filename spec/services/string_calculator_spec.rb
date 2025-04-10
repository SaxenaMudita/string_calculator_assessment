require 'rails_helper'

RSpec.describe StringCalculator do
  describe '.add' do
    subject { StringCalculator.add(input) }

    context 'when given an empty string' do
      let(:input) { '' }
      it { is_expected.to eq(0) }
    end

    context 'when given a single number' do
      let(:input) { '5' }
      it { is_expected.to eq(5) }
    end

    context 'when given two numbers' do
      let(:input) { '1,2' }
      it { is_expected.to eq(3) }
    end

    context 'when given multiple numbers' do
      let(:input) { '1,2,3,4,5' }
      it { is_expected.to eq(15) }
    end

    context 'when given a string with new lines' do
      let(:input) { "1\n2,3" }
      it { is_expected.to eq(6) }
    end

    context 'when given a string with custom delimiters' do
      let(:input) { "//;\n1;2;3" }
      it { is_expected.to eq(6) }
    end

    context 'when given a string with negative numbers' do
      let(:input) { '1,-2,3' }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, 'Negative numbers not allowed: -2')
      end
    end

    context 'when given multiple negative numbers' do
      let(:input) { '1,-2,-3' }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, 'Negative numbers not allowed: -2, -3')
      end
    end

    context 'when given numbers greater than 1000' do
      let(:input) { '2,1001' }
      it { is_expected.to eq(2) }
    end

    context 'when custom delimiters of any length are given' do
      let(:input) { "//[***]\n1***2***3" }
      it { is_expected.to eq(6) }
    end

    context 'when multiple custom delimiters are given' do
      let(:input) { "//[*][%]\n1*2%3" }
      it { is_expected.to eq(6) }
    end

    context 'when multiple custom delimiters with length greater than one are given' do
      let(:input) { "//[***][%%]\n1***2%%3" }
      it { is_expected.to eq(6) }
    end

    context 'when custom delimiter is declared but not used' do
      let(:input) { "//;\n" }
      it { is_expected.to eq(0) }
    end

    context 'when input contains only delimiters' do
      let(:input) { ",,\n" }
      it { is_expected.to eq(0) }
    end

    context 'when input contains mixed delimiters with empty sections' do
      let(:input) { "1,\n,2" }
      it { is_expected.to eq(3) }
    end

    context 'when input contains numbers equal to 1000' do
      let(:input) { "1000,2" }
      it { is_expected.to eq(1002) }
    end

    context 'when input contains consecutive delimiters' do
      let(:input) { "1,,2" }
      it { is_expected.to eq(3) }
    end

    context 'when custom delimiters are used with numbers greater than 1000' do
      let(:input) { "//;\n1001;2" }
      it { is_expected.to eq(2) }
    end

    context 'when custom delimiter format is invalid' do
      let(:input) { "//[**\n1**2" }
      it 'raises an error' do
        expect { subject }.to raise_error(RuntimeError, 'Invalid custom delimiter format')
      end
    end
  end
end
