# frozen_string_literal: true

needs 'Liquid Handling Robot/AbstractRobot'

# Abstract PCR thermocycler
#
# @author Devin Strickland <strcklnd@uw.edu>
class TestLiquidHandlingRobot < AbstractRobot
  # CONSTANTS that really shouldn't ever change
  # Should be overridden in concrete class
  MODEL = 'Test Liquid Handling Robot'
  PROGRAM_EXT = '.testext'
  FILE_EXT = '.ext'
  COMPATIBLE_PROGRAMS = ['abstract program']
  COMPATIBLE_EXPORT_EXTENSIONS = ['.csv']

  attr_reader :name
  # Instantiates the class and sets the `@params` instance variable
  #
  # @return [Thermocycler]
  def initialize(protocol:, name: MODEL)
    super(protocol: protocol)
    self.name = name
  end

  # Lab-specific, user-defined parameters
  #
  # @note Should be overridden in concrete class
  # @return [Hash]
  def user_defined_params
    {
      acceptable_dimensions: [[8,12]]
    }
  end

  private

  def default_params
    params = {
      experiment_filepath: 'some_location',
      export_filepath: 'another location',
      image_path: 'whoa this is another path',
      setup_program_image: 'setup_program.png',
      start_run_image: 'start_run.png',
    }
  end

  def image_path(image_name:)
    File.join(params[:image_path], image_name)
  end

  def template_file(template_name:, extension:)
    if extension.present?
      (template_name + '.' + extension).gsub(/\.+/, '.')
    else
      template_name
    end
  end

  def format_show_array(ary)
    ary.join('<br>')
  end
end
