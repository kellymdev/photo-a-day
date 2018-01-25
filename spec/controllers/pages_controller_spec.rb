require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  render_views

  describe '#index' do
    it 'returns http status 200' do
      get :index

      expect(response.status).to eq 200
    end

    it 'renders the index template' do
      get :index

      expect(response).to render_template :index
    end
  end
end
