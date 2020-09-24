# frozen_string_literal: true

needs 'Liquid Handling Robot/TestLiquidHandlingRobot'
needs 'Liquid Handling Robot/QIASymphony'
needs 'Liquid Robot Helper/LiquidRobotProgram'
needs 'Liquid Robot Helper/LiquidRobotConstants'

module RobotHelper

  include LiquidRobotConstants
  
  def check_robot_compatibility(input_object:, robot:, program: nil)
    if program
      return false unless robot.check_program(program)
    end

    if input_object.is_a? Collection
      check_collection_compatibility(input_collection: input_object,
                                            robot: robot)
    elsif input_object.is_a? Item
      check_item_compatibility(input_item: input_item,
                                      robot: robot)
    else
      msg = 'Input object is neither Item nor Collection'
      raise CompatibilityError, msg
    end
  end



  def check_collection_compatibility(input_collection:, robot:)
    true
  end

  def check_item_compatibility(input_item:, robot:)
    true
  end


end

# Factory class for building thermocycler objects
#
# @author Devin Strickland <strcklnd@uw.edu>
class LiquidRobotFactory
    # Instantiates a new `Thermocycler`
    #
    # @param model [String] the `MODEL` of the thermocycler. Must match the
    #   constant `MODEL` in an exisiting thermocycler class.
    # @return [Thermocycler]
    def self.build(model:, name: nil, protocol:)
      case model
      when TestLiquidHandlingRobot::MODEL
        TestLiquidHandlingRobot.new(name: name, protocol: protocol)
      else
        msg = "Unrecognized Liquid Handling Robot Model: #{model}"
        raise LiquidRobotFactoryInputError, msg
      end
    end
end
  
class LiquidRobotFactoryInputError < ProtocolError; end
class CompatibilityError < ProtocolError; end