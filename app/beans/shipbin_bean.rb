class ShipbinBean
  attr_reader :shipBinId, :productTotal, :productTax, :productDiscount, :shippingTotal, \
    :shippingTax, :shippingDiscount, :totalRefund, :deliveryOption, :deliveryMethod, :shippingAddressOid, \
    :lineItems; 
  attr_writer :shipBinId, :productTotal, :productTax, :productDiscount, :shippingTotal, \
    :shippingTax, :shippingDiscount, :totalRefund, :deliveryOption, :deliveryMethod, :shippingAddressOid, \
    :lineItems;
end