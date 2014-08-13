require 'rails_helper'

describe Sprangular::HomeController do
  context "GET index" do
    before do
      get :index
    end

    specify { expect(response).to be_success }
  end
end
