class Api::CatPicturesController < ApplicationController
  before_action :set_cat_picture, only: %i[show update destroy]

  def index
    @pictures = Picture.all.with_attached_attachment.map do
      |picture| picture.as_json.merge(attachment_url: url_for(picture.attachment))
    end

    render json: @pictures.to_json
  end

  def show
    render json: @cat_picture
  end

  def create
    @cat_picture = Picture.new(title: params[:title])
    @cat_picture.attachment.attach(params[:attachment])
    if @cat_picture.save
      render json: @cat_picture, status: :created
    else
      render json: { errors: @cat_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @cat_picture.title = params[:title] if params[:title]
    @cat_picture.attachment.attach(params[:attachment])
    if @cat_picture.save
      render json: @cat_picture
    else
      render json: { errors: @cat_picture.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @cat_picture.destroy
    head :no_content
  end

  private

  def set_cat_picture
    @cat_picture = Picture.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Cat picture not found" }, status: :not_found
  end

  # def picture_params
  #   params.require(:cat_picture).permit(:title, :attachment)
  # end
end
