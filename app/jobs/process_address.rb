class ProcessAddressJob < Struct.new(:id)
  def perform
    bnb = Bnb.find(id)
    address = Address.new(bnb.full_address)
    bnb.address_line_one = address.street_address
    bnb.address_line_two = address.suburb
    bnb.postal_code = address.postal_code
    bnb.city = address.city
    bnb.region = address.region
    bnb.country = address.country
    bnb.latitude = address.latitude
    bnb.longitude = address.longitude
    bnb.address_processed = "y"
    bnb.save!
  end

end