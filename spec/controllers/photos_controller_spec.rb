require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:category) { Category.create!(name: 'Macro') }
  let(:subject) { category.subjects.create!(name: 'Ant') }
  let!(:photo) { subject.photos.create!(date: Date.yesterday, image_url: 'http://www.test.com/test.jpg', notes: 'Test') }

  describe '#new' do
    it 'returns http status 200' do
      expect(response.status).to eq 200
    end
  end

  describe '#create' do
    let(:date) { Date.today }
    let(:photo_params) { { subject_id: subject.id, photo: { date: date, image_url: 'http://www.test.com/test.jpg', notes: 'Test' } } }

    context 'with valid params' do
      it 'creates a photo' do
        expect { post :create, params: photo_params }.to change { Photo.count }.by 1
      end
    end

    context 'with invalid params' do
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
      get :show, params: { subject_id: subject.id, id: photo.id }

      expect(response.status).to eq 200
    end
  end

  describe '#edit' do
    it 'returns http status 200' do
      get :edit, params: { subject_id: subject.id, id: photo.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    let(:date) { Date.today }
    let(:image_url) { 'http://www.test.com/updated.jpg' }
    let(:photo_params) { { photo: { date: date, image_url: image_url, notes: 'Test' } } }

    context 'with valid params' do
      it 'updates the photo' do
        put :update, params: { subject_id: subject.id, id: photo.id }.merge(photo_params)

        expect(photo.reload.image_url).to eq image_url
      end
    end

    context 'with invalid params' do
      context 'without a date' do
        let(:date) { }

        it 'does not update the photo' do
          put :update, params: { subject_id: subject.id, id: photo.id }.merge(photo_params)

          expect(photo.reload.date).to eq Date.yesterday
        end
      end
    end
  end

  describe '#destroy' do
    it 'deletes the photo' do
      expect { delete :destroy, params: { subject_id: subject.id, id: photo.id } }.to change { Photo.count }.by -1
    end
  end
end
