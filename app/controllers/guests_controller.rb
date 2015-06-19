class GuestsController < ApplicationController
  before_filter :authorize, :only => [:edit, :update, :destroy]
  before_action :all_guests, only: [:index, :create, :update, :destroy]
  before_action :set_guest, only: [:show, :edit, :update, :destroy]


  # GET /guests/new
  def new
    @guest = Guest.new
  end

  # GET /guests
  # GET /guests.json 

  def option

    @choice = params[:choice].to_s
    @fontsize = params[:fontsize].to_s 
    @fontfam = params[:fontfam].to_s
    @guests = Guest.all

    respond_to do |format|
      format.html
      format.pdf do 
        pdf = GuestsPdf.new(@guests, @choice, @fontfam, @fontsize)
        send_data pdf.render, filename: "print.pdf",
                    type: "application/pdf",
                    disposition: "inline" 

      end 
    end 
    
  end

  def create
    @guest = Guest.create(guest_params)
    session[:guest_ids] ||= []
    session[:guest_ids] << @guest.id
  end

  def update 
    @guest.update(guest_params) 
  end 

  def destroy 
    @guest.destroy 
  end 

  def import 
    Guest.import(params[:file])
    redirect_to root_url, notice: "Guestlist imported."
  end 

  private
    def authorize 
      unless session[:guest_ids] && session[guest_ids].include?(params[:id].to_i)
        redirect_to root_path
      end 
    end 
    def all_guests
      @guests = Guest.all
    end 
    # Use callbacks to share common setup or constraints between actions.
    def set_guest
      @guest = Guest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def guest_params
      params.require(:guest).permit(:name, :table_num)
    end
end
