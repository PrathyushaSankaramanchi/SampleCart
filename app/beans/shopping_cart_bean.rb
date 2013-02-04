class ShoppingCartBean
# Advanced way to create setters and getters
# create setters
  attr_writer :productTotal, :productTax, :productDiscount, :shippingTotal, \
  :shippingTax, :shippingDiscount, :totalRefund, :partnerOid, :accountOid, \
  :label, :creditCardOid, :status, :oid, :shipBins;
# Create getters
  attr_reader :productTotal, :productTax, :productDiscount, :shippingTotal, \
  :shippingTax, :shippingDiscount, :totalRefund, :partnerOid, :accountOid, \
  :label, :creditCardOid, :status, :oid, :shipBins;
  
  # try with attr_accessable instead reader and writer
  
  def to_s()
    return productTotal.to_s() + productTax.to_s() + productDiscount.to_s() + shippingTotal.to_s() + shippingTax.to_s() + shippingDiscount.to_s() + totalRefund.to_s() \
  + partnerOid.to_s() + accountOid.to_s() + label.to_s() + creditCardOid.to_s() + status.to_s() + oid.to_s();
  end
  
end