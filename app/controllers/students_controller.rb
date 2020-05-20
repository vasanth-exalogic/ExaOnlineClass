class StudentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :new, :create]
  before_action :is_student, only: [:edit,:update]
  before_action :is_admin, only: [:new, :create, :destroy]

  def index
    @students = User.with_role :student
  end

  def new
    @student = User.new
  end

  def create
    @student = User.new(student_params)
    if @student.save
      @student.add_role :student
      redirect_to student_path(@student)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to student_path(@student)
    else
      render 'edit'
    end
  end

  def show
    @student_batch = StudentBatch.find_by(user_id: params[:id])
    @batch = Batch.find(@student_batch.batch_id)
  end

  def destroy
    @student.delete
    redirect_to students_path
  end

  private

  def student_params
    params.require(:user).permit(:id,:fname,:lname,:contact,:gender,:address,:email,:password,:password_confirmation)
  end

  def set_user
    @student = User.find(params[:id])
  end

  def is_student
    unless current_user.has_role? :admin or current_user.id==@student.id
      redirect_back fallback_location: root_path
    end
  end
end
