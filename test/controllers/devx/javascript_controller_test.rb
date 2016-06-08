require 'test_helper'

module Devx
  class JavascriptControllerTest < ActionController::TestCase
    setup do
      @routes = Engine.routes
    end

    test "should get show" do
      get :show
      assert_response :success
    end

  end
end
