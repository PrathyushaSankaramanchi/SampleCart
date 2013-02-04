require 'nokogiri'
require_relative '../beans/CShippingInfoBean'
require_relative '../beans/CAddressBean'

module XMLDataParser
  
  class Reader
    public
    def initialize()
      @shippingInfo = CShippingInfoBean.new
    end
    
    def getURL(defaultFilePath,websiteFilePath,websiteName)
      @xml_file_path = websiteFilePath+websiteName      
      @selectedCountry = websiteName
      begin        
        xml_file = File.open(@xml_file_path)
        
      rescue
        xml_file = nil
      
      ensure
        if xml_file.nil?
          websiteName = "default_configurations.xml"
          @xml_file_path = defaultFilePath+websiteName
          
          begin
            xml_file = File.open(@xml_file_path)
          rescue
            xml_file = nil
          end
        end
        @xml_file = xml_file
      end
    end 
    
    def getXMLData()
       begin          
          doc = Nokogiri::XML(@xml_file) { |cfg| cfg.noblanks }
          
       rescue
          doc = nil
        end       
       
       if !doc
         return nil
       else
           localAddressNode = doc.xpath("//localaddressfields/field")
           if localAddressNode.length > 0
              @address = Hash.new
              for i in 0..localAddressNode.length-1 do
                @addressInfo = CAddressBean.new
                 case localAddressNode[i]["name"]                                   
                    when 'title'                      
                       @addressInfo.titleDisplayed = localAddressNode[i]["displayed"]
                    when 'firstname'
                       @addressInfo.firstnameDisplayed = localAddressNode[i]["displayed"]
                    when 'lastname'
                       @addressInfo.lastnameDisplayed = localAddressNode[i]["displayed"]
                    when 'streetmailing'
                       @addressInfo.streetmailingDisplayed = localAddressNode[i]["displayed"]
                    when 'streetmailing2'
                       @addressInfo.streetmailing2Displayed = localAddressNode[i]["displayed"]
                    when 'streetmailing3'
                       @addressInfo.streetmailing3Displayed = localAddressNode[i]["displayed"]
                    when 'citymailing'
                       @addressInfo.citymailingDisplayed = localAddressNode[i]["displayed"]
                    when 'statemailing'
                       @addressInfo.statemailingDisplayed = localAddressNode[i]["displayed"]
                    when 'zipmailing'
                       @addressInfo.zipmailingDisplayed = localAddressNode[i]["displayed"]
                    when 'mailingcountrycode'
                       @addressInfo.mailingcountrycodeDisplayed = localAddressNode[i]["displayed"]
                    when 'emailaddress'
                       @addressInfo.emailaddressDisplayed = localAddressNode[i]["displayed"]
                    when 'phonenumber1'
                       @addressInfo.phonenumber1Displayed = localAddressNode[i]["displayed"]
                    when 'phonenumber2'
                       @addressInfo.phonenumber2Displayed = localAddressNode[i]["displayed"]
                   end
                   @addressInfo.isMandatory = localAddressNode[i]["ismandatory"]                   
                   @address[localAddressNode[i]["name"]] = @addressInfo                     
              end  
                        
           else
             return nil
           end
           
         @shippingInfo.address = @address
         
         
         #Check for International shipping enabled?
         intlShippingAddressNode = doc.xpath("//shippingaddress/internationaladdress")
         @shippingInfo.intlShippingEnabled = intlShippingAddressNode[0]["enabled"]
         
         if intlShippingAddressNode[0]["enabled"] == "yes"
           childCount = intlShippingAddressNode.children.count
           countryArray = Array.new
           countryCodesArray = Array.new
           countryCodesHash = Hash.new
           (0..childCount-1).each { |j|
              countryArray << intlShippingAddressNode.children[j].text     
              code = intlShippingAddressNode.children[j].attributes["value"]
              countryCodesArray << code  
              countryCodesHash[code] = intlShippingAddressNode.children[j].text                    
           }           
           @shippingInfo.country = countryArray
           @shippingInfo.countryCodes = countryCodesArray
         else
           @shippingInfo.country = []
         end
         
         stateFieldCodesNode = doc.xpath("//shippingoption/statefieldvalues")
          stateFieldCount = stateFieldCodesNode.children.count
          if stateFieldCount > 0
            stateArray = Array.new
            stateCodesArray = Array.new
            stateCodesHash = Hash.new
            (0..stateFieldCount-1).each { |k|
              stateArray << stateFieldCodesNode.children[k].text    
              statecode = stateFieldCodesNode.children[k].attributes["value"]
              stateCodesArray << statecode
              stateCodesHash[statecode] = stateFieldCodesNode.children[k].text 
            }
            @shippingInfo.state = stateArray
            @shippingInfo.stateCodes = stateCodesArray
           else
             @shippingInfo.state = []
          end     
      end
      
      if @selectedCountry == "snapfish_us_configurations.xml"
        @shippingInfo.selectedCountry = "US"
      elsif @selectedCountry == "snapfish_uk_configurations.xml"
        @shippingInfo.selectedCountry = "UK"
      else
        @shippingInfo.selectedCountry = ""
      end
      
      shippingMethodNode = doc.xpath("//shippingmethods/shippingmethod")
      if shippingMethodNode.length > 0
          @shippingMethodArray = Array.new
              for i in 0..shippingMethodNode.length-1 do
                 case shippingMethodNode[i]["name"]                
                    when 'UFC'
                       @shippingMethodArray << "standard: 3-5 business days, once item(s) produced $3.93"
                    when 'ASD'
                       @shippingMethodArray << "2 day: 2 business days, once item(s) produced $11.93"                       
                    when 'AOE'
                       @shippingMethodArray << "overnight: 1 business day, once item(s) produced $13.93"
                     
                  end
               end
          @shippingInfo.shippingCode = @shippingMethodArray
       end      
             
      return @shippingInfo
    end
 end

end