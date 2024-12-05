require "application_system_test_case"

class FormTablesTest < ApplicationSystemTestCase
  setup do
    @form_table = form_tables(:one)
  end

  test "visiting the index" do
    visit form_tables_url
    assert_selector "h1", text: "Form tables"
  end

  test "should create form table" do
    visit form_tables_url
    click_on "New form table"

    fill_in "Description", with: @form_table.description
    fill_in "Name", with: @form_table.name
    check "Processed in job" if @form_table.processed_in_job
    fill_in "User", with: @form_table.user_id
    click_on "Create Form table"

    assert_text "Form table was successfully created"
    click_on "Back"
  end

  test "should update Form table" do
    visit form_table_url(@form_table)
    click_on "Edit this form table", match: :first

    fill_in "Description", with: @form_table.description
    fill_in "Name", with: @form_table.name
    check "Processed in job" if @form_table.processed_in_job
    fill_in "User", with: @form_table.user_id
    click_on "Update Form table"

    assert_text "Form table was successfully updated"
    click_on "Back"
  end

  test "should destroy Form table" do
    visit form_table_url(@form_table)
    click_on "Destroy this form table", match: :first

    assert_text "Form table was successfully destroyed"
  end
end
