range = (10..100)

array = []
range.step(5) { |number| array << number }
puts array

# # variant with for
# array = []

# for number in range
#   array << number if number % 5 == 0
# end

# puts array

# # variant with while
# array = []

# number = 10
# while number < 101 do
#   array << number
#   number += 5
# end

# puts array

# # variant with until
# array = []

# number = 10
# until number > 101 do
#   array << number
#   number += 5
# end

# puts array
