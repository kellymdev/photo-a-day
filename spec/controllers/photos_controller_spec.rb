require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  describe '#new' do
    it 'returns http status 200' do
      expect(response.status).to eq 200
    end
  end
end
