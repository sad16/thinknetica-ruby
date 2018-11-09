fibonacci_numbers = [0, 1]

while 101 > (next_fibonacci_number = fibonacci_numbers.last(2).sum)
  fibonacci_numbers << next_fibonacci_number
end

puts fibonacci_numbers
