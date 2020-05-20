class TeacherSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def new
    @teacher_subject = TeacherSubject.new
    @user = User.find(params[:id])
  end

  def create
    @teacher_subject = TeacherSubject.new(teacher_subject_params)
    @teacher_subject.user_id = params[:id]
    if @teacher_subject.save
      redirect_to staff_path(@teacher_subject.user_id)
    else
      render 'new'
    end
  end

  private

  def teacher_subject_params
    params.require(:teacher_subject).permit(:id,:user_id,:subject_id)
  end
end
