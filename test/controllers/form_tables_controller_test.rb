require "test_helper"

class FormTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_table = form_tables(:one)
  end

  test "should get index" do
    get form_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_form_table_url
    assert_response :success
  end

  test "should create form_table" do
    assert_difference("FormTable.count") do
      post form_tables_url, params: { form_table: { description: @form_table.description, name: @form_table.name, processed_in_job: @form_table.processed_in_job, user_id: @form_table.user_id } }
    end

    assert_redirected_to form_table_url(FormTable.last)
  end

  test "should show form_table" do
    get form_table_url(@form_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_table_url(@form_table)
    assert_response :success
  end

  test "should update form_table" do
    patch form_table_url(@form_table), params: { form_table: { description: @form_table.description, name: @form_table.name, processed_in_job: @form_table.processed_in_job, user_id: @form_table.user_id } }
    assert_redirected_to form_table_url(@form_table)
  end

  test "should destroy form_table" do
    assert_difference("FormTable.count", -1) do
      delete form_table_url(@form_table)
    end

    assert_redirected_to form_tables_url
  end
end
