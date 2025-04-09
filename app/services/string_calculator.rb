class StringCalculator
  def self.add(numbers)
    0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2..].split("\n", 2)
      numbers.split(delimiter).map(&:to_i).sum
    else
      nums = numbers.split(/,|\n/).map(&:to_i)
      negatives = nums.select { |n| n < 0 }
      raise "Negative numbers not allowed: #{negatives.join(', ')}" unless negatives.empty?
      nums.sum
    end
  end
end
