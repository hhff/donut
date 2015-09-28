require 'thor'
require 'donut/utils/donutfile'
require 'donut/utils/runner'

module Donut
  class CLI < Thor
    include Donut::Utils::Donutfile
    include Donut::Utils::Runner

    ROOT = Dir.pwd.freeze

    def self.exit_on_failure?
      true
    end

    desc 'init', 'Creates a Donutfile in the current directory.'
    def init
      if donutfile_exists?
        Logger.say :donutfile_exists, :warn
      else
        create_donutfile
        Logger.say :donutfile_created, :success
      end
    end

    desc 'install', 'Runs installation commands across the project, as per your Donutfile.'
    def install
      load_and_validate_donutfile
      run_command_on_donuts 'install'
      Dir.chdir Donut::CLI::ROOT
    end
    
    desc 'serve', 'Serves your project applications, as per your Donutfile.'
    def serve
      load_and_validate_donutfile
      run_command_on_donuts 'serve'
      Dir.chdir Donut::CLI::ROOT
    end
    
    desc 'test', 'Runs tests across the project, as per your Donutfile.'
    def test 
      load_and_validate_donutfile
      run_command_on_donuts 'test'
      Dir.chdir Donut::CLI::ROOT
    end

    desc 'deploy', 'Deploys you apps across the project, as per your Donutfile.'
    def deploy
      load_and_validate_donutfile
      run_command_on_donuts 'deploy'
      Dir.chdir Donut::CLI::ROOT
    end
  end
end
