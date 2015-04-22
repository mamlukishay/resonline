module Resonline
	module Notification
		def self.soap_options
      options = Resonline::SOAPNamespaces.merge({
        endpoint: "#{Resonline::SOAPPrefixUrl}NotificationService.svc",
        wsdl: "#{Resonline::SOAPPrefixUrl}NotificationService.svc?wsdl=wsdl0"
      })
      options
    end
		def self.booking_notification(options={})
			client = Savon.client(soap_options)
			xml = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns="http://cm.schema.com/direct/2.0/" xmlns:ns1="http://cm.schema.com/api-core/2.0/" xmlns:dir="http://schemas.datacontract.org/2004/07/DirectApi.Service.Notification.Model">
					   <soapenv:Header/>
					   <soapenv:Body>
					      <ns:BookingNotification>
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
					            <ns1:HotelAuthenticationKey></ns1:HotelAuthenticationKey>
					            <dir:Booking>
					               <ns:BookingDetails>
					                  <ns:Adults>'+ options[:number_of_guests] +'</ns:Adults>
					                  <ns:CheckIn>'+ options[:checkin].try(:xmlschema) +'</ns:CheckIn>
					                  <ns:CheckOut>'+ options[:checkout].try(:xmlschema) +'</ns:CheckOut>
					                  <ns:Children>'+ options[:children] +'</ns:Children>
					                  <!--Optional:-->
					                  <ns:CurrencyISO>'+ options[:currency] +'</ns:CurrencyISO>
					                  <ns:Infants>'+ options[:infants] +'</ns:Infants>
					                  <!--Optional:-->
					                  <ns:OwingAmount>'+ options[:total_amount] +'</ns:OwingAmount>
					                  <ns:PropertyId>' + Resonline.configuration.hotel_id.to_s + '</ns:PropertyId>
					                  <ns:RoomCode>'+ options[:room_code] +'</ns:RoomCode>
					                  <!--Optional:-->
					                  <ns:Quantity>'+ options[:quantity] +'</ns:Quantity>
					                  <!--Optional:-->
					                  <ns:SpecialRequests>'+ options[:special_request] +'</ns:SpecialRequests>
					               </ns:BookingDetails>
					               <!--Optional:-->
					               <ns:BookingRef>'+ options[:booking_reference] +'</ns:BookingRef>
					               <!--Optional:-->
					               <ns:BookingType>'+ options[:booking_reference] +'</ns:BookingType>
					               <!--Optional:-->
					            </dir:Booking>
					            <dir:RequestType>API</dir:RequestType>
					         </ns:request>
					      </ns:BookingNotification>
					   </soapenv:Body>
					</soapenv:Envelope>'
			response = client.call(:booking_notification, xml: xml)
			response.body[:booking_notification_response]
		end
	end
end