class StudentBatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def new
    @student = User.find(params[:id])
    @batches = Batch.all
    @student_batch = StudentBatch.new
  end

  def create
    @student_batch = StudentBatch.new(student_batch_params)
    @student_batch.user_id = params[:id]
    if @student_batch.save
      redirect_to student_path(params[:id])
    else
      render "new"
    end
  end

  def edit
    @student_batch = StudentBatch.find(params[:id])
    @student = User.find(@student_batch.user_id)
  end

  def update
    @student_batch = StudentBatch.find(params[:id])
    @student = User.find(@student_batch.user_id)
    if @student_batch.update(student_batch_params)
      redirect_to student_path(@student)
    else
      render "edit"
    end
  end

  private

  def student_batch_params
    params.require(:student_batch).permit(:id,:user_id,:batch_id)
  end
end
