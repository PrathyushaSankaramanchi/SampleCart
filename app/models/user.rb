class User < ActiveRecord::Base
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i; #abc@abc.com
  #attr_reader :email, :firstname, :lastname, :password;
  #attr_writer :email, :firstname, :lastname, :password;
  attr_accessible :email, :firstname, :lastname, :password;
  
  validates :email, :firstname, :password, :presence => true;
  validates :email, :length => {:minimum => 7, :maximum => 20},
                    :format => {:with => email_regex},
                    :uniqueness => {:case_sensitive => false};
  validates :password, :length => {:minimum => 6};
  
end
