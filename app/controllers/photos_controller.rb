# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :find_photo, only: [:show, :edit]
  before_action :list_subjects, only: [:new, :edit]

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to @photo
    else
      list_subjects
      render :new
    end
  end

  def show
  end

  def edit
  end

  private

  def photo_params
    params.require(:photo).permit(:subject_id, :date, :image_url, :notes)
  end

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def list_subjects
    @subjects = Subject.all.order(:name)
  end
end
