module Donut
  class Logger
    class << self

      # Log the output to the console and in the case of an 
      # error, return an exit code.
      #
      # @return [Boolean]
      #   returns true unless it's type=:error
      def say(key, type=:note, context="")
        #TODO - Use Rainbows to Log here.
        puts build_message(key, context)
      end

      def build_message(key, context="")
        "Donut ~~~> #{context}: #{messages[key]}"
      end

      private

      ## TODO: Move this to a YML File
      def messages
        {
          donutfile_exists:     'Donutfile.rb already exists.',
          donutfile_created:    'Donutfile.rb created!',
          donutfile_missing:    'Donutfile.rb does not exist. Run "donut init" to get started.',
          donuts_is_undefined:  'The DONUTS constant is not defined in your Donutfile.rb',
          donuts_is_not_a_hash: 'The DONUTS constant in your Donutfile.rb must be a Ruby Hash.',
          app_is_not_a_donut:   'Entry in Donutfile.rb does not descend from Donut::App',

          install_not_implemented: 'Install command not implemented.',
          serve_not_implemented:   'Serve command not implemented.',
          test_not_implemented:    'Test command not implemented.',
          deploy_not_implemented:  'Deploy command not implemented.',
          app_path_does_not_exist: 'Path does not exist.',

          the_following_command_failed: 'Failure at command:'
        }
      end

    end
  end
end
