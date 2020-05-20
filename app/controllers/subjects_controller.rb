class SubjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin

  def index
    @subjects = Subject.all
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new(subject_params)
    @subject.subject.upcase!
    if @subject.save
      redirect_to subjects_path
    else
      render "new"
    end
  end

  def edit
    @subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to subjects_path
    else
      render "edit"
    end
  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.delete
    redirect_to subjects_path
  end

  def show
    @subject = Subject.find(params[:id])
    @batches = BatchSubject.select('batch_id').where(subject_id: @subject)
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
  end

  private

  def subject_params
    params.require(:subject).permit(:id,:subject)
  end
end
