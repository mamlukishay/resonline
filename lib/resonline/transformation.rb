module Resonline
  module Transformation
    def self.soap_options
      options = Resonline::SOAPNamespaces.merge({
        endpoint: "#{Resonline::SOAPPrefixUrl}TransformationService.svc",
        wsdl: "#{Resonline::SOAPPrefixUrl}TransformationService.svc?wsdl=wsdl0"
      })
      options
    end

    def self.get_availability(room_id, start_date, end_date)
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.bookeasy.com/ws/api/2.1.0.0/"> 
          <soapenv:Header/> 
          <soapenv:Body> 
             <ns:GetAvailability> 
                <ns:XmlParameters><![CDATA[ 
                  <BookEasy> 
                    <Operator> 
                      <Credentials> 
                        <Username>' + Resonline.configuration.username + '</Username> 
                        <Password>' + Resonline.configuration.password + '</Password> 
                      </Credentials> 
                      <Rooms> 
                        <Room> 
                          <RoomID>' + room_id.to_s + '</RoomID> 
                        </Room> 
                      </Rooms> 
                    </Operator> 
                    <Options> 
                      <StartDate>' + start_date.strftime("%Y-%m-%d") + '</StartDate> 
                      <EndDate>' + end_date.strftime("%Y-%m-%d") + '</EndDate> 
                    </Options> 
                  </BookEasy>]]> 
                </ns:XmlParameters> 
             </ns:GetAvailability>
          </soapenv:Body>
        </soapenv:Envelope>'
      response = client.call(:get_availability, xml: xml)
      if response.success?
        return response.body[:get_availability_response][:get_availability_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end

    def self.set_availability(room_id, start_date, end_date, number_available)
      client = Savon.client(soap_options)
      xml = '
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://www.bookeasy.com/ws/api/2.1.0.0/">
          <soapenv:Header/> 
          <soapenv:Body> 
            <ns:SetAvailability> 
               <ns:XmlParameters><![CDATA[ 
                  <BookEasy> 
                    <Operator> 
                      <Credentials> 
                        <Username>' + Resonline.configuration.username + '</Username> 
                        <Password>' + Resonline.configuration.password + '</Password> 
                      </Credentials> 
                      <Rooms> 
                        <Room> 
                          <RoomID>' + room_id.to_s + '</RoomID> 
                          <Availabilities> 
                            <Availability> 
                              <StartDate>' + start_date.strftime("%Y-%m-%d") + '</StartDate> 
                              <EndDate>' + end_date.strftime("%Y-%m-%d") + '</EndDate> 
                              <NumberAvailable>' + number_available.to_s + '</NumberAvailable> 
                            </Availability> 
                          </Availabilities> 
                        </Room> 
                      </Rooms> 
                    </Operator> 
                  </BookEasy> 
                  ]]></ns:XmlParameters> 
            </ns:SetAvailability>
          </soapenv:Body> 
        </soapenv:Envelope>'
      response = client.call(:set_availability, xml: xml)
      if response.success?
        return response.body[:set_availability_response][:set_availability_result]
      else
        return Resonline::ErrorMessages.failed_response(response)
      end
    rescue Exception => e
      return Resonline::ErrorMessages.exception(e)
    end

  end

end