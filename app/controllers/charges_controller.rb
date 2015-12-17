class ChargesController < ApplicationController

  def new
  end

  def create
    @amount = 200

    customer = Stripe::Customer.create(
      email:      params[:stripeEmail],
      card:       params[:stripeToken]
      )
    charge = Stripe::Charge.create(
      customer:       customer.id,
      amount:         @amount,
      description:    'Rails Stripe Customer',
      currency:       'usd'
      )
      current_user.premium!

    flash[:notice] = "Enjoy your premium membership!"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end

  def destroy
    @customer = Customer.find(params[:id])


    if @customer.destroy
      current_user.standard!
      flash[:notice] = "\"#{@wiki.title}\" was deleted"
      redirect_to wikis_path
    else
      flash.now[:alert] = "There was an error deleting your wiki!"
      render :show
    end
  end

end
