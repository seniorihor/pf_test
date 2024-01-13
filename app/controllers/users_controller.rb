class UsersController < ApplicationController
  before_action :set_user, only: :update

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render :show, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    # value can be different types (eg. String or Array)
    params.fetch(:user, {}).permit(:username, custom_field_values_attributes: [:custom_field_id, :value, value: []])
  end
end
