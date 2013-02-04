require_relative './title_bundle_helper';
require_relative './util_helper';
module ApplicationHelper
  
  def getTitle
    baseTitle = TitleBundleHelper.getMessage("base_title");
    title = !UtilHelper.isEmptyOrNil(@title) ? baseTitle + " | " + @title : baseTitle;  
    return title;
  end
  
end
