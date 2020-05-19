class BatchesController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
    @batch = Batch.new
  end

  def create
    @batch = Batch.new(batch_params)
    if @batch.save
      redirect_to batch_path(@batch)
    else
      render new
    end
  end

  private

  def batch_params
    params.require(:batch).permit(:id,:batch,:section)
  end
end
