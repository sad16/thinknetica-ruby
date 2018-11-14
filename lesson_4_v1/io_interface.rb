module IOInterface
  def output(message)
    puts message
  end

  def input
    gets.chomp
  end

  def delay
    output("Для продолжения нажмите enter")
    input
  end
end
