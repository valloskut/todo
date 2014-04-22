class Api::V1::ToDosController < Api::V1::BaseController
  def index
    to_dos = current_user.to_dos
    respond_with to_dos
  end

  def show
    to_do = current_user.to_dos.find(params[:id])
    respond_with to_do
  end

  def create
    to_do = current_user.to_dos.new(to_do_params)
    if to_do.save
      respond_with to_do, status: :created
    end
  end

  def update
    to_do = current_user.to_dos.find(params[:id])
    if to_do.update(to_do_params)
      respond_with to_do, status: :ok
    end
  end

  def destroy
    to_do = current_user.to_dos.find(params[:id])
    to_do.destroy
    respond_with status: :deleted
  end

  private

  def to_do_params
    params.require(:to_do).permit(:title, :priority, :due_date, :completed)
  end
end
