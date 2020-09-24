# frozen_string_literal: true

needs 'Liquid Robot Helper/LiquidRobotProgramDefinitions'

class LiquidRobotProgramFactory
  include LiquidRobotProgramDefinitions

  def self.build(program_name:)
    program = PROGRAMS[program_name]

    if program.nil?
      msg = "Invalid program_name #{program_name}"
      raise InvalidProgramName, msg
    end

    LiquidRobotProgram.new(program: program, name: program_name)
  end
end


class LiquidRobotProgram
  attr_reader :name, :program_template_name, :run_file_path, :export

  def initialize(program:, name:)
    @program_template_name = program[:program_template_name]
    @run_file_path = program[:run_file_path]
    @export = program[:export]
    @name = name
  end

end

class InvalidProgramName < ProtocolError; end
