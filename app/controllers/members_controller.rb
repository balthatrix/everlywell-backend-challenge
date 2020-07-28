class MembersController < ApplicationController
  skip_before_action :check_authorized, only: [:new, :create]

  def new
    @member = Member.new
  end

  def create
    @member = Member.create(params.require(:member).permit(:email, :password))
    session[:member_id] = @member.id
    redirect_to '/welcome'
  end

  def show
    @member = Member.find(params[:id])
  end
end
