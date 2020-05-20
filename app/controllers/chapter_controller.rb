class ChapterController < ApplicationController
  before_action :authenticate_user!

  def new
    @batch_subject = BatchSubject.find(params[:id])
    @batch = Batch.find(@batch_subject.batch_id)
    @subject =Subject.find(@batch_subject.subject_id)
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @batch_subject = BatchSubject.find(params[:id])
    @chapter.batch_subject_id = @batch_subject.id
    if @chapter.save
      redirect_to chapter_path
    else
      render "new"
    end
  end

  def show
    @chapter = Chapter.find(params[:id])
    @batch_subject = BatchSubject.find(@chapter.batch_subject_id)
    @teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: @batch_subject.id)
    @teacher = User.find(@teacher_batch_subject.user_id)
    @batch = Batch.find(@batch_subject.batch_id)
    @subject =Subject.find(@batch_subject.subject_id)
    @videos = Video.all.where(chapter_id: params[:id])
  end

  private

  def chapter_params
    params.require(:chapter).permit(:id,:batch_subject_id,:title,:overview)
  end
end
