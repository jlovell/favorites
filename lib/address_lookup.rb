module AddressLookup
  def self.find(name:, city: nil)
    query = [name, city].compact.join(', ')
    first_result = api_client.spots_by_query(query).first
    first_result && first_result.formatted_address
  end

  def self.api_client
    @client ||= GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
  end
end
