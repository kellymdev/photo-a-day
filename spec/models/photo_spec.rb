require 'rails_helper'

RSpec.describe Photo, type: :model do
  let(:date) { Date.today }
  let(:category) { Category.create!(name: 'Macro') }
  let(:subject) { category.subjects.create!(name: 'Bee') }
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

  describe 'scopes' do
    describe 'most_recent_first' do
      let(:photo_1) { subject.photos.create!(date: Date.today - 3.days) }
      let(:photo_2) { subject.photos.create!(date: Date.today) }
      let(:photo_3) { subject.photos.create!(date: Date.yesterday) }

      it 'returns photos in descending date order' do
        expect(Photo.most_recent_first).to eq [photo_2, photo_3, photo_1]
      end
    end
  end
end
