require_relative "../railway"
require_relative "../interfaces/train_interface"

TrainInterface.new(Railway.new).start
