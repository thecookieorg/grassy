require 'test_helper'

class SlideshowsControllerTest < ActionController::TestCase
  setup do
    @slideshow = slideshows(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:slideshows)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create slideshow" do
    assert_difference('Slideshow.count') do
      post :create, slideshow: { image_1: @slideshow.image_1, image_2: @slideshow.image_2, image_3: @slideshow.image_3, image_4: @slideshow.image_4 }
    end

    assert_redirected_to slideshow_path(assigns(:slideshow))
  end

  test "should show slideshow" do
    get :show, id: @slideshow
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @slideshow
    assert_response :success
  end

  test "should update slideshow" do
    patch :update, id: @slideshow, slideshow: { image_1: @slideshow.image_1, image_2: @slideshow.image_2, image_3: @slideshow.image_3, image_4: @slideshow.image_4 }
    assert_redirected_to slideshow_path(assigns(:slideshow))
  end

  test "should destroy slideshow" do
    assert_difference('Slideshow.count', -1) do
      delete :destroy, id: @slideshow
    end

    assert_redirected_to slideshows_path
  end
end
