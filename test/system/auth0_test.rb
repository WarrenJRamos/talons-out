require "application_system_test_case"

class Auth0Test < ApplicationSystemTestCase

  test "login" do
    sign_in_system_admin
  end


  test "login failure" do
    visit root_url
    OmniAuth.config.test_mode = true
    OmniAuth.config.on_failure = Proc.new { |env|
      OmniAuth::FailureEndpoint.new(env).redirect_to_failure
    }
    OmniAuth.config.mock_auth[:auth0] = :invalid_credentials
    click_on("Login", match: :first)
  end

  test "should visit auth_failure redirect and find Welcome text" do
    visit auth_failure_url
    assert_text /Talon Agency/
  end

  test "logout" do
    sign_in_system_admin
    visit logout_url
    assert_text /Talon Agency/
    #assert_response 302
  end

end