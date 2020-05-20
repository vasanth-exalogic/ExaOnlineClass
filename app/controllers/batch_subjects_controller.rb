class BatchSubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def new
    @batch = Batch.find(params[:id])
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    @batch_subject = BatchSubject.new
    @subjects = Subject.select('subject')
  end

  def create
    @batch_subject = BatchSubject.new(batch_subject_params)
    @batch_subject.batch_id = params[:id]
    if @batch_subject.save
      redirect_to batch_path(params[:id])
    end
  end

  def destroy
    @batch_subject = BatchSubject.find_by(batch_id: params[:id], subject_id: params[:sub_id])
    @batch_subject.delete
    redirect_to batch_path(params[:id])
  end

  private

  def batch_subject_params
    params.require(:batch_subject).permit(:id, :batch_id, :subject_id)
  end
end
