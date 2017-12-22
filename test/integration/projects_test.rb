require 'test_helper'

class ProjectsTest < ActionDispatch::IntegrationTest
 
 def setup
   @user = User.create!(username: "burtm", email: "burtm@fordav.com", first_name: "Michael",
                       password: "password", password_confirmation: "password")
   @project = Project.create(project_name: "Test Project", control_number: "123456", user: @user)
   @project2 = @user.projects.build(project_name: "Cool Hawaii Project", control_number: "654321")
   @project2.save
 end
 
  test "should get projects index" do
    get projects_path
    assert_response :success
 end
 
  test "should get project listing" do
    get projects_path
    assert_template 'projects/index'
    assert_select "a[href=?]", project_path(@project), text: @project.project_name
    assert_select "a[href=?]", project_path(@project2), text: @project2.project_name
  end
 
  test "should get project show" do
   sign_in_as(@user, "password")
   get project_path(@project)
   assert_template 'projects/show'
   assert_match @project.project_name.capitalize, response.body
   assert_match @project.control_number, response.body
   assert_match @user.username, response.body
   assert_select 'a[href=?]', edit_project_path(@project), text: "Edit this project"
   assert_select 'a[href=?]', project_path(@project), text: "Delete this project"
   assert_select 'a[href=?]', projects_path, text: "Return to projects listing"
  
  end
 
  test "create new valid project" do
    sign_in_as(@user, "password")
     get new_project_path
     assert_template 'projects/new'
     name_of_project = "sample project"
     control_number_of_project = "123123"
     assert_difference 'Project.count', 1 do
      post projects_path, params: { project: { project_name: name_of_project, control_number: control_number_of_project }}
     end
     follow_redirect!
     assert_match name_of_project, response.body.capitalize
     assert_match control_number_of_project, response.body
   end
  
 test "reject invalid project submissions" do
    sign_in_as(@user, "password")
    get new_project_path
    assert_template 'projects/new'
    assert_no_difference 'Project.count' do
     post projects_path, params: { project: { project_name: " ", control_number: " " }}
    end
    assert_template 'projects/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end 
 
end
