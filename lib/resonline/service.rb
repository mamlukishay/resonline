module Resonline
  module Service
    def self.soap_options
      options = Resonline::SOAPNamespaces.merge({
        endpoint: "#{Resonline::SOAPPrefixUrl}ContentService.svc",
        wsdl: "#{Resonline::SOAPPrefixUrl}ContentService.svc?wsdl=wsdl1"
      })
      options
    end

    def self.get_hotel_rooms
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://cm.schema.com/direct/2.0/" xmlns:ns1="http://cm.schema.com/api-core/2.0/">
          <soapenv:Header/>
          <soapenv:Body>
             <ns:GetHotelRooms>
                <!--Optional:-->
                <ns:request>
                   <ns1:ChannelManagerUsername>' + Resonline.configuration.cm_username + '</ns1:ChannelManagerUsername>
                   <ns1:ChannelManagerPassword>' + Resonline.configuration.cm_password + '</ns1:ChannelManagerPassword>
                   <!--Optional:-->
                   <ns1:Username>' + Resonline.configuration.username + '</ns1:Username>
                   <!--Optional:-->
                   <ns1:Password>' + Resonline.configuration.password + '</ns1:Password>
                   <!--Optional:-->
                   <ns1:HotelId>' + Resonline.configuration.hotel_id.to_s + '</ns1:HotelId>
                   <!--Optional:-->
                </ns:request>
             </ns:GetHotelRooms>
          </soapenv:Body>
        </soapenv:Envelope>'
      response = client.call(:get_hotel_rooms, xml: xml)
      if response.success?
        return response.body[:get_hotel_rooms_response][:get_hotel_rooms_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end

    def self.get_hotel_rate_package_deals(rate_package_id)
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://cm.schema.com/direct/2.0/" xmlns:ns1="http://cm.schema.com/api-core/2.0/" xmlns:dir="http://schemas.datacontract.org/2004/07/DirectApi.Service.Content.Model">
          <soapenv:Header/>
          <soapenv:Body>
             <ns:GetHotelRatePackageDeals>
                <!--Optional:-->
                <ns:request>
                   <ns1:ChannelManagerUsername>' + Resonline.configuration.cm_username + '</ns1:ChannelManagerUsername>
                   <ns1:ChannelManagerPassword>' + Resonline.configuration.cm_password + '</ns1:ChannelManagerPassword>
                   <!--Optional:-->
                   <ns1:Username>' + Resonline.configuration.username + '</ns1:Username>
                   <!--Optional:-->
                   <ns1:Password>' + Resonline.configuration.password + '</ns1:Password>
                   <!--Optional:-->
                   <ns1:HotelId>' + Resonline.configuration.hotel_id.to_s + '</ns1:HotelId>
                   <!--Optional:-->
                   <dir:HotelRatePackageID>' + rate_package_id.to_s + '</dir:HotelRatePackageID>
                </ns:request>
             </ns:GetHotelRatePackageDeals>
          </soapenv:Body>
        </soapenv:Envelope>'
      response = client.call(:get_hotel_rate_package_deals, xml: xml)
      if response.success?
        return response.body[:get_hotel_rate_package_deals_response][:get_hotel_rate_package_deals_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end

  end

end