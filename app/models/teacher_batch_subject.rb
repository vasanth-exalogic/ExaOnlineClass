class TeacherBatchSubject < ApplicationRecord
  validates_uniqueness_of :batch_subject_id
end
