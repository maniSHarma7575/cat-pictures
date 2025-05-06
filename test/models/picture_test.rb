require "test_helper"

class PictureTest < ActiveSupport::TestCase
  setup do
    @picture = Picture.new(title: "Test Picture")
    @picture.attachment.attach(
      io: File.open(Rails.root.join("test/fixtures/files/cat_image_1.jpeg")),
      filename: "cat_image_1.jpeg",
      content_type: "image/jpeg"
    )
  end

  test "is valid with valid attributes" do
    assert @picture.valid?
  end

  test "is invalid without a title" do
    @picture.title = nil
    assert_not @picture.valid?
    assert_includes @picture.errors[:title], "can't be blank"
  end

  test "is invalid without an attachment" do
    @picture.attachment.purge
    assert_not @picture.valid?
    assert_includes @picture.errors[:attachment], "can't be blank"
  end

  test "is invalid with an unsupported attachment format" do
    @picture.attachment.attach(
      io: File.open(Rails.root.join("test/fixtures/files/unsupported_file.txt")),
      filename: "unsupported_file.txt",
      content_type: "text/plain"
    )
    assert_not @picture.valid?
    assert_includes @picture.errors[:attachment], "must be a valid image format"
  end
end
