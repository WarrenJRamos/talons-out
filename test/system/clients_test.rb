require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    sign_in_system_admin
    @client = clients(:one)
  end

  test "visiting show as admin user" do
    visit client_url(@client)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "gets redirected when trying to access a show page that doesn't belong to the current user" do
    visit logout_url
    sign_in_system_normal_without_client_applicationv2

    visit client_url(@client)
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit logout_url
    sign_in_system_normal_without_client_application
    visit clients_url
    click_on "New Client"

    fill_in "Address", with: @client.address
    fill_in "City", with: @client.city
    fill_in "Client", with: @client.client_id
    fill_in "Client name", with: @client.client_name
    fill_in "Company", with: @client.company
    fill_in "Email", with: "noemail@test.com"
    fill_in "Fax", with: @client.fax
    fill_in "Notes", with: @client.notes
    fill_in "Phone", with: @client.phone
    fill_in "State", with: @client.state
    #check "Activate" if @client.status
    #fill_in "Total requests", with: @client.total_requests
    fill_in "Zip", with: @client.zip
    click_on "Save Client"

    #assert_text "Client was successfully created"
    assert_no_text "error"
    click_on "Back"
  end

  # test "normal user creating a Client" do
  #   visit logout_url
  #   sign_in_system_normal
  #   visit clients_url
  #   click_on "New Client"

  #   fill_in "Address", with: @client.address
  #   fill_in "City", with: @client.city
  #   fill_in "Client", with: @client.client_id
  #   fill_in "Client name", with: "Sara Brilliance"
  #   fill_in "Company", with: @client.company
  #   fill_in "Email", with: "test@test.com"
  #   fill_in "Fax", with: @client.fax
  #   fill_in "Notes", with: @client.notes
  #   fill_in "Phone", with: @client.phone
  #   fill_in "State", with: @client.state
  #   #fill_in "Total requests", with: @client.total_requests
  #   fill_in "Zip", with: @client.zip
  #   click_on "Save Client"

  #   #assert_text "Client was successfully created"
  #   assert_no_text "error"
  #   click_on "Back"
  # end

  test "should give an error if creating a blank client" do
    visit new_client_url
    click_on "Save Client"
    assert_text /error/
  end

  # test "should redirect to clients page for users with no clients" do
  #   visit logout_url
  #   sign_in_system_normal
  #   visit client_url(@client)
  #   assert_selector "h1", text: "Clients"
  # end

  test "updating a Client" do
    visit logout_url
    sign_in_system_normal_without_client_application
    visit new_client_url
    fill_in "Address", with: @client.address
    fill_in "City", with: @client.city
    fill_in "Client", with: @client.client_id
    fill_in "Client name", with: "Sara Brilliance"
    fill_in "Company", with: @client.company
    fill_in "Email", with: "noemail@test.com"
    fill_in "Fax", with: @client.fax
    fill_in "Notes", with: @client.notes
    fill_in "Phone", with: @client.phone
    fill_in "State", with: @client.state
    #fill_in "Total requests", with: @client.total_requests
    fill_in "Zip", with: @client.zip
    click_on "Save Client"
    #assert_text "Client was successfully created"
    assert_no_text "error"
    click_on "Back"


    visit clients_url
    click_on "Edit", match: :first
    fill_in "Address", with: @client.address
    fill_in "City", with: @client.city
    fill_in "Client", with: @client.client_id
    fill_in "Client name", with: "UPDATED NAME"
    fill_in "Company", with: @client.company
    fill_in "Email", with: "noemail@test.com"
    fill_in "Fax", with: @client.fax
    fill_in "Notes", with: @client.notes
    fill_in "Phone", with: @client.phone
    fill_in "State", with: @client.state
    #fill_in "Total requests", with: @client.total_requests
    fill_in "Zip", with: @client.zip
    click_on "Save Client"
    #assert_text "Client was successfully updated"
    assert_no_text "error"
    click_on "Back"
  end

  test "should give an error if name and email are blank when updating a client" do
    visit clients_url
    click_on "Edit", match: :first
    fill_in "Client name", with: ""
    click_on "Save Client"
    assert_text /error/
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    #assert_text "Client was successfully destroyed"
    assert_no_text "error"
  end
end
