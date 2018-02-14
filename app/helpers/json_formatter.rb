# frozen_string_literal: true

module JsonFormatter
  def subject_details(subject)
    {
      subject: subject.as_json(except: [:created_at, :updated_at, :category_id]),
      category: subject.category.as_json(except: [:created_at, :updated_at]),
      photos: subject.photos.as_json(except: [:created_at, :updated_at, :subject_id])
    }
  end
end
