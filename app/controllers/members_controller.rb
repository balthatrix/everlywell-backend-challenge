class MembersController < ApplicationController
  skip_before_action :check_authorized, only: [:new, :create]

  def new
    @member = Member.new
  end

  def create
    Member.transaction do
      filtered_params = params.require(:member).permit(:name, :password, :website_address)
      @member = Member.create(filtered_params)
      web_addr = filtered_params[:website_address]
      @member.links << Link.from_url(@member, web_addr)
      Topic.create_member_topics(@member, web_addr)
    end
    session[:member_id] = @member.id
    redirect_to '/welcome'
  end

  def show
    @member = Member.find(params[:id])
  end
end
