require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
   @user = User.create!(username: "burtm", email: "burtm@fordav.com",
                       password: "password", password_confirmation: "password")
   @project = Project.create(project_name: "Test Project", control_number: "123456", user: @user)
   @project2 = @user.projects.build(project_name: "Cool Hawaii Project", control_number: "654321")
   @project2.save
  end
  
  test "should get users show" do
   get user_path(@user)
   assert_template 'users/show'
   assert_select "a[href=?]", project_path(@project), text: @project.project_name
   assert_select "a[href=?]", project_path(@project2), text: @project2.project_name
   assert_match @project.project_name, response.body
   assert_match @project2.project_name, response.body
   assert_match @user.username, response.body
   
   
  
  end
  
end
