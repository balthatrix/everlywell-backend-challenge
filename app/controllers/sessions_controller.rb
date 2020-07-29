class SessionsController < ApplicationController
  skip_before_action :check_authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @member = Member.find_by(name: params[:name])
   if @member && @member.authenticate(params[:password])
      session[:member_id] = @member.id
      redirect_to '/welcome'
   else
      redirect_to '/login'
   end
  end

  def destroy
    session[:member_id] = nil
    redirect_to '/login'
  end

  def login
  end

  def welcome
  end
end
