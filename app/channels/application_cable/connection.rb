module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_customer

    def connect
      self.current_customer = find_verified_customer
    end

    private

    def find_verified_customer
      Customer.find(request.env['warden'].user.id)
    rescue
      reject_unauthorized_connection
    end
  end
end
