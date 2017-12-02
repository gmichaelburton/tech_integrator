require 'test_helper'

class ProjectsEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com",
                        password: "password", password_confirmation: "password")
    @project = Project.create(project_name: "Test Project", control_number: "123456", user: @user)
  end

  test "reject invalid project update" do
    get edit_project_path(@project)
    assert_template 'projects/edit'
    patch project_path(@project), params: { project: { project_name: " ", control_number: "12" } }
    assert_template 'projects/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "successfully edit a project" do
    get edit_project_path(@project)
    assert_template 'projects/edit'
    updated_project_name = "updated project name"
    updated_control_number = "123123"
    patch project_path(@project), params: { project: {project_name: updated_project_name, control_number: updated_control_number}}
    assert_redirected_to @project
    #follow_redirect!
    assert_not flash.empty?
    @project.reload
    assert_match updated_project_name, @project.project_name
    assert_match updated_control_number, @project.control_number
  end
end
