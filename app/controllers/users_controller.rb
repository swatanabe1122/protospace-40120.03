class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @name = @user.name
    @prototypes = @user.prototypes

    #@name = current_user.name
    #@tweets = current_user.tweets
  end
end
