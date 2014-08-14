class Sprangular::CreditCardsController < Sprangular::BaseController
  before_filter :check_authorization

  def destroy
    authorize! :update, @user

    credit_card = @user.credit_cards.find params[:id]
    @user.drop_payment_source(credit_card) if credit_card

    respond_with credit_card
  end
end
