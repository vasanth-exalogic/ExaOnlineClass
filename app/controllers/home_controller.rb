class HomeController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, only: [:setup, :registrations]

  def index
  end

  def setup
  end

  def academy
  end

  def registrations
  end

  def classes
    @batches = Batch.all.order('batch')
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
  end

  def classstudents
    @batch = Batch.find(params[:id])
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
    @student_batch = StudentBatch.all.where(batch_id: @batch)
    @batch_subjects = BatchSubject.all.where(batch_id: params[:id])
  end

end
