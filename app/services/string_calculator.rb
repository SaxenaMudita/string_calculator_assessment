class StringCalculator
  DEFAULT_DELIMITERS = /,|\n/ # Default delimiters: comma and newline

  class << self
    def add(numbers)
      return 0 if numbers.empty? # Return 0 for an empty string

      delimiter, numbers = parse_delimiters(numbers)
      nums = parse_numbers(numbers, delimiter)
      validate_no_negatives(nums)
      nums.sum
    end

    private

    def parse_delimiters(numbers)
      if custom_delimiters?(numbers)
        validate_custom_delimiter_format!(numbers) # Ensure custom delimiter format is valid
        parse_multiple_delimiters(numbers)
      elsif single_custom_delimiter?(numbers)
        parse_single_delimiter(numbers)
      else
        [ DEFAULT_DELIMITERS, numbers ] # Use default delimiters if no custom delimiter is provided
      end
    end

    def custom_delimiters?(numbers)
      numbers.start_with?("//[") # Check for multiple custom delimiters
    end

    def single_custom_delimiter?(numbers)
      numbers.start_with?("//") # Check for a single custom delimiter
    end

    def parse_multiple_delimiters(numbers)
      # Extract delimiters enclosed in square brackets and build a regex pattern
      delimiters = numbers.scan(/\[(.*?)\]/).flatten
      delimiter_regex = delimiters.map { |d| Regexp.escape(d) }.join("|")
      [ delimiter_regex, numbers.split("\n", 2).last ]
    end

    def parse_single_delimiter(numbers)
      # Extract the single custom delimiter and the remaining numbers
      delimiter, remaining_numbers = numbers[2..].split("\n", 2)
      [ Regexp.escape(delimiter), remaining_numbers ]
    end

    def validate_custom_delimiter_format!(numbers)
      # Raise an error if the custom delimiter format is invalid
      unless numbers.match?(/^\/\/(\[.*?\])+\n/)
        raise "Invalid custom delimiter format"
      end
    end

    def parse_numbers(numbers, delimiter)
      # Split numbers using the delimiter and ignore numbers greater than 1000
      numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
    end

    def validate_no_negatives(nums)
      # Raise an error if any negative numbers are found
      negatives = nums.select(&:negative?)
      raise "Negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?
    end
  end
end
