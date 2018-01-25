# frozen_string_literal: true

class PhotosController < ApplicationController
  before_action :find_photo, only: [:show, :edit, :update, :destroy]
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

  def update
    if @photo.update(photo_params)
      redirect_to @photo
    else
      list_subjects
      render :edit, id: @photo.id
    end
  end

  def destroy
    subject = @photo.subject

    @photo.destroy

    redirect_to subject_path(subject)
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
