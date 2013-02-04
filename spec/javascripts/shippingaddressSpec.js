describe("instantiate the shipping view and check the method presence", function(){
	ship_view = ''
	beforeEach(function() {
  	  ship_view = new ShippingView({el: 'shipping_container'});
    });
    
	it("should expect the existance of initialize method", function() {
		expect(ship_view.initialize).toBeDefined();
	});
	
	it("should expect the existance of events method", function() {
		expect(ship_view.events).toBeDefined();
	});
	
	it("should expect the existance of loadAddress method", function() {
		expect(ship_view.loadAddress).toBeDefined();
	});
	
	it("should expect the existance of checkValidity method", function() {
		expect(ship_view.checkValidity).toBeDefined();
	});
	
});

describe("Check the Validations of the address fields", function(){
	var ship_view = ''
	beforeEach(function() {
  	  ship_view = new ShippingView({el: 'shipping_container'});
  	  window.addressFields = {"firstname":"no",
				"lastname":"no",
				"streetmailing":"yes",
				"streetmailing2":"no",
				"citymailing":"yes",
				"statemailing":"yes",
				"zipmailing":"yes",
				"mailingcountrycode":"yes"
		}
    });	
    
  	 
 	it("should be false if required field is undefined", function() {
 		for(key in addressFields){
 			if(addressFields[key].isMandatory == "yes"){
				expect(ship_view.checkValidity(key)).toBeFalsy();
			}
		}
	});
});

