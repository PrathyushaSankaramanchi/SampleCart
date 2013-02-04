class CShippingInfoBean
  
  attr_accessor :intlShippingEnabled, :country, :countryCodes, :state, :stateCodes, :selectedCountry, \
                :shippingCode, :address
                
  def initialize
    self.country = []
    self.countryCodes = []
    self.state = []    
    self.stateCodes = []
    self.shippingCode = []
    self.address = {}
  end  

end