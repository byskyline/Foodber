class UserProfilesController < ApplicationController

  before_action :find_user

  def show
    @profile = @user.get_profile
  end

  def new
    @profile = @user.build_profile
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile

    if @profile.update( profile_params )
      redirect_to user_profile_url( @user )
    else
      render :action => :edit
    end

  end

  protected

  def find_user
    @user = User.find( params[:user_id] )
  end

  def profile_params
    params.require(:profile).permit(:name,:description)
  end

end


