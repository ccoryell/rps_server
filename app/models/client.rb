class Client < ActiveRecord::Base
 devise :database_authenticatable, :registerable
  
 attr_accessible :email, :password, :password_confirmation
 

 
 
 def challengable_users
   
   Client.find ( :all, :conditions => [ "id != ?", self.id ])
 end
end
