module Donut
  module Utils
    module Donutfile
      private
      # Check if Donutfile.rb exists in the PWD 
      #
      # @return [Boolean]
      #   a boolean whether the donutfile already exists
      def donutfile_exists?
        File.exist? "#{Donut::CLI::ROOT}/Donutfile.rb"
      end

      # Load the Donutfile.rb and validate it is correctly
      # formatted.
      #
      # @return [Boolean]
      #   a boolean as to whether the donutfile is valid
      def load_and_validate_donutfile
        raise Donut::Error, Logger.build_message(:donutfile_missing) unless donutfile_exists?

        load_donutfile

        raise Donut::Error, Logger.build_message(:donuts_is_undefined) unless defined? DONUTS
        raise Donut::Error, Logger.build_message(:donuts_is_not_a_hash)  unless DONUTS.is_a? Hash

        DONUTS.each do |name, app|
          raise Donut::Error, Logger.build_message(:app_is_not_a_donut, name) unless app.kind_of? Donut::App
          app.name = name
        end
      end
      
      # The default template for the Donutfile.rb
      #
      # @return [String]
      #   a multiline string to be written to the new Donutfile.rb
      def donutfile_template
        [
          "DONUTS = {",
          "  api: Donut::App.new('path/to/api')",
          "}"
        ].join("\n")
      end
      
      # Create a Donutfile at the Root of the Command
      #
      # @return [Boolean]
      #   the success of the command
      def create_donutfile 
        File.write "#{Donut::CLI::ROOT}/Donutfile.rb", donutfile_template
      end

      # Load the Donutfile.rb into memory, and thus the DONUTS Variable
      #
      # @return [Boolean]
      #   the success of the command
      def load_donutfile
        load "#{Donut::CLI::ROOT}/Donutfile.rb"
      end

    end
  end
end
