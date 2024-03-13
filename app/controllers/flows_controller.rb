class FlowsController < ApplicationController
  rescue_from CanCan::AccessDenied do |exception|
    render "shared/access_denied", status: :forbidden
  end

  load_and_authorize_resource 

def index
  @flows = Flow.where(company_id: current_user.company_id)
end

def show
    @flow = Flow.find(params[:id])
  end

  def new
    @flow = Flow.new
  end

  def create
    @flow = Flow.new(flow_params)

    if @flow.save
      redirect_to @flow, notice: 'Flow was successfully created.'
    else
      render :new
    end
  end

  def edit
    # @expense = Expense.find(params[:id])
    @flow = Flow.find(params[:id])
    @users_for_dropdown =  users_for_dropdown
  end

  def update
    @flow = Flow.find(params[:id])
    @users_for_dropdown =  users_for_dropdown
  
    if @flow.update(flow_params)
      # Store the selected assigned_user_id
      assigned_user_id = flow_params[:assigned_user_id]
  
      # Update assigned_user_id for all flows
      Flow.update_all(assigned_user_id: assigned_user_id)
      FlowMailer.flow_updated(@flow).deliver_now
  
      redirect_to @flow, notice: 'Flow was successfully updated.'
    else
      render :edit
    end
  end
  

  def destroy
    @flow = Flow.find(params[:id])
    @flow.destroy

    redirect_to flows_url, notice: 'Flow was successfully destroyed.'
  end

  private

  def users_for_dropdown
    current_user.company.users.pluck(:firstname, :id)
  end

  def flow_params
    params.require(:flow).permit(:user_assigned_id, :assigned_user_id, :start_date, :end_date)
  end
end