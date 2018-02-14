# frozen_string_literal: true

class SubjectsController < ApplicationController
  include JsonFormatter

  before_action :find_subject, only: [:show, :edit, :update, :destroy]
  before_action :list_categories, only: [:new, :edit]

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      respond_to do |format|
        format.html { redirect_to @subject }
        format.json { render json: subject_details(@subject) }
      end
    else
      respond_to do |format|
        format.html do
          list_categories
          render :new
        end

        format.json { render json: error_details(@subject) }
      end
    end
  end

  def show
    respond_to do | format|
      format.html
      format.json do
        render json: subject_details(@subject)
      end
    end
  end

  def edit
  end

  def update
    if @subject.update(subject_params)
      respond_to do |format|
        format.html { redirect_to @subject }
        format.json { render json: subject_details(@subject) }
      end
    else
      respond_to do |format|
        format.html do
          list_categories
          render :edit
        end

        format.json { render json: error_details(@subject) }
      end
    end
  end

  def destroy
    if @subject.photos.any?

      flash[:error] = "Can't delete a subject that has photos"
      redirect_to @subject
    else
      category = @subject.category
      @subject.destroy!

      redirect_to category_path(category)
    end
  end

  private

  def subject_params
    params.require(:subject).permit(:category_id, :name)
  end

  def find_subject
    @subject = Subject.find(params[:id])
  end

  def list_categories
    @categories = Category.all.order(:name)
  end
end
