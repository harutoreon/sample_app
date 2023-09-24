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
      it 'トップページにリダイレクトされること' do
        post users_path, params: user_params
        expect(response).to redirect_to root_url  # サンプルアプリが最終形に達しているため、root_url とする。
      end
      it 'flashが表示されること' do
        post users_path, params: user_params 
        expect(flash).to be_any
      end
      # it 'ログイン状態であること' do
      #   post users_path, params: user_params
      #   expect(logged_in?).to be_truthy
      # end
    end

    context '無効な値の場合' do
      it '登録されないこと' do
        expect { post users_path, params: { user: { name: '',
                                                    email: 'user@invlid',
                                                    password: 'foo',
                                                    password_confirmation: 'bar' } }
        }.to_not change(User, :count)
      end      
    end
  end

  describe 'PATCH /users' do
    let!(:user) { FactoryBot.create(:user) }
    
    it 'タイトルがEdit user | Ruby on Rails Tutorial Sample Appであること' do
      # post login_path, params: { session: { email: user.email, password: user.password } }
      login(user)
      get edit_user_path(user)
      expect(response.body).to include full_title('Edit user')
    end
 
    context '無効な値の場合' do
      it '更新できないこと' do
        patch user_path(user), params: { user: { name: '',
                                                 email: 'foo@invlid',
                                                 password: 'foo',
                                                 password_confirmation: 'bar' } }
        user.reload
        expect(user.name).to_not eq ''
        expect(user.email).to_not eq ''
        expect(user.password).to_not eq 'foo'
        expect(user.password_confirmation).to_not eq 'bar'
      end
 
      it '更新アクション後にeditのページが表示されていること' do
        # post login_path, params: { session: { email: user.email, password: user.password } }
        login(user)
        get edit_user_path(user)
        patch user_path(user), params: { user: { name: '',
                                                 email: 'foo@invlid',
                                                 password: 'foo',
                                                 password_confirmation: 'bar' } }
        expect(response.body).to include full_title('Edit user')
      end
    end
  end
end