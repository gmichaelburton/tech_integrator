require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  def setup #run before every test
    @user = User.create!(username: "burtm", email: "michael@fordav.com",
                        password: "password", password_confirmation: "password")
    @project = @user.projects.build(project_name: "New Test Project", control_number: "176787")
  end
  
  test "project without user should be invalid" do
    @project.user_id = nil
    assert_not @project.valid?
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