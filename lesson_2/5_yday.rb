def days_in_month(year)
  days_in_months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  days_in_months[1] = 29 if leap?(year)
  days_in_months
end

def leap?(year)
  (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0)
end

puts "Введите дату в формате DD.MM.YYYY:"
day, mouth, year = gets.chomp.split(".").map(&:to_i)

yday = days_in_month(year).first(mouth - 1).sum + day
puts yday
