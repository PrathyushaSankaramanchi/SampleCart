require_relative './util_helper'
module BundleHelper
  
  # Return 'File' for valid path else 'nil'
  def BundleHelper.getBundleFile(path)
    if(!UtilHelper.isEmptyOrNil(path))
      begin
       file = File.new(path);
      rescue StandardError => err
        puts(err); # should use log file
        raise StandardError.new("Error while retrieving path at path:  #{path}");
      ensure
        if(file != nil)
          file.close();
        end
      end
    end
  end
  
  def BundleHelper.getProperties(path)
    file = self.getBundleFile(path);
    properties = Hash.new();
    begin
     IO.foreach(file) {|line|
      if(!line.start_with?('#'))
        keyValPair = line.split('=');
        properties[keyValPair[0]] = keyValPair[1].strip(); # strip method eliminates extra white spaces.
      end
     }
    rescue StandardError => err
      puts(err);
    end
    return properties;
  end
  
  def BundleHelper.getMessage(key, properties) 
    if (!UtilHelper.isEmptyOrNil(key))
      return properties[key];
    end
    return nil;
  end
  
  #properties = BundleHelper.getProperties("/home/kdandeboina/development/RubyCart/samplecart/app/resourcebundles/title_en.properties");
  #puts(properties["base_title"]);
  #puts(BundleHelper.getMessage("title", properties)); # return emty string as there is no key 'title'
end