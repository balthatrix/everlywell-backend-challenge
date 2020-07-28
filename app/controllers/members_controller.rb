class MembersController < ApplicationController
  skip_before_action :check_authorized, only: [:new, :create]

  def new
    @member = Member.new
  end

  def create
    Member.transaction do
      @member = Member.create(params.require(:member).permit(:name, :password))
      @member.links << Link.from_url(@member, params.require(:member)[:website_address])
    end
    session[:member_id] = @member.id
    redirect_to '/welcome'
  end

  def show
    @member = Member.find(params[:id])
  end
end
