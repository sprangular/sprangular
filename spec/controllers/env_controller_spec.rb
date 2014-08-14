require 'rails_helper'

describe Sprangular::EnvController do
  context "GET show" do
    before do
      get :show
    end

    specify { expect(assigns[:config]).to eql(Spree::Config) }
    specify { expect(response).to be_success }
  end
end
