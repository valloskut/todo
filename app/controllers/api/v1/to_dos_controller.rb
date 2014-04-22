class Api::V1::ToDosController < Api::V1::BaseController
  def index
    @to_dos = current_user.to_dos
  end

  def show
    @to_do = current_user.to_dos.find_by_id(params[:id])
    if @to_do.blank?
      render json: {error: "ToDo with ID##{params[:id]} not found"}, status: :not_found
    end
  end

  def create
    @to_do = current_user.to_dos.new(to_do_params)
    if @to_do.save
      render :show, status: :created
    else
      render json: {error: "ToDo cannot be created"}, status: :unprocessable_entity
    end
  end

  def update
    @to_do = current_user.to_dos.find_by_id(params[:id])
    if @to_do
      if @to_do.update(to_do_params)
        render :show, status: :ok
      else
        render json: {error: "ToDo with ID##{params[:id]} cannot be updated"}, status: :unprocessable_entity
      end
    else
      render json: {error: "ToDo with ID##{params[:id]} not found"}, status: :not_found
    end
  end

  def destroy
    @to_do = current_user.to_dos.find_by_id(params[:id])
    if @to_do
      if @to_do.destroy
        render nothing: true, status: :no_content
      else
        render json: {error: "ToDo with ID##{params[:id]} cannot be destroyed"}, status: :unprocessable_entity
      end
    else
      render json: {error: "ToDo with ID##{params[:id]} not found"}, status: :not_found
    end
  end

  private

  def to_do_params
    params.require(:to_do).permit(:title, :priority, :due_date, :completed)
  end
end
