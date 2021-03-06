class DownloadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  include Secured

  def index
    @admin = "talontest7@gmail.com"
    if curr_user_is_admin?
      @downloads = Download.all
    else
      @downloads = Download.where(email: session[:userinfo][:info][:email])
    end
  end

  def new
    if curr_user_is_admin?
      @download = Download.new
    else
      redirect_to '/'
    end
  end

  def create
    if curr_user_is_admin?
      @download = Download.new(download_params)

      if @download.save
        redirect_to downloads_path
        @notice = "Download request was successfully created."
      else
        redirect_to downloads_path
        @notice = "Download request was not created."
      end
    else
      #Jose made the following comment 04/12
      #below is set to nocov since this block will never be reached due to def new action redirecting
      #to root for non-admin users
      #@NOTE: should we even keep this block of code?
      # :nocov:
      redirect_to '/'
      # :nocov:
    end
  end

  def destroy
    Download.find(params[:id]).destroy
    redirect_to downloads_path
  end
  private

  def download_params
    params.require(:download).permit(:title, :file, :email)
  end
end
