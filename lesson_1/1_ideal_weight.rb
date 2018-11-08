puts "Как вас зовут?"
name = gets.chomp.capitalize

puts "Какой у вас рост?"
height = gets.chomp.to_i

weight = height - 110

output = 
  if weight > 0
    "#{name}, ваш идеальный вес: #{weight}"
  else
    "#{name}, ваш вес уже оптимальный"
  end

puts output
