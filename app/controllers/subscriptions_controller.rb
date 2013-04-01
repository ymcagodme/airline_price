class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @subscriptions = current_user.subscriptions.paginate(:page => params[:page])
  end

  def show
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def new
    @subscription = current_user.subscriptions.build
  end

  def create
    @subscription = current_user.subscriptions.create(params[:subscription])
    if @subscription.save
      redirect_to subscriptions_path
    else
      render :new
    end
  end

  def edit
    @subscription = current_user.subscriptions.find(params[:id])
  end

  def update
    @subscription = current_user.subscriptions.find(params[:id])
    if @subscription.update_attributes(params[:subscription])
      redirect_to @subscription
    else
      render :edit
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
    redirect_to subscriptions_path
  end
end
