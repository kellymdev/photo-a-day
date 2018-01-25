require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  let(:category) { Category.create!(name: 'Macro') }

  describe '#new' do
    it 'returns http status code 200' do
      get :new

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      let(:valid_params) { { subject: { category_id: category.id, name: 'Ant' } } }

      it 'creates a subject' do
        expect { post :create, params: valid_params }.to change { Subject.count}.by 1
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { subject: { category_id: category.id, name: '' } } }

      it 'does not create a subject' do
        expect { post :create, params: invalid_params }.to change { Subject.count}.by 0
      end
    end
  end

  describe '#show' do
    let(:subject) { category.subjects.create!(name: 'Ant') }

    it 'returns http status code 200' do
      get :show, params: { id: subject.id }

      expect(response.status).to eq 200
    end
  end
end
