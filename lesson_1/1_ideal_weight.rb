puts "Как вас зовут?"
name = gets.chomp

puts "Какой у вас рост?"
height = gets.chomp.to_i

weight = height - 110
output = weight > 0 ? "#{name}, ваш идеальный вес: #{weight}" : 
                      "#{name}, ваш вес уже оптимальный"
puts output