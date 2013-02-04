require_relative './bundle_helper'
module TitleBundleHelper
  @props_path = Rails.root + "app/resourcebundles/title_en.properties";
  @propertiesObj = BundleHelper.getProperties(@props_path);
  
  # Return value of the key from title props file, if key not found return nil
  def TitleBundleHelper.getMessage(key)
    return BundleHelper.getMessage(key, @propertiesObj);
  end
  
end
