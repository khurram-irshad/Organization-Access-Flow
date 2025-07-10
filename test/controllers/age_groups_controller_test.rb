require "test_helper"

class AgeGroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get age_groups_index_url
    assert_response :success
  end

  test "should get show" do
    get age_groups_show_url
    assert_response :success
  end

  test "should get new" do
    get age_groups_new_url
    assert_response :success
  end

  test "should get create" do
    get age_groups_create_url
    assert_response :success
  end

  test "should get edit" do
    get age_groups_edit_url
    assert_response :success
  end

  test "should get update" do
    get age_groups_update_url
    assert_response :success
  end

  test "should get destroy" do
    get age_groups_destroy_url
    assert_response :success
  end
end
