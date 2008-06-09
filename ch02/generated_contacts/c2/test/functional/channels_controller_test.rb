require 'test_helper'

class ChannelsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:channels)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_channel
    assert_difference('Channel.count') do
      post :create, :channel => { }
    end

    assert_redirected_to channel_path(assigns(:channel))
  end

  def test_should_show_channel
    get :show, :id => channels(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => channels(:one).id
    assert_response :success
  end

  def test_should_update_channel
    put :update, :id => channels(:one).id, :channel => { }
    assert_redirected_to channel_path(assigns(:channel))
  end

  def test_should_destroy_channel
    assert_difference('Channel.count', -1) do
      delete :destroy, :id => channels(:one).id
    end

    assert_redirected_to channels_path
  end
end
