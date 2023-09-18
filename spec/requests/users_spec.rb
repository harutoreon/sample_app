require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "return http success" do
      get signup_path
      expect(response).to have_http_status(200)
    end
    it 'Sign up | Ruby on Rails Tutorial Sample Appが含まれること' do
      get signup_path
      expect(response.body).to include full_title('Sign up')
    end
  end

  context '有効な値の場合' do
    let(:user_params) { { user: { name: 'Example User',
                                  email: 'user@example.com',
                                  password: 'password',
                                  password_confirmation: 'password' } } }

    it '登録されること' do
      expect {
        post users_path, params: user_params
      }.to change(User, :count).by 1
    end
 
    it 'users/showにリダイレクトされること' do
      post users_path, params: user_params
      expect(response).to redirect_to root_url  # サンプルアプリが最終形に達しているため、root_url とする。
    end
  end

  describe 'POST /users #create' do
    it 'は、無効な値だと登録されないこと' do
      expect { post users_path, params: { user: { name: '',
                                                  email: 'user@invlid',
                                                  password: 'foo',
                                                  password_confirmation: 'bar' } }
      }.to_not change(User, :count)
    end
  end
end