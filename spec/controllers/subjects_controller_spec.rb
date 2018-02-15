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
    context 'with html format' do
      context 'with valid params' do
        it 'creates a subject' do
          expect { post :create, params: valid_params }.to change { Subject.count }.by 1
        end
      end

      context 'with invalid params' do
        it 'does not create a subject' do
          expect { post :create, params: invalid_params }.to change { Subject.count }.by 0
        end
      end
    end

    context 'with json format' do
      context 'with valid params' do
        let(:expected_result) do
          {
            subject: {
              id: subject.id.succ, #it will use the next id
              name: 'Ant'
            },
            category: {
              id: category.id,
              name: 'Macro'
            },
            photos: []
          }
        end

        it 'creates a subject' do
          expect { post :create, params: valid_params, format: :json }.to change { Subject.count }.by 1
        end

        it 'returns details for the subject' do
          post :create, params: valid_params, format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end

      context 'with invalid params' do
        let(:expected_result) do
          {
            errors: {
              name: ["can't be blank", "is too short (minimum is 2 characters)"]
            }
          }
        end

        it 'does not create a subject' do
          expect { post :create, params: invalid_params, format: :json }.to change { Subject.count }.by 0
        end

        it 'returns a list of errors' do
          post :create, params: invalid_params, format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end
    end
  end

  describe '#show' do
    context 'with html format' do
      it 'returns http status code 200' do
        get :show, params: { id: subject.id }

        expect(response.status).to eq 200
      end

      it 'renders the show template' do
        get :show, params: { id: subject.id }

        expect(response.status).to eq 200
      end
    end

    context 'with json format' do
      let!(:photo_1) { subject.photos.create!(date: Date.yesterday, image_url: 'http://www.test.com/flower.jpg', notes: 'Bee on a flower') }
      let!(:photo_2) { subject.photos.create!(date: Date.today, image_url: 'http://www.test.com/leaf.jpg', notes: 'Bee on a leaf') }

      let(:expected_result) do
        {
          subject: {
            id: subject.id,
            name: 'Bee'
          },
          category: {
            id: category.id,
            name: 'Macro'
          },
          photos: [
            {
              id: photo_1.id,
              date: Date.yesterday,
              image_url: 'http://www.test.com/flower.jpg',
              notes: 'Bee on a flower'
            },
            {
              id: photo_2.id,
              date: Date.today,
              image_url: 'http://www.test.com/leaf.jpg',
              notes: 'Bee on a leaf'
            }
          ]
        }
      end

      it 'returns http status code 200' do
        get :show, params: { id: subject.id }, format: :json

        expect(response.status).to eq 200
      end

      it 'returns the subject, category and photo details as json' do
        get :show, params: { id: subject.id }, format: :json
        expect(response.body).to eq expected_result.to_json
      end
    end
  end

  describe '#edit' do
    it 'returns https status code 200' do
      get :edit, params: { id: subject.id }

      expect(response.status).to eq 200
    end
  end

  describe '#update' do
    context 'with html format' do
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

    context 'with json format' do
      context 'with valid params' do
        let(:expected_result) do
          {
            subject: {
              id: subject.id,
              name: 'Ant'
            },
            category: {
              id: category.id,
              name: 'Macro'
            },
            photos: []
          }
        end

        it 'updates the subject' do
          put :update, params: { id: subject.id }.merge(valid_params), format: :json

          expect(subject.reload.name).to eq 'Ant'
        end

        it 'returns details for the subject' do
          put :update, params: { id: subject.id }.merge(valid_params), format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end

      context 'with invalid params' do
        let(:expected_result) do
          {
            errors:
              {
                name: ["can't be blank", "is too short (minimum is 2 characters)"]
              }
          }
        end

        it 'does not update the subject' do
          put :update, params: { id: subject.id }.merge(invalid_params), format: :json

          expect(subject.name).to eq 'Bee'
        end

        it 'returns a list of errors' do
          put :update, params: { id: subject.id }.merge(invalid_params), format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end
    end
  end

  describe '#destroy' do
    context 'with html format' do
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

        it 'displays a flash error' do
          delete :destroy, params: { id: subject.id }

          expect(flash[:error]).to eq "Can't delete a subject that has photos"
        end
      end
    end

    context 'with json format' do
      context 'when the subject does not have any photos' do
        let(:expected_result) do
          {
            result: 'success',
            message: 'Subject was successfully deleted'
          }
        end

        it 'deletes the subject' do
          expect { delete :destroy, params: { id: subject.id }, format: :json }.to change { Subject.count }.by -1
        end

        it 'returns a success message as json' do
          delete :destroy, params: { id: subject.id }, format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end

      context 'when the subject has a photo' do
        let!(:photo) { subject.photos.create!(date: Date.today, notes: 'Test') }
        let(:expected_result) do
          {
            error: 'Cannot delete a subject that has photos',
            subject: {
              id: subject.id,
              name: 'Bee',
              category_id: category.id
            }
          }
        end

        it 'does not delete the subject' do
          expect { delete :destroy, params: { id: subject.id }, format: :json }.to change { Subject.count }.by 0
        end

        it 'returns an error message as json' do
          delete :destroy, params: { id: subject.id }, format: :json

          expect(response.body).to eq expected_result.to_json
        end
      end
    end
  end
end
