require 'test_helper'

class UsersListingTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com",
                       password: "password", password_confirmation: "password")
    @user2 = User.create!(username: "burtm2", email: "burtm2@fordav.com",
                       password: "password", password_confirmation: "password")
  end
  
  test "should get users listing" do
    get users_path
    assert_template 'users/index'
    assert_select "a[href=?]", user_path(@user), text: @user.username.capitalize
    assert_select "a[href=?]", user_path(@user2), text: @user2.username.capitalize
  end
  
end
