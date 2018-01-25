# frozen_string_literal: true

class PagesController < ApplicationController
  def index
    @categories = Category.all.as_json(except: [:created_at, :updated_at])
  end
end
