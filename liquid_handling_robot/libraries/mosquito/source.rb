# frozen_string_literal: true

needs 'Standard Libs/Units'
needs 'Liquid Handling Robot/AbstractRobot'

# Abstract PCR thermocycler
#
# @author Devin Strickland <strcklnd@uw.edu>
class Mosquito < AbstractRobot

  include Units

  # CONSTANTS that really shouldn't ever change
  # Should be overridden in concrete class
  MODEL = 'Mosquito'
  PROGRAM_EXT = '.mos'
  FILE_EXT = '.csv'
  COMPATIBLE_PROGRAMS = ['abstract program', 'Anneal RNA and FS Synthesis']
  COMPATIBLE_EXPORT_EXTENSIONS = ['.csv']

  attr_reader :params, :protocol
  attr_accessor :name

  # Instantiates the class and sets the `@params` instance variable
  #
  # @return [Thermocycler]
  def initialize(protocol:)
    @params = default_params.update(user_defined_params)
    @name = 'Mosquito Liquid Handling Robot'
    @model = MODEL
    @protocol = protocol
  end

  # Lab-specific, user-defined parameters
  #
  # @note Should be overriden in concrete class
  # @return [Hash]
  def user_defined_params
    {
      experiment_filepath: '',
      export_filepath: '',
      image_path: 'specific_path', #TODO DEFIND THIS PATH
      start_run_image: 'start_run.png',
      turn_on_image: 'turn_on.png'
    }
  end

  ########## Language Methods
  # These methods are not very specific and will probably need to be overridden
  #   in the concrete classes.


  def model_and_name
    "<b>#{model}</b>"
  end
end
