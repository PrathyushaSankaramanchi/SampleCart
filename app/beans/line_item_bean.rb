class LineItemBean
  attr_reader :lineItemId, :productTotal, :productTax, :productDiscount, :shippingTotal, \
    :shippingTax, :shippingDiscount, :totalRefund, :skuOid, :projectOid, :quantity, :vendor, \
    :priceLevel, :line_item_Options; 
  attr_writer :lineItemId, :productTotal, :productTax, :productDiscount, :shippingTotal, \
    :shippingTax, :shippingDiscount, :totalRefund, :skuOid, :projectOid, :quantity, :vendor, \
    :priceLevel, :line_item_Options;
end