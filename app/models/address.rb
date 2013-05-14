class Address

  def initialize(address)
    @geo_address = Geocoder.search(address).first
  end

  def street_address
     "#{street_number} #{street}"
  end

  def suburb
    [:political, :sublocality].each do |item|
      entity = @geo_address.address_components_of_type(item).first
      return entity['long_name'] if entity
    end
  end

  def postal_code
     @geo_address.postal_code
  end

  def city
    @geo_address.city
  end

  def region
    @geo_address.state
  end

  def country
    @geo_address.country
  end

  def latitude
    @geo_address.latitude
  end

  def longitude
    @geo_address.longitude
  end

  private
  def street_number
    entity = @geo_address.address_components_of_type(:street_number).first
    entity['long_name'] if entity
  end

  def street
    entity = @geo_address.address_components_of_type(:route).first
    entity['long_name'] if entity
  end
end