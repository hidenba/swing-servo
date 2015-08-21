require 'dino'
require "swing_servo/version"

module SwingServo
  class Controller
    attr_reader :board, :yaw, :pitch, :yaw_pin, :pitch_pin

    def initialize(yaw_pin, pitch_pin)
      @yaw_pin = yaw_pin
      @pitch_pin = pitch_pin

      reset
    end

    def yawing(position)
      swing(yaw, position)
    end

    def pitching(position)
      swing(pitch, position)
    end

    def reset
      @board = Dino::Board.new(Dino::TxRx::Serial.new)
      @yaw = Dino::Components::Servo.new(pin: yaw_pin, board: board)
      @pitch = Dino::Components::Servo.new(pin: pitch_pin, board: board)

      swing(yaw, 0)
      swing(pitch, 0)
    end

    private

    def swing(servo, position)
      servo.position = position
    end
  end
end
