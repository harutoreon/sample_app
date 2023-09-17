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
end