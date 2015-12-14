class ConnectionsController < ApplicationController

  def add_friend
    @new_friend = Connection.new(:from_id => current_user.id, :to_id => User.find(connection_params[:to_id]).id)
    if @new_friend.save
      redirect_to users_path
    else
      'errors'
    end
  end

  def unfriend
    @friend = Connection.where(:to_id => connection_params[:to_id])
    if @friend.any? && @friend.destroy_all
      redirect_to users_path
    else
      'User cannot found'
    end
  end

  private
    def connection_params
      params.permit(:to_id)
    end
end
