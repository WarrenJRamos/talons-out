require "application_system_test_case"

class FirmsTest < ApplicationSystemTestCase
  setup do
    sign_in_system_admin
    @firm = firms(:one)
    @client = clients(:one)
  end

  test "visiting the index" do
    visit firms_url
    assert_selector "h1", text: "Requests"
  end

  test "visit the index as a normal user" do
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

    visit firms_url
    assert_selector "h1", text: "Requests"
    end

    test "client is redirected if they don't have a client application" do
    visit logout_url
    sign_in_system_normal_without_client_applicationv2
    visit firms_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Firm" do
    visit firms_url
    click_on "New Request"

    #fill_in "Client request", with: @firm.client_request
    fill_in "Dl number", with: @firm.dl_number
    fill_in "Dl state", with: @firm.dl_state
    fill_in "Dob", with: @firm.dob
    fill_in "First name", with: @firm.first_name
    #fill_in "Invoice data", with: @firm.invoice_data
    fill_in "Last name", with: @firm.last_name
    fill_in "Maiden name", with: @firm.maiden_name
    fill_in "Middle name", with: @firm.middle_name
    fill_in "Notes", with: @firm.notes
    fill_in "Ssn", with: @firm.ssn
    click_on "Create Request"

    #assert_text "Firm was successfully created"
    assert_no_text "error"
    click_on "Back"
  end

  test "updating a Firm" do
    visit firms_url
    click_on "Edit", match: :first

    #fill_in "Client request", with: @firm.client_request
    fill_in "Dl number", with: @firm.dl_number
    fill_in "Dl state", with: @firm.dl_state
    fill_in "Dob", with: @firm.dob
    fill_in "First name", with: @firm.first_name
    #fill_in "Invoice data", with: @firm.invoice_data
    fill_in "Last name", with: @firm.last_name
    fill_in "Maiden name", with: @firm.maiden_name
    fill_in "Middle name", with: @firm.middle_name
    fill_in "Notes", with: @firm.notes
    fill_in "Ssn", with: @firm.ssn
    click_on "Create Request"

    #assert_text "Firm was successfully updated"
    assert_no_text "error"
    click_on "Back"
  end

  test "destroying a Firm" do
    visit firms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    #assert_text "Firm was successfully destroyed"
    assert_no_text "error"
  end

  test "make sure error messages appear if invalid firm is created" do
    visit new_firm_url
    click_on "Create Request"
    assert_selector "h2", text: /\A*errors*/
  end

  test "make sure error messages appear if updated firm is invalid" do
    visit firms_url
    click_on "Edit", match: :first
    fill_in "Ssn", with: ""
    fill_in "First name", with: ""
    fill_in "Dob", with: ""
    click_on "Create Request"
    assert_selector "h2", text: /\A*errors*/
  end

end
