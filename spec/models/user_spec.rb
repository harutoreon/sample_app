require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'は、有効であること' do
    expect(user).to be_valid
  end

  it 'のnameは、必須であること' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'のemailは、必須であること' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'のnameは、50文字以内であること' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it 'のemailは、255文字以内であること' do
    user.email = 'a' * 244 + "@example.com"
    expect(user).to_not be_valid
  end

  it 'のemailは、有効な形式であること' do
    valid_addresses = %w[user@exmple.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user.email = valid_address
      expect(user).to be_valid
    end
  end

  it 'のemailは、無効な形式であること' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      user.email = invalid_address
      expect(user).to_not be_valid
    end
  end

  it 'のemailは、大文字小文字を区別せず重複して登録できないこと' do
    duplicate_user = user.dup
    duplicate_user.email = user.email.upcase
    expect(duplicate_user).to_not be_valid
  end

  it 'のemailは、小文字でデータベースに登録されていること' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    user.email = mixed_case_email
    user.save
    expect(user.reload.email).to eq(mixed_case_email.downcase)
  end

  it 'のpasswordは、必須であること' do
    user.password = user.password_confirmation = ' ' * 6
    expect(user).to_not be_valid
  end
  
  it 'のpasswordは、6文字以上であること' do
    user.password = user.password_confirmation = 'a' * 5
    expect(user).to_not be_valid
  end

  describe '#authenticated?' do
    it 'digestがnilならfalseを返すこと' do
      expect(user.authenticated?(:remember, ' ')).to be_falsy
    end
  end

  describe '#follow and #unfollow' do
    let(:user) { FactoryBot.create(:user) }
    let(:other) { FactoryBot.create(:archer) }
   
    it 'followするとfollowing?がtrueになること' do
      expect(user.following?(other)).to_not be_truthy
      user.follow(other)
      expect(user.following?(other)).to be_truthy
    end
   
    it 'unfollowするとfollowing?がfalseになること' do
      user.follow(other)
      expect(user.following?(other)).to_not be_falsey
      user.unfollow(other)
      expect(user.following?(other)).to be_falsey
    end

    it 'followするとfollowing?がtrueになること' do
      expect(user.following?(other)).to_not be_truthy
      user.follow(other)
      expect(other.followers.include?(user)).to be_truthy
      expect(user.following?(other)).to be_truthy
    end
  end

  describe '#feed' do
    let(:posted_by_user) { FactoryBot.create(:post_by_user) }
    let(:posted_by_lana) { FactoryBot.create(:post_by_lana) }
    let(:posted_by_archer) { FactoryBot.create(:post_by_archer) }
    let(:user) { posted_by_user.user }
    let(:lana) { posted_by_lana.user }
    let(:archer) { posted_by_archer.user }
   
    before do
      user.follow(lana)
    end
   
    it 'フォローしているユーザの投稿が表示されること' do
      lana.microposts.each do |post_following|
        expect(user.feed.include?(post_following)).to be_truthy
      end
    end
   
    it '自分自身の投稿が表示されること' do
      user.microposts.each do |post_self|
        expect(user.feed.include?(post_self)).to be_truthy
      end
    end
   
    it 'フォローしていないユーザの投稿は表示されないこと' do
      archer.microposts.each do |post_unfollowed|
        expect(user.feed.include?(post_unfollowed)).to be_falsey
      end
    end
  end

  describe 'Alice' do
    let(:alice) { FactoryBot.build(:alice) }
    
    it 'は、有効であること' do
      expect(alice).to be_valid
    end

    it 'のname属性は、有効であること' do
      alice.name = ''
      expect(alice).to_not be_valid 
    end

    it 'のemail属性は、有効であること' do
      alice.email = ''
      expect(alice).to_not be_valid
    end

    it 'のnameは、50文字以内であること' do
      alice.name = 'a' * 51
      expect(alice).to_not be_valid
    end

    it 'のemailは、255文字以内であること' do
      alice.email = 'a' * 244 + '@example.com'
      expect(alice).to_not be_valid
    end
  end
end