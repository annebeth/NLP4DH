require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "NLP4DH"
  end

  test "should get documentation" do
    get documentation_path
    assert_response :success
    assert_select "title", "Documentation | NLP4DH"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | NLP4DH"
  end

end
