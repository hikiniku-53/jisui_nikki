require 'test_helper'

class Public::PricesControllerTest < ActionDispatch::IntegrationTest
  test 'should get create' do
    get public_prices_create_url
    assert_response :success
  end

  test 'should get update' do
    get public_prices_update_url
    assert_response :success
  end
end
