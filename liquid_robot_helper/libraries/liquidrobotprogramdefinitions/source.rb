# frozen_string_literal: true

needs 'Standard Libs/Units'

module LiquidRobotProgramDefinitions

  include Units

  PROGRAMS = {
    'abstract program' => {
      program_template_name: 'abstract_template',
      run_file_path: 'abstract/file/path/',
      export: { file_path: 'abstract/file/path/export',
                extension: '.csv',
                num_files: 1 }
    },

    ############ Mosquito Typical Programs ##############

    'Anneal RNA and FS Synthesis' => {
      program_template_name: 'Anneal RNA and FS Synthesis',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'anneal_rna_protocol.png',
      param: []
    },

    'Amplify CDNA' => {
      program_template_name: 'Amplify CDNA',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Amplify_CDNA.png',
      param: []
    },

    'Tagment PCR Amplicons' => {
      program_template_name: 'Tagment PCR Amplicons',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Tagment PCR Amplicons',
      param: []
    },

    'Post Tagmentation Clean Up' => {
      program_template_name: 'Post Tagmentation Clean Up',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Post Tagmentation Clean Up',
      param: []
    },

    'Amplify Tagmented Amplicons' => {
      program_template_name: 'Amplify Tagmented Amplicons',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Amplify Tagmented Amplicons',
      param: []
    },

    'Amplify Tagmented Amplicons Index Plate' => {
      program_template_name: 'Amplify Tagmented Amplicons Index Plate',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Amplify Tagmented Amplicons Index Plate',
      param: []
    },

    'Pool and Clean Up Libraries' => {
      program_template_name: 'Pool and Clean Up Libraries',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'Pool and Clean Up Libraries',
      param: []
    },

    ##### Dragon Typical Programs ####

    'EP3_HT' => {
      program_template_name: 'EP3_HT',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'EP3_HT.png',
      param: []
    },

    'FS CDNA MM' => {
      program_template_name: 'FS CDNA MM',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'FS_CDNA_MM.png',
      param: []
    },

    'PCR 1 MM' => {
      program_template_name: 'PCR 1 MM',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'PCR_1_MM.png',
      param: []
    },

    'PCR 2 MM' => {
      program_template_name: 'PCR 2 MM',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'PCR_2_MM.png',
      param: []
    },

    'TAG_MM' => {
      program_template_name: 'TAG MM',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'TAG_MM.png',
      param: []
    },

    'TWB_HT' => {
      program_template_name: 'TWB HT',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'TWB_HT.png',
      param: []
    },

    'ST2_HT' => {
      program_template_name: 'ST2 HT',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'ST2_HT.png',
      param: []
    },

    'PCR_MM' => {
      program_template_name: 'PCR MM',
      run_file_path: 'load -> CovidSeq File ->',
      export: nil,
      program_image: 'PCR_MM.png',
      param: []
    },



  }

end