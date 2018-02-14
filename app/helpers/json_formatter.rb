# frozen_string_literal: true

module JsonFormatter
  def category_list(categories)
    categories.as_json(except: [:created_at, :updated_at])
  end

  def category_details(category)
    {
      category: category.as_json(except: [:created_at, :updated_at]),
      subjects: category.subjects.order(:name).as_json(except: [:created_at, :updated_at, :category_id])
    }
  end

  def subject_details(subject)
    {
      subject: subject.as_json(except: [:created_at, :updated_at, :category_id]),
      category: subject.category.as_json(except: [:created_at, :updated_at]),
      photos: subject.photos.as_json(except: [:created_at, :updated_at, :subject_id])
    }
  end
end
