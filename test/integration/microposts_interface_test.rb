require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "should display the right micropost count" do
    get root_path
    assert_match "#{Micropost.count} microposts", response.body
  end

  test "should use proper pluralization for zero microposts" do
    log_in_as(users(:malory))
    get root_path
    assert_match "0 microposts", response.body
  end

  test "should use proper pluralization for one micropost" do
    log_in_as(users(:lana))
    get root_path
    assert_match "1 micropost", response.body
  end
end

class ImageUploadTest < MicropostsInterfaceTest
  test "should have a file input field for images" do
    get root_path
    assert_select 'input[type=file]'
  end

  test "should be able to attach an image" do
    content = "This micropost really ties the room together."
    image = fixture_file_upload('kitten.jpg', 'image/jpeg')
    post microposts_path, params: { micropost: { content: content, image: image } }
    assert assigns(:micropost).image.attached?
  end
end
