require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup #run before every test
    @project = Project.new(project_name: "New Test Project", control_number: "176787")
  end
  
  test "project should be valid" do
    assert @project.valid?
  end
  
  test "project_name should be present" do
    @project.project_name = " "
    assert_not @project.valid?
  end
  
  test "control_number should be present" do
    @project.control_number = " "
    assert_not @project.valid?
  end
  
  test "control_number should not be less than 6 numbers" do
    @project.control_number = "1" * 3
    assert_not @project.valid?
  end
  
  test "control_number should not be more than 6 numbers" do
    @project.control_number = "1" * 7
    assert_not @project.valid?
  end
  
end