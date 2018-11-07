def triangle_area base, height
  0.5 * base * height
end

puts "Введите основание треугольника (см):"
base = gets.chomp.to_f

puts "Введите высоту треугольника (см):"
height = gets.chomp.to_f

area = triangle_area(base, height)
puts "Площадь треугольника: #{area} кв.см"