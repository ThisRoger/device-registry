# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReturnDeviceFromUser do
  subject(:return_device) do
    described_class.new(
      user: user,
      serial_number: serial_number,
      from_user: user
    ).call
  end

  let(:user) { create(:user) }
  let(:serial_number) { '123456' }


  context 'when user registers a device to himself' do
    let(:new_device_owner_id) { user.id }
    let(:from_user) { user.id }
    let(:another_user) { create(:user) }
    before do
      AssignDeviceToUser.new(
        requesting_user: user,
        serial_number: serial_number,
        new_device_owner_id: new_device_owner_id
      ).call
    end

    it 'when returning device, it succeeds' do
      service = ReturnDeviceFromUser.new(user: user, serial_number: serial_number, from_user: user.id)
      expect(service.call).to be_truthy
    end

    it 'when user tries to return a device he is not renting, it fails' do
      service = ReturnDeviceFromUser.new(user: user, serial_number: '654321', from_user: user.id)
      expect { service.call }.to raise_error(UnassigningError::DeviceNotRented)
    end

    it 'when another user tries to return this users device, it fails' do
      service = ReturnDeviceFromUser.new(user: another_user, serial_number: serial_number, from_user: user.id)
      expect { service.call }.to raise_error(UnassigningError::AlreadyUsedOnOtherUser)
    end

    context 'and when the user returns the same device' do
      before do
        ReturnDeviceFromUser.new(user: user, serial_number: serial_number, from_user: user.id)
        .call
      end
      it 'and tries to assign the same device to himself again, it fails' do
        service = AssignDeviceToUser.new(requesting_user: user,
                                         serial_number: serial_number,
                                         new_device_owner_id: new_device_owner_id
        )
        expect { service.call }.to raise_error(AssigningError::AlreadyUsedOnCurrentUser)
      end
    end
  end
end
