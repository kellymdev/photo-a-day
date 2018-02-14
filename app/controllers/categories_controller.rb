# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_category, only: [:show]

  def index
    @categories = Category.all.order(:name)

    respond_to do |format|
      format.html
      format.json { render json: @categories.as_json(except: [:created_at, :updated_at]) }
    end
  end

  def show
  end

  private

  def find_category
    @category = Category.find(params[:id])
  end
end
