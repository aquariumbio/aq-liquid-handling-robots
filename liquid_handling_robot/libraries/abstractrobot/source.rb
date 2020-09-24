# frozen_string_literal: true

needs 'Standard Libs/Units'

# Abstract PCR thermocycler
#
# @author Devin Strickland <strcklnd@uw.edu>
class AbstractRobot

  include Units

  # CONSTANTS that really shouldn't ever change
  # Should be overridden in concrete class
  MODEL = 'Abstract Model'
  PROGRAM_EXT = '.abext'
  FILE_EXT = '.ext'
  COMPATIBLE_PROGRAMS = ['abstract program']
  COMPATIBLE_EXPORT_EXTENSIONS = ['.csv']

  attr_reader :params, :protocol
  attr_accessor :name

  # Instantiates the class and sets the `@params` instance variable
  #
  # @return [Thermocycler]
  def initialize(protocol:)
    @params = default_params.update(user_defined_params)
    @name = 'Abstract Name'
    @model = MODEL
    @protocol = protocol
  end

  # Lab-specific, user-defined parameters
  #
  # @note Should be overriden in concrete class
  # @return [Hash]
  def user_defined_params
    {}
  end

  ########## Language Methods
  # These methods are not very specific and will probably need to be overridden
  #   in the concrete classes.

  # Instructions for turning on the thermocycler
  #
  # @return [String]
  def turn_on
    robo_name = model_and_name
    protocol.show do
      title 'Turn on Robot'
      note "Turn on the liquid handling robot <b>#{robo_name}</b>"
    end
  end

  # Instructions for placing a plate in the instrument
  #
  # @param plate [Collection]
  # @return [String]
  def place_item(item:)
    robo_name = model_and_name
    protocol.show do
      title 'Place Items on Robot'
      note "Place item #{item} in the <b>#{robo_name}</b>"
    end
  end

  # Instructions for removing a plate in the instrument
  #
  # @param plate [Collection]
  # @return [String]
  def remove_item(item:)
    robo_name = model_and_name
    protocol.show do
      title 'Remove Items from Robot'
      note "Remove item #{item} from the <b>#{robo_name}</b>"
    end
  end

  # Instructions for confirming the orientation of a plate in the instrument
  #
  # @return [String]
  def confirm_orientation
    protocol.show do
      title 'Confirm orientation'
      warning 'MAKE SURE THAT THE PLATE IS IN THE CORRECT ORIENTATION'
    end
  end

  # Instructions for selecting the PCR program template
  #
  # @param program [PCRProgram]
  # @return [String]
  def select_program_template(program:)
    file = program_template_file(program: program)
    protocol.show do
      title 'Select Program Template'
      note "Choose the program template <b>#{file}</b>"
    end
  end

  # Instructions for starting the run
  #
  # @return [String]
  def start_run
    protocol.show do
      title 'Start Robot'
      note 'Click the <b>Start Run</b> button'
    end
  end

  # Save run
  #
  # @param path [String] path to file
  # @param file_name [String] name of file
  def save_run(path:, file_name:)
    ext = file_ext
    protocol.show do
      title 'Save Run'
      note "Please save run at <b>#{path}#{file_name}#{ext}</b>"
    end
  end

  def export_measurement_files(path:, ext:, file_name:)
    ext ||= default_extension
    protocol.show do
      title 'Export Measurement Files'
      note "Export files to <b>#{path}#{file_name}#{ext}</b>"
    end
  end

  # TODO
  def load_media(program: program)

  end

  def default_extension
    compatible_export_ext.first
  end

  ########## Image Methods
  # These probably should NOT be overridden in the concrete classes
 
  # Image for selecting the PCR program template in the software
  #
  # @return [String]
  def setup_program_image
    image_path(image_name: params[:setup_program_image])
  end

  # Image for starting the run
  #
  # @return [String]
  def start_run_image
    image_path(image_name: params[:start_run_image])
  end

  def check_supplies(items: nil, consumables: nil)
    check_samples(items: items) if items
    check_consumables(consumables: consumables) if consumables
  end

  ########## Template File Methods
  # These probably should NOT be overridden in the concrete classes

  def program_template_file(program:)
    template_file(
      template_name: program.program_template_name,
      extension: program_ext
    )
  end

  ########## Compatibility Methods
  # these probably should NOT be overridden in the concrete classes
  def check_program(program)
    compatible_programs.include? (program.name)
  end

  ########## Getter Methods
  # These should NOT be overridden in the concrete classes

  # The model of the thermocycler
  #
  # @return [String]
  def model
    self.class.const_get(:MODEL)
  end

  def file_ext
    self.class.const_get(:FILE_EXT)
  end

  def program_ext
    self.class.const_get(:PROGRAM_EXT)
  end

  def compatible_export_ext
    self.class.const_get(:COMPATIBLE_EXPORT_EXTENSIONS)
  end

  def compatible_programs
    self.class.const_get(:COMPATIBLE_PROGRAMS)
  end

  def model_and_name
    "#{model}-#{name}"
  end
  
  private

  def check_samples(items:)
    tab = Table.new(a: 'Sample Name', b: 'Item ID', c: 'Min Quantity')
    items.each do |item_hash|
      item = item_hash[:obj]
      qty = item_hash[:qty]
      tab.a(item.sample.name).b(item.id).c(qty_display(qty)).append
    end

    protocol.show do
      title 'Check Sample Quantities'
      note 'Check that there is sufficient quantity of items below'
      table tab.all.render
    end
  end

  def check_consumables(consumables:)
    tab = Table.new(a: 'Sample Name', b: 'Min Quantity')
    consumables.each do |consumables|
      obj = consumables[:obj]
      qty = consumables[:qty]
      tab.a(obj).b(qty_display(qty)).append
    end

    protocol.show do
      title 'Check Consumable Quantities'
      note 'Check that there is sufficient quantity of consumables below'
      table tab.all.render
    end
  end

  def default_params
    params = {
      experiment_filepath: '',
      export_filepath: '',
      image_path: '',
      setup_program_image: 'setup_program.png',
      start_run_image: 'start_run.png'
    }
  end

  def image_path(image_name:)
    File.join(params[:image_path], image_name)
  end

  def template_file(template_name:, extension:)
    ext = self.class.const_get(extension)
    if extension.present?
      (template_name + '.' + ext).gsub(/\.+/, '.')
    else
      template_name
    end
  end

  def format_show_array(ary)
    ary.join('<br>')
  end
end