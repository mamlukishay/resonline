module Resonline
  module Inventory
    def self.soap_options
      options = Resonline::SOAPNamespaces.merge({
        endpoint: "#{Resonline::SOAPPrefixUrl}InventoryService.svc",
        wsdl: "#{Resonline::SOAPPrefixUrl}InventoryService.svc?wsdl=wsdl0"
      })
      options
    end

    def self.get_rate_packages
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://cm.schema.com/direct/2.0/" xmlns:ns1="http://cm.schema.com/api-core/2.0/">
          <soapenv:Header/>
          <soapenv:Body>
            <ns:GetRatePackages>
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
            </ns:GetRatePackages>
          </soapenv:Body>
        </soapenv:Envelope>'
      response = client.call(:get_rate_packages, xml: xml)
      if response.success?
        return response.body[:get_rate_packages_response][:get_rate_packages_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end

    def self.get_inventory(start_date, end_date, rate_package_ids = [])
      puts "-------- Start Date : #{start_date}, End Date : #{end_date} --------------"
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://cm.schema.com/direct/2.0/" xmlns:ns1="http://cm.schema.com/api-core/2.0/">
          <soapenv:Header/>
          <soapenv:Body>
             <ns:GetInventory>
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
                  <!--<ns1:HotelAuthenticationKey/>-->
                  <!--Optional:-->
                  <ns:EndDate>' + end_date.strftime("%Y-%m-%d") + '</ns:EndDate>
                  <ns:RatePackages>
                    <!--Zero or more repetitions:-->' + rate_package_ids.map { |id| "<ns:RatePackageId>#{id}</ns:RatePackageId>" }.join('') + '
                  </ns:RatePackages>
                  <!--Optional:-->
                  <ns:StartDate>' + start_date.strftime("%Y-%m-%d") + '</ns:StartDate>
                </ns:request>
             </ns:GetInventory>
          </soapenv:Body>
        </soapenv:Envelope>'
        pp xml
      response = client.call(:get_inventory, xml: xml)
      if response.success?
        return response.body[:get_inventory_response][:get_inventory_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end
  end
end
