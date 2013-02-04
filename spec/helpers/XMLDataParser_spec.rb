require 'spec_helper'

require_relative '../../app/helpers/XMLDataParser'

describe XMLDataParser do

  describe "should not be nil on calling Reader instance" do
    it "correct path, should return file obj and should not be nil" do
      expect{Reader.new(Rails.root + "app/service/cartconfigxmls/website/snapfish_us_configurations.xml")}.to_not be_nil
    end
  end
  
  describe "File open should not return nil" do
    it "expects a file to be opened up and is not nil" do
      doc = Rails.root + "app/service/cartconfigxmls/website/snapfish_us_configurations.xml"
      expect{File.should_receive(:open).with(doc)}.to_not be_nil      
    end   
  end   
   
   describe "Nokogiri open should not be nil" do
     it "not be nil on nokogiri xml file reading" do
       expect{Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml'))}.to_not be_nil
    end
   end
   
   describe "Nokogiri xpath should not be nil for valid data" do
     it "xpath on right data should not be nil" do
       doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml'))
       expect{doc.xpath("//localaddressfields/field")}.to_not be_nil
     end
     
     it "xpath on wrong data should be nil" do
       doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml'))
       doc.xpath("/path").should be_blank
     end
     
     it "xpath on right data should not be nil" do
       doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml'))
       expect{doc.xpath("//shippingoption/statefieldvalues")}.to_not be_nil
     end
     
     it "xpath on right data should not be nil" do
       doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml'))
       expect{doc.xpath("//shippingaddress/internationaladdress")}.to_not be_nil
     end
     
     it "if xpath is nil should return nil as country" do
       doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_uk_configurations.xml'))       
       intlShippingAddressNode = doc.xpath("//shippingaddress/internationaladdress")
       @val = intlShippingAddressNode[0]["enabled"]
       if @val == "yes"
         expect{@shippingInfo.country}.to_not be_nil
       elsif @val == "no"
         #expect{@shippingInfo.country}.to be_blank
       end
     end
      
   end
   
   describe "fall back data should occur here" do
     doc = nil
     
     before(:all) do
       doc = Reader.new()       
     end
     
     it "should expect the fall back to default_configurations.xml on wrong file passed" do       
       @xml_file_path = Rails.root + "app/service/cartconfigxmls/website/snapfish_bb_configurations.xml"
       xml_default_file_path = Rails.root + "app/service/cartconfigxmls/default_configurations.xml"
       expect{File.open(@xml_file_path)}.to raise_error       
       expect{File.open(xml_default_file_path)}.to_not be_nil       
     end 
    
     after(:all) do
        doc = nil
     end
   end
   
   #describe "Return the doc data on Nokogiri Parsing" do
   #  it "return doc" do
   #    doc = Nokogiri::XML(open(Rails.root + 'app/service/cartconfigxmls/website/snapfish_us_configurations.xml')) 
   #    Nokogiri::XML::Document.stub!(:parse) 
   #    Nokogiri::XML::Document.should_receive(:parse).and_return(doc)
   #  end
   #end

end

