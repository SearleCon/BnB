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
    Bnb.update_all(values_to_update(bnb), { :id => bnb.id })
  end

  private
  def values_to_update(bnb)
    bnb.changed_attributes.merge(bnb.attributes).slice(* ( bnb.changed_attributes.keys & bnb.attributes.keys ) )
  end

end