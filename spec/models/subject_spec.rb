require 'rails_helper'

RSpec.describe Subject, type: :model do
  let(:name) { 'Ant' }
  let(:category) { Category.create!(name: 'Macro') }
  let(:subject) { Subject.new(name: name, category: category) }

  describe 'validations' do
    context 'with a valid name' do
      let(:name) { 'Ant' }

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'when the name is too short' do
      let(:name) { 'A' }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end

    context 'without a name' do
      let(:name) { '' }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end

    context 'without a category' do
      let(:category) { }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end

    context 'when the name already exists' do
      let(:name) { 'Ant' }
      let!(:existing_subject) { category.subjects.create!(name: name) }

      it 'is invalid' do
        expect(subject).not_to be_valid
      end
    end
  end
end
