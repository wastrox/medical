# encoding: utf-8
class MorpherParser
 
 def initialize(phrase)
   client = Savon.client do |globals|
     globals.wsdl 'http://morpher.ru/WebService.asmx?WSDL'
     globals.soap_version 2
     globals.soap_header header
   end
 
   response = client.call(:get_xml, message: {s: phrase}, :attributes => {:xmlns => 'http://morpher.ru/'})
   @data = response.to_array(:get_xml_response, :get_xml_result).first
 end

 def puts_data
   return @data
 end
 
 private
 
 def header
   {
       'Credentials' => {
           'Username' => 'test',
           'Password' => 'test'
       },
       :attributes! => {'Credentials' => {:xmlns => 'http://morpher.ru/'}}
   }
 end
end