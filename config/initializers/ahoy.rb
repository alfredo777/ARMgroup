class Ahoy::Store < Ahoy::Stores::ActiveRecordTokenStore

  def User
     if controller.current_admin
      current_user = controller.current_admin
     end
     if controller.current_customer
      current_user = controller.current_customer 
     end
     puts current_user
     current_user
  end
  
end
