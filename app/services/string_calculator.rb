class StringCalculator
  def self.add(numbers)
    0 if numbers.empty?

    if numbers.start_with?("//")
      delimiter, numbers = numbers[2..].split("\n", 2)
      numbers.split(delimiter).map(&:to_i).sum
    else
      numbers.split(/,|\n/).map(&:to_i).sum
    end
  end
end
