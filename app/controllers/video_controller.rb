class VideoController < ApplicationController
  before_action :authenticate_user!

  def new
    @video = Video.new
    @chapter = Chapter.find(params[:id])
    @batch_subject = BatchSubject.find(@chapter.batch_subject_id)
    @teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: @batch_subject.id)
    @teacher = User.find(@teacher_batch_subject.user_id)
    @batch = Batch.find(@batch_subject.batch_id)
    @subject =Subject.find(@batch_subject.subject_id)
  end

  def create
    @video = Video.new(video_params)
    @video.chapter_id = params[:id]
    if @video.save
      redirect_to chapter_path(@video.chapter_id)
    else
      redirect_back fallback_location: root_path
    end
  end

  def show
    @video = Video.find(params[:id])
    @chapter = Chapter.find(@video.chapter_id)
    @batch_subject = BatchSubject.find(@chapter.batch_subject_id)
    @teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: @batch_subject.id)
    @teacher = User.find(@teacher_batch_subject.user_id)
    @batch = Batch.find(@batch_subject.batch_id)
    @subject =Subject.find(@batch_subject.subject_id)
  end

  private

  def video_params
    params.require(:video).permit(:id,:title,:file)
  end

end
