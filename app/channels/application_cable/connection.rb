module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_customer

    def connect
      reject_unauthorized_connection unless find_verified_user
    end

    private

    def find_verified_user
      self.current_customer = env['warden'].user
    end
  end
end
