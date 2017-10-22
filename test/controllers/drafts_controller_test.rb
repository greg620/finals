require 'test_helper'

class DraftsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get drafts_destroy_url
    assert_response :success
  end

end
