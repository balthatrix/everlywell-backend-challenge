class LinksController < ApplicationController
  skip_before_action :check_authorized

  def show
    @link = Link.find_by code: params[:id]

    render(:file => Rails.root.join('public','404.html'),  :status => 404) and return unless @link

    redirect_to @link.url
  end
end
