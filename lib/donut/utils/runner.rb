module Donut
  module Utils
    module Runner 
      private
      # Run the command on the DONUTS Constant.
      #
      # @return [Boolean]
      #   TODO
      def run_command_on_donuts(command='install')
        DONUTS.each do |name, app|
          app.chdir
          app.send command
        end
      end
    end
  end
end
