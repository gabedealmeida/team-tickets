class CommentsController < ApplicationController
  before_action :require_user
  before_action :set_ticket, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = @ticket.comments.build(body: params[:comment][:body])
    @comment.creator = current_user

    if @comment.save
      update_ticket_status
      flash[:notice] = "Your comment was created successfully 💬"
    end

    redirect_to ticket_path(@ticket)
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      update_ticket_status
      flash[:notice] = "This comment was updated successfully ✍️"
      redirect_to ticket_path(@ticket)
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = "The comment was deleted successfully 🗑"
    else
      flash[:error] = "The comment was not able to be deleted. Please try again 😩"
    end
    redirect_to ticket_path(@ticket)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :status)
  end

  def set_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end

  def set_comment
    @comment = @ticket.comments.find(params[:id])
  end

  def update_ticket_status
    if @ticket.update_attribute(:status, params[:status])
      flash[:notice2] = 'Status was updated 📮'
    else
      flash[:error] = 'Status could not be updated ⛔️'
    end
  end
end
