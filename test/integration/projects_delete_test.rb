require 'test_helper'

class ProjectsDeleteTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com", first_name: "Michael",
                        password: "password", password_confirmation: "password")
    @project = Project.create(project_name: "Test Project", control_number: "123456", user: @user)
  end
  
  test "successfully delete a project" do
    sign_in_as(@user, "password")
    get project_path(@project)
    assert_template 'projects/show'
    assert_select 'a[href=?]', project_path(@project), text: "Delete this project"
    assert_difference 'Project.count', -1 do
      delete project_path(@project)
    end
    assert_redirected_to projects_path
    assert_not flash.empty?
  end
  
  
end
