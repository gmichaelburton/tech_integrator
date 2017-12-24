require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com", first_name: "Michael",
                        password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "burtm2", email: "burtm2@fordav.com", first_name: "Michael",
                       password: "password", password_confirmation: "password")
    @admin_user = User.create!(username: "burtm3", email: "burtm3@fordav.com", first_name: "Michael",
                       password: "password", password_confirmation: "password", admin: true)
  end
  
  test "reject an invalid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: " ", first_name: " ", last_name: " ",
                                        email: "burtm@fordav.com " } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    sign_in_as(@user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "burtm1", email: "burtm1@fordav.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "burtm1", @user.username
    assert_match  "burtm1@fordav.com", @user.email
  end
  
  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "newname", email: "new@fordav.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "newname", @user.username
    assert_match  "new@fordav.com", @user.email
    
  end
  
  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@user2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch user_path(@user), params: { user: { username: updated_name, email: updated_email } }
    assert_redirected_to users_path
    assert_not flash.empty?
    @user.reload
    assert_match "burtm", @user.username
    assert_match  "burtm@fordav.com", @user.email
  end
  
  
end

