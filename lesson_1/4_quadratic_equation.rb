def find_roots a, b, c
  d = discriminant a, b, c

  result = if d < 0
    "Корней нет."
  else
    sqrt_d = Math.sqrt(d)
    x1 = (-b + sqrt_d) / (2 * a)
    x2 = (-b - sqrt_d) / (2 * a)
    x1 == x2 ? "Один корень: #{x1}." : "Два корня: #{x1} и #{x2}."
  end

  "#{result} Дискриминант: #{d}"
end

def discriminant a, b, c
  (b ** 2) - (4 * a * c)
end

puts "Введите коэффициенты квадратного уравнения через пробел (a, b, c):"
a, b, c = gets.chomp.split(" ").map(&:to_f)
puts find_roots a, b, c
    