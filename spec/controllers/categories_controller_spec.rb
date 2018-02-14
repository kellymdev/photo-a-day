require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  render_views

  let!(:category) { Category.create!(name: 'Macro') }

  describe '#index' do
    context 'with html format' do
      it 'returns http status 200' do
        get :index

        expect(response.status).to eq 200
      end

      it 'renders the index template' do
        get :index

        expect(response).to render_template :index
      end
    end

    context 'with json format' do
      let!(:category2) { Category.create!(name: 'Landscape') }

      it 'returns http status 200' do
        get :index, format: :json

        expect(response.status).to eq 200
      end

      it 'returns a list of categories as json' do
        get :index, format: :json

        expect(response.body).to eq Category.all.order(:name).to_json(except: [:created_at, :updated_at])
      end
    end
  end

  describe '#show' do
    it 'returns http status 200' do
      get :show, params: { id: category.id }

      expect(response.status).to eq 200
    end
  end
end
