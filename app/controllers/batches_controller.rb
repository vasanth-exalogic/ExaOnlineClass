class BatchesController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
    @batches = Batch.all.order('batch')
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    if @batch.save
      @batch.update(name: (classes_list[@batch.batch]+" "+@batch.section.upcase))
      redirect_to batches_path
    else
      render "new"
    end
  end

  def edit
    @batch = Batch.find(params[:id])
  end

  def update
    @batch = Batch.find(params[:id])
    if @batch.update(batch_params)
      redirect_to batches_path
    else
      render "edit"
    end
  end

  def show
    @batch = Batch.find(params[:id])
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    @batch_subjects = BatchSubject.select('id','subject_id').where(batch_id: params[:id])
  end

  def destroy
    @batch = Batch.find(params[:id])
    @batch.delete
    redirect_to batches_path
  end

  private

  def batch_params
    params.require(:batch).permit(:id,:batch,:section)
  end
end
