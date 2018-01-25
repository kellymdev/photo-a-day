# frozen_string_literal: true

class PhotosController < ApplicationController
  def new
    @subjects = Subject.all.order(:name)
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo
    else
      render :new
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:subject_id, :date, :image_url, :notes)
  end
end
