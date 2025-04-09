class StringCalculator
  def self.add(numbers)
    0 if numbers.empty?
    numbers.to_i if numbers
    numbers.split(",").map(&:to_i).sum
  end
end
