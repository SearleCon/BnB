class ProcessAddressJob < Struct.new(:id)
  def perform
    bnb = Bnb.find(id)
    bnb.mappable = is_mappable?(bnb.full_address)

    if bnb.mappable?
      address = Address.new(bnb.full_address)
      bnb.address_line_one = address.street_address
      bnb.address_line_two = address.suburb
      bnb.postal_code = address.postal_code
      bnb.city = address.city
      bnb.region = address.region
      bnb.country = address.country
      bnb.latitude = address.latitude
      bnb.longitude = address.longitude
    end
    Bnb.update_all(values_to_update(bnb), { :id => bnb.id })
  end

  private
  def values_to_update(bnb)
    bnb.changed_attributes.merge(bnb.attributes).slice(* ( bnb.changed_attributes.keys & bnb.attributes.keys ) )
  end

  def is_mappable?(address)
    Gmaps4rails.geocode(address, true)
    true
  rescue
    false
  end

end