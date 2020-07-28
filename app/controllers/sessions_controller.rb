class SessionsController < ApplicationController
  skip_before_action :check_authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @member = Member.find_by(email: params[:email])
   if @member && @member.authenticate(params[:password])
      sessions[:member_id] = @member.id
      redirect_to '/welcome'
   else
      redirect_to '/login'
   end
  end

  def login
  end

  def welcome
  end
end
