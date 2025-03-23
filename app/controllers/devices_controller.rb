# frozen_string_literal: true

class DevicesController < ApplicationController
  before_action :authenticate_user!, only: %i[assign unassign]
  def assign
    begin
      AssignDeviceToUser.new(
        requesting_user: @current_user,
        serial_number: params[:device][:serial_number],
        new_device_owner_id: params[:new_owner_id]
      ).call
      head :ok
    rescue StandardError => e
      render json: { error: 'Unauthorized' }, status: 422
    end
  end

  def unassign
    begin
      ReturnDeviceFromUser.new(user: @current_user, serial_number: params[:serial_number], from_user: params[:user_id])
      .call
      head :ok
    rescue StandardError => e
      head :unprocessable_entity
    end
  end

  private

  def device_params
    params.permit(:new_owner_id, :serial_number)
  end
end
