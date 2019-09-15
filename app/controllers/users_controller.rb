class UsersController < ApplicationController

   before_action :authenticate_user! excpt: :index

  
  def index
    
  end



end
