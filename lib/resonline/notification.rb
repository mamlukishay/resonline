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
					                  <ns:Adults>' + options[:number_of_guests] + '</ns:Adults>
					                  <ns:CheckIn>' + options[:checkin].try(:xmlschema) + '</ns:CheckIn>
					                  <ns:CheckOut>' + options[:checkout].try(:xmlschema) + '</ns:CheckOut>
					                  <ns:Children>' + options[:children] + '</ns:Children>
					                  <!--Optional:-->
					                  <ns:CurrencyISO>' + options[:currency] + '</ns:CurrencyISO>
					                  <ns:Infants>' + options[:infants] + '</ns:Infants>
					                  <!--Optional:-->
					                  <ns:OwingAmount>' + options[:total_amount] +'</ns:OwingAmount>
					                  <ns:PropertyId>' + Resonline.configuration.hotel_id.to_s + '</ns:PropertyId>
					                  <ns:RoomCode>' + options[:room_code] + '</ns:RoomCode>
					                  <!--Optional:-->
					                  <ns:Quantity>' + options[:quantity] + '</ns:Quantity>
					                  <!--Optional:-->
					                  <ns:SpecialRequests>' + options[:special_request] + '</ns:SpecialRequests>
					               </ns:BookingDetails>
					               <!--Optional:-->
					               <ns:BookingRef>' + options[:booking_reference] + '</ns:BookingRef>
					               <!--Optional:-->
					               <ns:BookingType>' + options[:booking_type] + '</ns:BookingType>
					               <!--Optional:-->
					               <ns:CreditCardDetails>
					                  <ns:ExpiryDate>' + options[:cc_expired].try(:xmlschema) + '</ns:ExpiryDate>
					                  <ns:HolderFullName>' + options[:full_name] + '</ns:HolderFullName>
					                  <ns:Number>' + options[:cc_number] + '</ns:Number>
					                  <ns:VerificationNumber>' + options[:cc_verification_number] + '</ns:VerificationNumber>
					               </ns:CreditCardDetails>
					               <ns:MainGuest>
					                  <ns:AddressFirstLine>' + options[:address_1] + '</ns:AddressFirstLine>
					                  <!--Optional:-->
					                  <ns:AddressSecondLine>' + options[:address_2] + '</ns:AddressSecondLine>
					                  <ns:City>' + options[:city] + '</ns:City>
					                  <ns:CountryIso>' + options[:country_iso] + '</ns:CountryIso>
					                  <ns:Email>' + options[:email] + '</ns:Email>
					                  <ns:FirstName>' + options[:first_name] + '</ns:FirstName>
					                  <ns:LastName>' + options[:last_name] + '</ns:LastName>
					                  <!--Optional:-->
					                  <ns:Mobile>' + options[:mobile] + '</ns:Mobile>
					                  <ns:Phone>' + options[:phone] + '</ns:Phone>
					                  <ns:Postcode>' + options[:postcode] + '</ns:Postcode>
					                  <ns:State>' + options[:state] + '</ns:State>
					               </ns:MainGuest>
					            </dir:Booking>
					            <dir:RequestType>API</dir:RequestType>
					         </ns:request>
					      </ns:BookingNotification>
					   </soapenv:Body>
					</soapenv:Envelope>'
			response = client.call(:booking_notification, xml: xml)
			response.body[:booking_notification_response][:booking_notification_result][:response][:booking_response]
		end
	end
end