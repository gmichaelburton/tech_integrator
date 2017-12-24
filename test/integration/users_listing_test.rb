require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com", first_name: "Michael",
                       password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "burtm2", email: "burtm2@fordav.com",
                       password: "password", password_confirmation: "password")
    @admin_user = User.create!(username: "burtm3", email: "burtm3@fordav.com", first_name: "Michael",
                       password: "password", password_confirmation: "password", admin: true)
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
  end
  
   test "should delete user" do
    sign_in_as(@admin_user, "password") 
    get users_path
    assert_template 'users/index'
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
    assert_redirected_to users_path
    assert_not flash.empty?
  end
  
end
