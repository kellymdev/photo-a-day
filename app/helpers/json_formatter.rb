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

  def photo_details(photo)
    {
      photo: photo.as_json(except: [:created_at, :updated_at, :subject_id]),
      category: photo.subject.category.as_json(except: [:created_at, :updated_at]),
      subject: photo.subject.as_json(except: [:created_at, :updated_at, :category_id])
    }
  end

  def error_details(subject)
    {
      errors: subject.errors
    }
  end

  def successful_delete(item)
    {
      result: 'success',
      message: "#{item} was successfully deleted"
    }
  end

  def unsuccessful_delete_of_subject(subject)
    {
      error: 'Cannot delete a subject that has photos',
      subject: subject.as_json(except: [:created_at, :updated_at])
    }
  end
end
