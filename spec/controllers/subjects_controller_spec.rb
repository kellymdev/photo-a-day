require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
  render_views

  let(:category) { Category.create!(name: 'Macro') }
  let!(:subject) { category.subjects.create!(name: 'Bee') }
  let(:valid_params) { { subject: { category_id: category.id, name: 'Ant' } } }
  let(:invalid_params) { { subject: { category_id: category.id, name: '' } } }

  describe '#new' do
    it 'returns http status code 200' do
      get :new

      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a subject' do
        expect { post :create, params: valid_params }.to change { Subject.count}.by 1
      end
    end

    context 'with invalid params' do
      it 'does not create a subject' do
        expect { post :create, params: invalid_params }.to change { Subject.count}.by 0
      end
    end
  end

  describe '#show' do
    it 'returns http status code 200' do
      get :show, params: { id: subject.id }

      expect(response.status).to eq 200
    end
  end

  describe '#edit' do
    it 'returns https status code 200' do
      get :edit, params: { id: subject.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates the subject' do
        put :update, params: { id: subject.id }.merge(valid_params)

        expect(subject.reload.name).to eq 'Ant'
      end
    end

    context 'with invalid params' do
      it 'does not update the subject' do
        put :update, params: { id: subject.id }.merge(invalid_params)

        expect(subject.name).to eq 'Bee'
      end
    end
  end

  describe '#destroy' do
    context 'when the subject does not have any photos' do
      it 'deletes the subject' do
        expect { delete :destroy, params: { id: subject.id } }.to change { Subject.count }.by -1
      end
    end

    context 'when the subject has a photo' do
      let!(:photo) { subject.photos.create!(date: Date.today, notes: 'Test') }

      it 'does not delete the subject' do
        expect { delete :destroy, params: { id: subject.id } }.to change { Subject.count }.by 0
      end
    end
  end
end
