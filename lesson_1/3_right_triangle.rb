def check_triangle sides
  return "Это равнобедренный и равносторонний, но не прямоугольный треугольник" if equilateral? sides

  if right? sides
    result = "Это прямоугольный треугольник"
    result += ", который также является равнобедренным" if isosceles? sides
    result
  else
    "Это не прямоугольный треугольник"
  end
end

def equilateral? sides
  sides.uniq.size == 1
end

def right? sides
  hypotenuse = sides.max
  cathetuses = sides.min(2)
  (hypotenuse ** 2) == (cathetuses.first ** 2) + (cathetuses.last ** 2)
end

def isosceles? sides
  sides.uniq.size == 2
end

puts "Введите все стороны треугольника через пробел:"
sides = gets.chomp.split(" ").map(&:to_f)

puts check_triangle sides