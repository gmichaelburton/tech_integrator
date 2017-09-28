require 'test_helper'

class ProjectsTest < ActionDispatch::IntegrationTest
 
 def setup
   @user = User.create!(username: "burtm", email: "burtm@fordav.com")
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
 
 test "should get recipes show" do
  get project_path(@project)
  assert_template 'projects/show'
  assert_match @project.project_name, response.body
  assert_match @project.control_number, response.body
  assert_match @user.username, response.body
  
 end
 
end
