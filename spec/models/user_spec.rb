require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.create(:user) }

  it 'userが有効であること' do
    expect(user).to be_valid
  end

  it 'nameが必須であること' do
    user.name = ''
    expect(user).to_not be_valid
  end

  it 'emailが必須であること' do
    user.email = ''
    expect(user).to_not be_valid
  end

  it 'nameは50文字以内であること' do
    user.name = 'a' * 51
    expect(user).to_not be_valid
  end

  it 'emailは255文字以内であること' do
    user.email = 'a' * 244 + "@example.com"
    expect(user).to_not be_valid
  end
end