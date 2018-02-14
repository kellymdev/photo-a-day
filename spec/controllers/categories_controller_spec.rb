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
      let!(:category_2) { Category.create!(name: 'Landscape') }

      let!(:expected_result) do
        [
          { id: category_2.id, name: 'Landscape' },
          { id: category.id, name: 'Macro' }
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
    let!(:subject_1) { category.subjects.create!(name: 'Bee') }
    let!(:subject_2) { category.subjects.create!(name: 'Ant') }

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
            id: category.id,
            name: 'Macro'
          },
          subjects: [
            { id: subject_2.id, name: 'Ant' },
            { id: subject_1.id, name: 'Bee' }
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
