class StaffsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: [:index, :new, :create]
  before_action :is_staff, only: [:edit,:update]
  before_action :is_admin, only: [:new, :create, :destroy]

  def index
    @staffs = User.with_role :staff
  end

  def new
    @staff = User.new
  end

  def create
    @staff = User.new(staff_params)
    if @staff.save
      @staff.add_role :staff
      redirect_to staff_path(@staff)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @staff.update(staff_params)
      redirect_to staff_path(@staff)
    else
      render 'edit'
    end
  end

  def show
    @teacher_subjects = TeacherSubject.all.where(user_id: params[:id])
    @teacher_batch_subjects = TeacherBatchSubject.all.where(user_id: params[:id])
    @classes_list = {-1=>'LKG',0=>'UKG',1=>'I',2=>'II',3=>'III',4=>'IV',5=>'V',
      6=>'VI',7=>'VII',8=>'VIII',9=>'IX',10=>'X',11=>'XI',12=>'XII'}
  end

  def destroy
    @staff.delete
    redirect_to staffs_path
  end

  private

  def staff_params
    params.require(:user).permit(:id,:fname,:lname,:contact,:gender,:address,:email,:password,:password_confirmation)
  end

  def set_user
    @staff = User.find(params[:id])
  end

  def is_staff
    unless current_user.has_role? :admin or current_user.id==@staff.id
      redirect_back fallback_location: root_path
    end
  end

end
