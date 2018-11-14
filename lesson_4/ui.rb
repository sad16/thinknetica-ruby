module UI
  def output(message)
    puts message
  end

  def input(message)
    output(message)
    gets.chomp
  end

  def delay
    output("Для продолжения нажмите enter")
    gets
  end
end
