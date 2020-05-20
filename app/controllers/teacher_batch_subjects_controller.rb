class TeacherBatchSubjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @teacher_batch_subject = TeacherBatchSubject.new
    @batch_subject = BatchSubject.find(params[:id])
    @batch = Batch.find(@batch_subject.batch_id)
    @subject = Subject.find(@batch_subject.subject_id)
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    t = TeacherSubject.where(subject_id: @subject).pluck('user_id')
    @users = User.find(t).pluck('fname','id')
  end

  def create
    @teacher_batch_subject = TeacherBatchSubject.new(teacher_batch_subject_params)
    batch_subject = BatchSubject.find(params[:id])
    batch = Batch.find(batch_subject.batch_id)
    @teacher_batch_subject.batch_subject_id = batch_subject.id
    if @teacher_batch_subject.save
      redirect_to batch_path(batch)
    else
      render "new"
    end
  end

  def edit
    @batch_subject = BatchSubject.find(params[:id])
    @batch = Batch.find(@batch_subject.batch_id)
    @subject = Subject.find(@batch_subject.subject_id)
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    t = TeacherSubject.where(subject_id: @subject).pluck('user_id')
    @teacher_batch_subject = TeacherBatchSubject.find_by(batch_subject_id: @batch_subject)
    t = TeacherSubject.where(subject_id: @subject).pluck('user_id')
    @users = User.find(t).pluck('fname','id')
  end

  def update
    @teacher_batch_subject = TeacherBatchSubject.find(params[:id])
    batch_subject = BatchSubject.find(@teacher_batch_subject.batch_subject_id)
    if @teacher_batch_subject.update(teacher_batch_subject_params)
      redirect_to batch_path(batch_subject.batch_id)
    else
      render "edit"
    end
  end

  def destroy
    @teacher_batch_subject = TeacherBatchSubject.find(params[:id])
    batch_subject = BatchSubject.find(@teacher_batch_subject.batch_subject_id)
    @teacher_batch_subject.delete
    redirect_to batch_path(batch_subject.batch_id)
  end

  private

  def teacher_batch_subject_params
    params.require(:teacher_batch_subject).permit(:id,:user_id,:batch_subject_id)
  end
end
