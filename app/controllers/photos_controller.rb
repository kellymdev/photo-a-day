# frozen_string_literal: true

class PhotosController < ApplicationController
  def new
    @subjects = Subject.all.order(:name)
    @photo = Photo.new
  end
end
