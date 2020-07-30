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

  def search
    redirect_to "/members/#{params[:id]}?search=#{URI.encode(params[:search])}"
  end

  def show
    @member = Member.find(params[:id])

    @search = params[:search]

    unless @search.blank?
      # this assumes one topic
      @matching_topic = Topic.search(@search).last

      if @matching_topic
        # this assumes the first member/owner of the topic
        @expert_member = @matching_topic.members.first

        @shortest_path_to_expert = Friendship.shortest_path(@member, @expert_member)
      end
    end
  end
end
