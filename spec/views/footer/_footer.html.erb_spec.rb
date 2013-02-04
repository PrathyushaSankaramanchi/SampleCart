require 'spec_helper'

describe "footer/_footer.html.erb" do
  
  describe "should have valid information that" do  
                
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'cart-footer')
        end 
         
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'footer pushdown-10')
        end
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'footer-border')
        end      
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_selector('div', :class => 'footer-container')
        end
        
        it "should have the selector called 'div'" do   
          render         
          rendered.should have_content('T&C Privacy Pricing')
        end
  end              
        
end