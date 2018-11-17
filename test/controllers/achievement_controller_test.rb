require 'test_helper'

class AchievementControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get achievement_new_url
    assert_response :success
  end

  test "should get create" do
    get achievement_create_url
    assert_response :success
  end

  test "should get index" do
    get achievement_index_url
    assert_response :success
  end

  test "should get show" do
    get achievement_show_url
    assert_response :success
  end

end
