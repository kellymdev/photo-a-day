require 'rails_helper'

RSpec.describe Subject, type: :model do
  describe 'validations' do
    let(:subject) { Subject.new(name: name) }

    context 'with a valid name' do
      let(:name) { 'Anna' }

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
  end
end
