module Resonline
  SOAPPrefixUrl = 'https://api-pvt.resonline.com.au/direct/2.0/services/'
  SOAPNamespaces = { 
    namespaces: {
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:ns" => "http://cm.schema.com/direct/2.0/",
      "xmlns:ns1" => "http://cm.schema.com/api-core/2.0/"
    }
  }
end