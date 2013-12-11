class SessionsController < ApplicationController
  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.authenticate session_params[:email], session_params[:password]

    if @user.valid?
      login! @user
      redirect_to root_url, notice: "Logged in!"
    else
      render action: "new"
    end
  end

  # DELETE /logout
  def destroy
    logout!
    redirect_to root_url, notice: "Logged out!"
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:user).permit(:email, :password)
  end
end
