require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
  end
  describe 'get #index' do
    it "render the get :index template" do
      get :index
      expect(response).to render_template :index
    end
  end
  describe 'get #show' do
    it "render the get :show template" do
      user = @user
      item = create(:item,user_id:"1")
      get :show , params: {id:"1"}
      expect(response).to render_template :show
    end
  end
end
