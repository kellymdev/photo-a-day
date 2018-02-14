# frozen_string_literal: true

class CategoriesController < ApplicationController
  include JsonFormatter

  before_action :find_category, only: [:show]

  def index
    @categories = Category.all.order(:name)

    respond_to do |format|
      format.html
      format.json { render json: category_list(@categories) }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json do
        render json: category_details(@category)
      end
    end
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
