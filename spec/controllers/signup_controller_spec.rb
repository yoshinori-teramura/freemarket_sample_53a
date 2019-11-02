require 'rails_helper'

RSpec.describe SignupController, type: :controller do
  describe 'get #registration_type' do
    it "renders the :registration_type template" do
      get :registration_type
      expect(response).to render_template :registration_type
    end
  end

  describe 'get #registration' do
    it "reders the :registration template" do
      get :registration
      expect(response).to render_template :registration
    end
  end
  
  describe 'get #sms_confirmation' do
    it "renders the :sms_confirmation " do
      get :sms_confirmation, params:{user:{user_id:"1"}}
      expect(response).to render_template :sms_confirmation
    end
  end

  describe 'get #address' do
    it "renders the :address template " do
      get :address, params:{user:{user_id:"1"}}
      expect(response).to render_template :address
    end
  end

  describe 'get #credit' do
    it "render the :credit template " do
      get :credit,params:{user:{user_id:"1"}}
      expect(response).to render_template :credit
    end
  end

  describe 'post #create' do
    context 'not have the necessary valu'do
      it "redireect to the :complete template" do
        post :create ,params:{user:{user_id:"1"}}
        expect(response).to render_template :'signup/registration'
      end
    end
    context 'have the necessary value' do
      it "redirect to the :complete template" do
        post :create ,
        params:{
          user:{
            id:"1",
            nickname: "test",
            email: "test@test",
            password: "aaaaaa",
            password_confirmation: "aaaaaa",
            family_name: "test",
            first_name: "test",
            family_kana_name: "test_kana",
            first_kana_name: "test_kana",
            birthday: "2019-01-01",
            tel:"08012345678",
            address_attributes:{
              user_id:"1",
              delivery_family_name:"test",
              delivery_first_name:"test",
              delivery_family_kana_name: "test_kana",
              delivery_first_kana_name:"test_kana",
              post_code:"1234567",
              city:"test",
              block:"test",
              prefecture_id:"13"
            },
            credit_attributes:{
              user_id:"1",
              number:"0000000000000000",
              expiration_date:"0021-01-05",
              security_code:"123"
            }
          }
        }
        expect(response).to render_template :complete
      end
    end
  end
end

