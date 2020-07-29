class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.create(member_a: current_member, member_b: Member.find(params[:member_b_id]))
    redirect_to "/members/#{params[:member_b_id]}"
  end
end
