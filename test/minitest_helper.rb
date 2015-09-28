$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'donut'

require 'minitest/autorun'

# Pass a block to play in the dummy filestructure
def in_dummy_project(&block)
  root = Dir.pwd
  Dir.chdir "#{root}/test/dummy"
  block.call
  Dir.chdir root
end
 

# Returns the output as an array of console
# logged lines. Also redirects stderr to stdout
def execute_command(command="donut")
  console = `#{command} 2>&1`
  console.split /\r?\n/
end

# Returns the exit status of the last system
# executed command. 0 / true is good, non-zero / false
# is bad.
def exit_status
  $?.exitstatus
end

def passing_install_donutfile_template
  [
    "class MyApp < Donut::App",
    "  def install",
    "    puts 'Attempting to install MyApp...'",
    "    run 'exit 0'",
    "    run 'exit 0'",
    "    puts 'MyApp successfully installed!'",
    "    run 'exit 0'",
    "  end",
    "end",
    "",
    "DONUTS = {",
    "  api: MyApp.new('api')",
    "}"
  ].join("\n")
end

def failing_install_donutfile_template
  [
    "class MyApp < Donut::App",
    "  def install",
    "    puts 'Attempting to install MyApp...'",
    "    puts 'Error! Installation of MyApp failed!'",
    "    run 'exit 1'",
    "    puts 'This should not run.'",
    "  end",
    "end",
    "",
    "DONUTS = {",
    "  api: MyApp.new('api')",
    "}"
  ].join("\n")
end

def dummy_donutfile_template
  [
    "DONUTS = {",
    "  api: Donut::App.new('api'),",
    "  frontend: Donut::App.new('frontend'),",
    "  backend: Donut::App.new('backend')",
    "}"
  ].join("\n")
end
