class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]

  def index
    @tickets = Ticket.all

    if params[:project] != '' && params[:project]
      @tickets = @tickets.filter_by_project(params[:project])
    end

    if params[:status] != '' && params[:status]
      @tickets = @tickets.filter_by_status(params[:status])
    end

    if params[:tag] != '' && params[:tag]
      @tickets = @tickets.filter_by_tag(params[:tag])
    end
  end

  def show
    @comment = Comment.new
  end

  def new
    @ticket = Ticket.new
    @ticket.creator = current_user

    if params[:project] && Project.find_by(id: params[:project])
      @ticket.project_id = params[:project]
    end
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.creator = current_user

    if @ticket.save
      @ticket.add_tags(params[:tags]) if params[:tags]
      flash[:notice] = "The ticket was created successfully."
      redirect_to ticket_path(@ticket)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      @ticket.add_tags(params[:tags]) if params[:tags]
      flash[:notice] = "This ticket was updated successfully."
      redirect_to ticket_path(@ticket)
    else
      render :edit
    end
  end

  def destroy
    if @ticket.destroy
      flash[:notice] = "The ticket was deleted successfully."
    else
      flash[:error] = "The ticket was not able to be deleted. Please try again."
    end
    redirect_to tickets_path
  end

  private

  def ticket_params
    params.require(:ticket).permit(:project_id, :name, :body, :status, :assignee_id)
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end
end
