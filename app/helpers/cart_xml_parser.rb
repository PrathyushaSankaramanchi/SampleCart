require "rexml/document";
require_relative "../beans/shopping_cart_bean";
require_relative "../beans/shipbin_bean";
require_relative "../beans/line_item_bean";
require_relative "../service/http_client_util";
include REXML; # so no need to suffix REXML where ever we wanted to use it.
module CartXmlParser
  def CartXmlParser.getOrders(uri_excluding_base_url, accountOid, partnerOid, label='cart', tax='real')
    #puts("START TIME : #{Time.new()}");
    private 
    orders = Hash.new();
    #file_path="/home/kdandeboina/development/RubyCart/samplecart/app/xmls/orders_from_commerce.xml";
    # @xmlFile = File.new(file_path);
    #doc = REXML::Document.new(@xmlFile); # no need to prefix REXML:: as we have included it.
    # accountOid, partnerOid should get from OAUTH or session
    #query_params = {"accountOid"=>"5000050", "partnerOid"=>"1", "label"=>"mobile", "tax"=>"real"};
    query_params = {"accountOid"=>accountOid, "partnerOid"=>partnerOid, "label"=>label, "tax"=>tax};
    xml_content_from_rest_api = HttpClientUtil.getContent(uri_excluding_base_url, query_params);
    doc = REXML::Document.new(xml_content_from_rest_api); # no need to prefix REXML:: as we have included it.
    root = doc.root;
    #ordersxpath = "sps.resource.pojo.order.Order"; 
    allElements = root.elements();
    #puts("Total orders in this response: " + allElements.size().to_s());
    # loop all the orders and prepare an object
    shoppingcartBean = ShoppingCartBean.new();
      shoppingcartBean.oid = root.get_text("oid");
      shoppingcartBean.productTotal = root.get_text("productTotal");
      shoppingcartBean.productTax = root.get_text("productTax");
      shoppingcartBean.shippingTotal = root.get_text("shippingTotal");
      shoppingcartBean.shippingTax = root.get_text("shippingTax");    
      shoppingcartBean.shippingDiscount = root.get_text("shippingDiscount");
      shoppingcartBean.totalRefund = root.get_text("totalRefund");
      shoppingcartBean.partnerOid = root.get_text("partnerOid");
      shoppingcartBean.partnerOid = root.get_text("partnerOid");
      shoppingcartBean.label = root.get_text("label");
      shoppingcartBean.creditCardOid = root.get_text("creditCardOid");
      shoppingcartBean.status = root.get_text("status");
      
      shipBin_elements = root.get_elements("shipBins/sps.resource.pojo.order.ShipBin")
      # create bean object and set data into that object
        shipbins_hash = Hash.new();
        if(shipBin_elements != nil)
        shipBin_elements.each() { |shipBin|
          # set into bean
          shipBinBean = ShipbinBean.new();
          shipBinBean.shipBinId = shipBin.get_text('shipBinId');
          shipBinBean.productTotal = shipBin.get_text('productTotal');
          shipBinBean.shippingTotal = shipBin.get_text('shippingTotal');
          shipBinBean.productTax = shipBin.get_text('productTax');
          shipBinBean.deliveryOption = shipBin.get_text('deliveryOption');
          shipBinBean.deliveryMethod = shipBin.get_text('deliveryMethod');
          shipBinBean.shippingAddressOid = shipBin.get_text('shippingAddressOid');
          
          lineItems_hash = Hash.new();
          lineItems = shipBin.get_elements("lineItems/sps.resource.pojo.order.LineItem");
          lineItems.each() {|lineItem|
            lineItemBean = LineItemBean.new();
            # set into bean
            lineItemBean.productTotal = lineItem.get_text('productTotal');
            lineItemBean.shippingTotal = lineItem.get_text('shippingTotal');
            lineItemBean.productTax = lineItem.get_text('productTax');
            lineItemBean.lineItemId = lineItem.get_text('lineItemId');
            lineItemBean.skuOid = lineItem.get_text('skuOid');
            lineItemBean.projectOid = lineItem.get_text('projectOid');
            lineItemBean.quantity = lineItem.get_text('quantity');
            lineItemBean.vendor = lineItem.get_text('vendor');
            lineItemBean.priceLevel = lineItem.get_text('priceLevel');
            
            lineItemOptions = lineItem.get_elements("lineItemOptions");
            lineItemOptions.each() {|lineItemOption|
              # set into bean
              #  puts(lineItemOption);
            }
            lineItemRefunds = lineItem.get_elements("refunds");
            lineItemRefunds.each() {|lineItemRefund|
              # set into bean
              # puts(lineItemRefund);
            }
            lineItems_hash[lineItemBean.lineItemId] = lineItemBean;
          }
         shipBinBean.lineItems = lineItems_hash;
         shipbins_hash[shipBinBean.shipBinId] = shipBinBean;
        }
        end
      shoppingcartBean.shipBins = shipbins_hash;
      #p shoppingcartBean.shipBins
      orders[shoppingcartBean.oid] = shoppingcartBean;
    return orders;
  end
=begin  
  # loop to test the data.
  orders_local = CartXmlParser.getOrders('cart','5000050','1','mobile','real')
  for i in 0..orders_local.length
   # puts(orders_local.keys[i]);
#    puts(orders_local.values[i].to_s());
  end
=end
  END{
    if(@xmlFile != nil)
      @xmlFile.close();
    end
    #puts("END TIME : #{Time.new()}");
  }
end