require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:category) { Category.create!(name: 'Macro') }
  let(:subject) { category.subjects.create!(name: 'Ant') }
  let!(:photo) { Photo.create!(subject_id: subject.id, date: Date.yesterday, image_url: 'http://www.test.com/test.jpg', notes: 'Test') }

  describe '#new' do
    it 'returns http status 200' do
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:subject_id) { subject.id }
    let(:date) { Date.today }
    let(:photo_params) { { photo: { subject_id: subject_id, date: date, image_url: 'http://www.test.com/test.jpg', notes: 'Test' } } }

    context 'with valid params' do
      it 'creates a photo' do
        expect { post :create, params: photo_params }.to change { Photo.count }.by 1
      end
    end

    context 'with invalid params' do
      context 'without a subject' do
        let(:subject_id) { }

        it 'does not create a photo' do
          expect { post :create, params: photo_params }.to change { Photo.count }.by 0
        end
      end

      context 'without a date' do
        let(:date) { }

        it 'does not create a photo' do
          expect { post :create, params: photo_params }.to change { Photo.count }.by 0
        end
      end
    end
  end

  describe '#show' do
    it 'returns http status 200' do
      get :show, params: { id: photo.id }

      expect(response.status).to eq 200
    end
  end

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { id: photo.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:subject_id) { subject.id }
    let(:date) { Date.today }
    let(:image_url) { 'http://www.test.com/updated.jpg' }
    let(:photo_params) { { photo: { subject_id: subject_id, date: date, image_url: image_url, notes: 'Test' } } }

    context 'with valid params' do
      it 'updates the photo' do
        put :update, params: { id: photo.id }.merge(photo_params)

        expect(photo.reload.image_url).to eq image_url
      end
    end

    context 'with invalid params' do
      context 'without a subject' do
        let(:subject_id) { }

        it 'does not update the photo' do
          put :update, params: { id: photo.id }.merge(photo_params)

          expect(photo.reload.image_url).to eq 'http://www.test.com/test.jpg'
        end
      end

      context 'without a date' do
        let(:date) { }

        it 'does not update the photo' do
          put :update, params: { id: photo.id }.merge(photo_params)

          expect(photo.reload.date).to eq Date.yesterday
        end
      end
    end
  end

  describe '#destroy' do
    it 'deletes the photo' do
      expect { delete :destroy, params: { id: photo.id } }.to change { Photo.count }.by -1
    end
  end
end
