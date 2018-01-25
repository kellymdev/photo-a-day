require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:name) { 'Macro' }
  let(:category) { Category.new(name: name) }

  describe 'validations' do
    context 'with a valid name' do
      let(:name) { 'Macro' }

      it 'is valid' do
        expect(category).to be_valid
      end
    end

    context 'when the name is too short' do
      let(:name) { 'M' }

      it 'is invalid' do
        expect(category).not_to be_valid
      end
    end

    context 'without a name' do
      let(:name) { '' }

      it 'is invalid' do
        expect(category).not_to be_valid
      end
    end

    context 'when the name already exists' do
      let(:name) { 'Macro' }
      let!(:existing_category) { Category.create!(name: name) }

      it 'is invalid' do
        expect(category).not_to be_valid
      end
    end
  end
end
