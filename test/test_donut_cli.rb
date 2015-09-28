require 'minitest_helper'

class TestDonutLogger < Minitest::Test

  def test_that_it_exists
    refute_nil ::Donut::CLI
  end

  def test_that_it_captures_the_root
    refute_nil ::Donut::CLI::ROOT
  end
  
  def test_that_it_outputs_its_commands
    in_dummy_project do
      actual_output = execute_command 'donut'

      expected_output = 
        ["Commands:",
        "  donut deploy          # Deploys you apps across the project, as per your Donutfile.",
        "  donut help [COMMAND]  # Describe available commands or one specific command",
        "  donut init            # Creates a Donutfile in the current directory.",
        "  donut install         # Runs installation commands across the project, as per your Donutfile.",
        "  donut serve           # Serves your project applications, as per your Donutfile.",
        "  donut test            # Runs tests across the project, as per your Donutfile."]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 0
    end
  end
  
  def test_that_it_can_create_a_donutfile
    in_dummy_project do 
      actual_output   = execute_command 'donut init'
      expected_output = ["Donut ~~~> : Donutfile.rb created!"]

      assert File.exist? "Donutfile.rb"
      assert_equal actual_output, expected_output
      assert_equal exit_status, 0

      File.delete "Donutfile.rb"
    end
  end
  
  def test_that_a_Donutfile_is_required
    in_dummy_project do 
      actual_output   = execute_command 'donut install'
      expected_output = ["Donut ~~~> : Donutfile.rb does not exist. Run \"donut init\" to get started."]

      assert_equal actual_output, expected_output
      assert_equal exit_status, 1
    end
  end
  
  def test_that_a_Donutfile_must_define_DONUTS
    in_dummy_project do 
      File.write "Donutfile.rb", "" 

      actual_output   = execute_command 'donut install'
      expected_output = ["Donut ~~~> : The DONUTS constant is not defined in your Donutfile.rb"]

      assert_equal actual_output, expected_output
      assert_equal exit_status, 1

      File.delete "Donutfile.rb"
    end
  end
  
  def test_that_a_Donutfile_must_define_DONUTS_as_a_Hash
    in_dummy_project do 
      File.write "Donutfile.rb", "DONUTS = :not_a_hash" 
      
      actual_output   = execute_command 'donut install'
      expected_output = ["Donut ~~~> : The DONUTS constant in your Donutfile.rb must be a Ruby Hash."]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 1

      File.delete "Donutfile.rb"
    end
  end
  
  def test_that_DONUTS_Hash_entries_must_be_donut_apps
    in_dummy_project do 
      File.write "Donutfile.rb", "DONUTS = { api: :not_a_donut_app_descendent }" 
      
      actual_output   = execute_command 'donut install'
      expected_output = ["Donut ~~~> api: Entry in Donutfile.rb does not descend from Donut::App"]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 1

      File.delete "Donutfile.rb"
    end
  end
  
  def test_that_it_sets_the_Donut_App_name_from_Donutfile_Hash
    in_dummy_project do 
      File.write "Donutfile.rb", "DONUTS = { api: Donut::App.new('api') }" 
      
      actual_output   = execute_command 'donut install'
      expected_output = ["Donut ~~~> api: Install command not implemented."]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 0

      File.delete "Donutfile.rb"
    end
  end
  
  def test_that_it_fails_fast_from_failed_app_commands
    in_dummy_project do 
      File.write "Donutfile.rb", failing_install_donutfile_template
      
      actual_output   = execute_command 'donut install'
      
      expected_output = [
        "Attempting to install MyApp...", 
        "Error! Installation of MyApp failed!",
        "Donut ~~~> api/install: Failure at command: exit 1"
      ]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 1

      File.delete "Donutfile.rb"
    end
  end
 
  def test_that_it_returns_correctly_from_passed_app_commands
    in_dummy_project do 
      File.write "Donutfile.rb", passing_install_donutfile_template
      
      actual_output   = execute_command 'donut install'
      expected_output = [
        "Attempting to install MyApp...", 
        "MyApp successfully installed!"
      ]
      
      assert_equal actual_output, expected_output
      assert_equal exit_status, 0

      File.delete "Donutfile.rb"
    end
  end

end
