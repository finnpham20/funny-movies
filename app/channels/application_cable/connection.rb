# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      user_id = cookies.signed[:user_id]

      return reject_unauthorized_connection if user_id.blank?

      User.find(user_id)
    rescue StandardError
      reject_unauthorized_connection
    end
  end
end
