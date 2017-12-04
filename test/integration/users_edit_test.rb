require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.create!(username: "burtm", email: "burtm@fordav.com",
                        password: "password", password_confirmation: "password")
  end
  
  test "reject an invalid edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: " ", first_name: " ", last_name: " ",
                                        email: "burtm@fordav.com " } }
    assert_template 'users/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { username: "burtm1", email: "burtm1@fordav.com" } }
    assert_redirected_to @user
    assert_not flash.empty?
    @user.reload
    assert_match "burtm1", @user.username

    assert_match  "burtm1@fordav.com", @user.email
  end
end
