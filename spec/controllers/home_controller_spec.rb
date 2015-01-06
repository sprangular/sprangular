require 'rails_helper'

describe Sprangular::HomeController, type: :controller do
  context "GET index" do
    before do
      allow(controller).to receive_messages(current_spree_user: nil, current_order: nil)

      get :index, use_route: :sprangular_engine
    end

    specify { expect(response).to be_success }
  end
end
