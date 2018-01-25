require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let!(:category) { Category.create!(name: 'Macro') }

  describe '#index' do
    it 'returns http status 200' do
      get :index

      expect(response.status).to eq 200
    end
  end

  describe '#show' do
    it 'returns http status 200' do
      get :show, params: { id: category.id }

      expect(response.status).to eq 200
    end
  end
end
