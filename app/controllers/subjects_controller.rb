# frozen_string_literal: true

class SubjectsController < ApplicationController
  before_action :find_subject, only: [:show]

  def new
    @categories = Category.all.order(:name)
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)

    if @subject.save
      redirect_to @subject
    else
      render :new
    end
  end

  def show
  end

  private

  def subject_params
    params.require(:subject).permit(:category_id, :name)
  end

  def find_subject
    @subject = Subject.find(params[:id])
  end
end
