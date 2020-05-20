class LecturesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_allowed, only: :show

  def index
    if current_user.has_role? :staff
      @teacher_batch_subject = TeacherBatchSubject.all.where(user_id: current_user.id)
    elsif current_user.has_role? :student
      @student_batch = StudentBatch.find_by(user_id: current_user.id)
      @batch = Batch.find(@student_batch.batch_id)
      @batch_subject = BatchSubject.all.where(batch_id: @batch)
    end
  end

  def show
    @batch_subject = BatchSubject.find(params[:id])
    @batch = Batch.find(@batch_subject.batch_id)
    @subject = Subject.find(@batch_subject.subject_id)
    teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: @batch_subject)
    @teacher = User.find(teacher_batch_subject.user_id)
    @chapters = Chapter.all.where(batch_subject_id: params[:id])
  end

  private

  def is_allowed
    if current_user.has_role?(:staff)
      teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: params[:id])
      unless teacher_batch_subject.user_id == current_user.id
        redirect_back fallback_location: root_path
      end
    elsif current_user.has_role?(:student)
      batch_subject = BatchSubject.find(params[:id])
      batch = Batch.find(batch_subject.batch_id)
      student_batch = StudentBatch.find_by(user_id: current_user.id)
      unless student_batch.batch_id==batch.id
        redirect_back fallback_location: root_path
      end
    else
      redirect_back fallback_location: root_path
    end
  end
end
