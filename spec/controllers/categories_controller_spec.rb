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

      let!(:expected_result) do
        [
          { id: 2, name: 'Landscape' },
          { id: 1, name: 'Macro' }
        ]
      end

      it 'returns http status 200' do
        get :index, format: :json

        expect(response.status).to eq 200
      end

      it 'returns a list of categories as json' do
        get :index, format: :json

        expect(response.body).to eq expected_result.to_json
      end
    end
  end

  describe '#show' do
    let!(:subject) { category.subjects.create!(name: 'Bee') }
    let!(:subject2) { category.subjects.create!(name: 'Ant') }

    context 'with html format' do
      it 'returns http status 200' do
        get :show, params: { id: category.id }

        expect(response.status).to eq 200
      end

      it 'renders the show template' do
        get :show, params: { id: category.id }

        expect(response).to render_template :show
      end
    end

    context 'with json format' do
      let(:expected_result) do
        {
          category: {
            id: 1,
            name: 'Macro'
          },
          subjects: [
            { id: 2, name: 'Ant' },
            { id: 1, name: 'Bee' }
          ]
        }
      end

      it 'returns http status 200' do
        get :show, params: { id: category.id }, format: :json

        expect(response.status).to eq 200
      end

      it 'returns the category and a list of its subjects' do
        get :show, params: { id: category.id }, format: :json

        expect(response.body).to eq expected_result.to_json
      end
    end
  end
end
