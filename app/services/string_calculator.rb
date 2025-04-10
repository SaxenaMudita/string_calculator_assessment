class StringCalculator
  DEFAULT_DELIMITERS = /,|\n/

  def self.add(numbers)
    return 0 if numbers.empty?

    delimiter, numbers = extract_custom_delimiter(numbers)
    nums = split_numbers(numbers, delimiter)
    validate_no_negatives(nums)
    nums.sum
  end

  private

  def self.extract_custom_delimiter(numbers)
    if numbers.start_with?("//[")
      delimiters = numbers.scan(/\[(.*?)\]/).flatten
      delimiter_regex = delimiters.map { |d| Regexp.escape(d) }.join("|")
      numbers = numbers.split("\n", 2).last
      [ delimiter_regex, numbers ]
    elsif numbers.start_with?("//")
      delimiter, numbers = numbers[2..].split("\n", 2)
      [ Regexp.escape(delimiter), numbers ]
    else
      [ DEFAULT_DELIMITERS, numbers ]
    end
  end

  def self.split_numbers(numbers, delimiter)
    numbers.split(/#{delimiter}/).map(&:to_i).reject { |n| n > 1000 }
  end

  def self.validate_no_negatives(nums)
    negatives = nums.select { |n| n < 0 }
    raise "Negative numbers not allowed: #{negatives.join(', ')}" if negatives.any?
  end
end
