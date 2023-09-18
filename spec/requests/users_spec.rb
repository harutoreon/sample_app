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