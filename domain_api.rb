# Domain API - converted from JS to Ruby - Thanks to Arjun555

require 'httparty'

class DomainAPI

  def self.get_access_token
    clientId = ENV["DOMAIN_COM_AU_CLIENT_ID"]
    secret = ENV["DOMAIN_COM_AU_SECRET_ID"]

    p "clientid = #{clientId}"
    p "secret = #{secret}"

    authorization_encode = Base64.encode64("#{clientId}:#{secret}").chomp.gsub("\n",'')

    p "auth code = #{authorization_encode}"

    # querystring = 'grant_type=client_credentials&scope=api_agencies_read'

    return data = HTTParty.post(
      "https://auth.domain.com.au/v1/connect/token", 
      body: {
        grant_type: 'client_credentials',
        scope: 'api_agencies_read api_properties_read'
      },
      headers: {
        'Authorization': "Basic #{authorization_encode}",
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    )
  end

  def self.get_property_by_Id(listing_id, access_token)
    return data = HTTParty.get(
      "https://api.domain.com.au/v1/properties/#{listing_id}",
      headers: {
        'Authorization': "Bearer #{access_token}",
      }
    )
  end

  # search only residential properties
  def self.get_resi_properties_by_terms(search_query, access_token)
  return data = HTTParty.get(
      "https://api.domain.com.au/v1/properties/_suggest?channel=Residential&pageSize=10&terms=#{search_query}",
      headers: {
        'Authorization': "Bearer #{access_token}",
      }
    )
  end

end



