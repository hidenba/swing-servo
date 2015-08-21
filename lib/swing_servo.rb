require 'dino'
require "swing_servo/version"

module SwingServo
  class Controller
    attr_reader :board, :yaw, :pitch, :yaw_pin, :pitch_pin

    RESET_POSITION = 90

    def initialize(yaw_pin, pitch_pin)
      @yaw_pin = yaw_pin
      @pitch_pin = pitch_pin

      reset
    end

    def yawing(position)
      pos = position < 10 ? 10 : position
      swing(yaw, pos)
    end

    def pitching(position)
      swing(pitch, position)
    end

    def reset
      @board = Dino::Board.new(Dino::TxRx::Serial.new)
      @yaw = Dino::Components::Servo.new(pin: yaw_pin, board: board)
      @pitch = Dino::Components::Servo.new(pin: pitch_pin, board: board)

      swing(yaw, RESET_POSITION)
      swing(pitch, RESET_POSITION)
    end

    private

    def swing(servo, position)
      servo.position = position
    end
  end
end
