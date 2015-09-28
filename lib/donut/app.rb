module Donut
  class App
    attr_accessor :name
    attr_reader :path

    def initialize(path)
      @path = path
    end

    # Install subproject
    #
    # @raise [RuntimeError]
    #   in case of failure
    #
    # @return [self]
    #   otherwise
    def install
      Logger.say :install_not_implemented, :note, @name
      self
    end
    
    # Serve the subproject
    #
    # @raise [RuntimeError]
    #   in case of failure
    #
    # @return [self]
    #   otherwise
    def serve 
      Logger.say :serve_not_implemented, :note, @name
      self
    end

    # Test subproject for passing its tests
    #
    # @return [Boolean]
    #   the success of the build
    def test
      Logger.say :test_not_implemented, :warning, @name
      true
    end

    # Deploy the subproject
    #
    # @return [Boolean]
    #   the success of the build
    def deploy
      Logger.say :deploy_not_implemented, :note, @name
      true
    end

    # Change to subproject directory and execute block
    #
    # @return [undefined]
    def chdir(&block)
      Dir.chdir "#{Donut::CLI::ROOT}/#{@path}", &block
    rescue Errno::ENOENT
      raise Donut::Error, Logger.build_message(:app_path_does_not_exist, @name)
    end
    
    private

    # Execute system command via execve
    #
    # No shell interpolation gets done this way. No escapes needed.
    #
    # @return [Boolean]
    #   the success of the system command
    def run(arguments)
      result = Kernel.system(*arguments)
      unless result
        raise Donut::Error, "#{Logger.build_message(:the_following_command_failed, "#{@name}/#{calling_method}")} #{arguments}"
      end
      result
    end

    def calling_method
      caller[1][/`.*'/][1..-2]
    end
  end
end
