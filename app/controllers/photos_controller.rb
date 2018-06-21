# frozen_string_literal: true

class PhotosController < ApplicationController
  include JsonFormatter

  skip_before_action :verify_authenticity_token if :json_request?

  before_action :find_photo, only: [:show, :edit, :update, :destroy]
  before_action :find_subject

  def new
    @photo = Photo.new
  end

  def create
    @photo = @subject.photos.new(photo_params)

    if @photo.save
      respond_to do |format|
        format.html { redirect_to subject_photo_path(@subject, @photo) }
        format.json { render json: photo_details(@photo) }
      end
    else
      respond_to do |format|
        format.html { render :new }
        format.json { render json: error_details(@photo) }
      end
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: photo_details(@photo) }
    end
  end

  def edit
  end

  def update
    if @photo.update(photo_params)
      respond_to do |format|
        format.html { redirect_to subject_photo_path(@subject, @photo) }
        format.json { render json: photo_details(@photo) }
      end
    else
      respond_to do |format|
        format.html { render :edit, id: @photo.id }
        format.json { render json: error_details(@photo) }
      end
    end
  end

  def destroy
    subject = @photo.subject

    @photo.destroy!

    respond_to do |format|
      format.html { redirect_to subject_path(subject) }
      format.json { render json: successful_delete('Photo') }
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:date, :image_url, :notes)
  end

  def find_photo
    @photo = Photo.find(params[:id])
  end

  def find_subject
    @subject = Subject.find(params[:subject_id])
  end
end
