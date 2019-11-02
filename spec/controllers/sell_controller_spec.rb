require 'rails_helper'

RSpec.describe SellController, type: :controller do
  describe 'get #index ' do
    it "renders the get index template "do
      get :index 
      expect(response).to render_template :sell_index_path
    end
  end
end
