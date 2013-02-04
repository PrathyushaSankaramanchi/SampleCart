 var ShippingView = Backbone.View.extend({			
				
	initialize: function(){	
		this.loadAddress();
	},
	
	events:{
		 "click #continueButton":"checkValidity"
	},
	
	loadAddress: function(){
		  //var template = _.template($("#shipping-address").html(), {});
		  $(this.el).html($("#shipping-address").html());
	},
	
	checkValidity: function() { 
		  for(key in addressFields){
		      if(addressFields[key].isMandatory == "yes"){
		      		if($('#'+key+'txt').val() == '')
		      			alert(key+" is mandatory")
		      			return false;
		      		}
		   }
	 }	      	       	      
 });
		
		    
		


