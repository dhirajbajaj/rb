require 'test_helper'

class FriendsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Friend.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Friend.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Friend.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to friend_url(assigns(:friend))
  end

  def test_edit
    get :edit, :id => Friend.first
    assert_template 'edit'
  end

  def test_update_invalid
    Friend.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Friend.first
    assert_template 'edit'
  end

  def test_update_valid
    Friend.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Friend.first
    assert_redirected_to friend_url(assigns(:friend))
  end

  def test_destroy
    friend = Friend.first
    delete :destroy, :id => friend
    assert_redirected_to friends_url
    assert !Friend.exists?(friend.id)
  end
end
