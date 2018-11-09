class Basket
  attr_accessor :products

  def initialize
    @products = {}
  end

  def add(name, cost, count)
    products[name] = { cost: cost, count: count }
  end

  def show
    show_products
    show_total_cost
  end

  private

  def show_products
    puts "Название | Стоимость за единицу товара | Количество | Суммарная стоимость"
    products.each do |name, options|
      cost = options[:cost]
      count = options[:count]
      puts "#{name} | #{cost} | #{count} | #{total_product_cost(cost, count)}"
    end
  end

  def show_total_cost
    sum = products.values.reduce(0) do |sum, product|
      sum += total_product_cost(product[:cost], product[:count])
      sum
    end
    puts "Итоговая стоимость корзины: #{sum}"
  end

  def total_product_cost(cost, count)
    cost * count
  end
end

basket = Basket.new

loop do
  puts "Введите через запятую название товара, цену за единицу товара " \
       "и количество купленного товара (Хлеб, 50, 2) или введите 'cтоп':"

  name, cost, count = gets.chomp.split(",").map(&:strip)

  break if name.downcase == 'стоп'

  basket.add(name, cost.to_f, count.to_f)
end

basket.show
