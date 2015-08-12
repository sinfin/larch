require 'test_helper'

class Admin::MenuItemsControllerTest < ActionController::TestCase
  setup do
    @menu_item = create(:menu_item)
    sign_in create(:user)
  end

  test "index" do
    get :index
    assert_response :success
    assert_equal 1,json[:menu_items].size
  end

  test "create" do
    assert_difference('MenuItem.count') do
      post :create, menu_item: attributes_for(:menu_item)
      assert_response :success, response.body.to_s
      assert_not_nil json[:menu_item][:id]
    end
  end

  test "update" do
    patch :update, id: @menu_item, menu_item: attributes_for(:menu_item)
    assert_response :success, response.body.to_s
  end

  test "destroy" do
    assert_difference('MenuItem.count', -1) do
      delete :destroy, id: @menu_item
      assert_response :success, response.body.to_s
    end
  end
end
