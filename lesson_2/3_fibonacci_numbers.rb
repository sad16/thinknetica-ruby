def sum(numbers)
  numbers.reduce(0, :+)
end

fibonacci_numbers = [0, 1]

loop do
  next_fibonacci_number = sum(fibonacci_numbers.last(2))
  break if next_fibonacci_number > 100
  fibonacci_numbers << next_fibonacci_number
end

puts fibonacci_numbers