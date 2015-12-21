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

    def downgrade
      @user = User.find(params[:user_id])
      @wikis = Wiki.where(user: @user)

      @user.standard!

      #@wiki_private = @wikis.where(private: true)

      @wikis.each do |pri|
        pri.private = false
        pri.save
      end
      

      flash[:notice] = "You have been downgraded to free account."
      redirect_to welcome_index_path

    end

end
