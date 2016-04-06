class Address < ActiveRecord::Base
  belongs_to :restaurant

  def self.parts_from_full(full_address)
    m = full_address.match(
      /(?<address_1>[^,]+), (?<city>[^,]+), (?<state>\w{2}) ?(?<zip>[\d\-]+)?/i
    )
    {
      address_1: m[:address_1],
      city:      m[:city],
      state:     m[:state],
      zip:       m[:zip],
    }
  end

  def formatted_address
    "#{address_1}, #{city}"
  end
end
