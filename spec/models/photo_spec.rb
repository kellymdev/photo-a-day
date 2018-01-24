require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:date) { Date.today }
  let(:subject) { Subject.new }
  let(:photo) { Photo.new(date: date, subject: subject) }

  describe 'validations' do
    context 'with a valid date' do
      let(:date) { Date.today }

      it 'is valid' do
        expect(photo).to be_valid
      end
    end

    context 'without a date' do
      let(:date) { }

      it 'is invalid' do
        expect(photo).not_to be_valid
      end
    end

    context 'without a subject' do
      let(:subject) { }

      it 'is invalid' do
        expect(photo).not_to be_valid
      end
    end
  end
end
