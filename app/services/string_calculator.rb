class StringCalculator
  DEFAULT_DELIMITERS = /,|\n/

  class << self
    def add(numbers)
      return 0 if numbers.empty?

      delimiter, numbers = parse_delimiters(numbers)
      nums = parse_numbers(numbers, delimiter)
      validate_no_negatives(nums)
      nums.sum
    end

    private

    def parse_delimiters(numbers)
      if custom_delimiters?(numbers)
        parse_multiple_delimiters(numbers)
      elsif single_custom_delimiter?(numbers)
        parse_single_delimiter(numbers)
      else
        [ DEFAULT_DELIMITERS, numbers ]
      end
    end

    def custom_delimiters?(numbers)
      numbers.start_with?("//[")
    end

    def single_custom_delimiter?(numbers)
      numbers.start_with?("//")
    end

    def parse_multiple_delimiters(numbers)
      delimiters = numbers.scan(/\[(.*?)\]/).flatten
      delimiter_regex = delimiters.map { |d| Regexp.escape(d) }.join("|")
      [ delimiter_regex, numbers.split("\n", 2).last ]
    end

    def parse_single_delimiter(numbers)
      delimiter, remaining_numbers = numbers[2..].split("\n", 2)
      [ Regexp.escape(delimiter), remaining_numbers ]
    end

    def parse_numbers(numbers, delimiter)
      numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
    end

    def validate_no_negatives(nums)
      negatives = nums.select(&:negative?)
      raise "Negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?
    end
  end
end
