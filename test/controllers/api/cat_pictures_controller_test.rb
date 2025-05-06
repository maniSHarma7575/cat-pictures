require "test_helper"

class Api::CatPicturesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers

  setup do
    @picture = Picture.new(title: "Test Picture")
    @picture.attachment.attach(
      io: File.open(Rails.root.join("test/fixtures/files/cat_image_1.jpeg")),
      filename: "cat_image_1.jpeg",
      content_type: "image/jpeg"
    )
    @picture.save
  end

  test "should get index" do
    get api_cat_pictures_url, as: :json
    assert_response :success
    assert_not_nil JSON.parse(@response.body)
  end

  test "should show cat picture" do
    get api_cat_picture_url(@picture), as: :json
    assert_response :success
    assert_not_nil JSON.parse(@response.body)
    assert_equal @picture.id, JSON.parse(@response.body)["id"]
  end

  test "should create cat picture" do
    assert_difference("Picture.count") do
      post api_cat_pictures_url,
        params: {
          title: "New Cat Picture",
          attachment: fixture_file_upload("test/fixtures/files/cat_image_1.jpeg", "image/jpeg")
        }
    end

    assert_response :created
    assert_not_nil JSON.parse(@response.body)
  end

  test "should update cat picture" do
    new_file = fixture_file_upload("test/fixtures/files/cat_image_2.jpeg", "image/jpeg")

    patch api_cat_picture_url(@picture),
      params: { title: "Updated Title", attachment: new_file }

    assert_response :success
    @picture.reload
    assert_equal "Updated Title", @picture.title
  end

  test "should destroy cat picture" do
    assert_difference("Picture.count", -1) do
      delete api_cat_picture_url(@picture)
    end

    assert_response :no_content
  end
end
