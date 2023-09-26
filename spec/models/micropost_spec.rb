require 'rails_helper'
 
RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { Micropost.new(content: 'Lorem ipsum', user_id: user.id) }

  it 'は、有効であること' do
    expect(micropost).to be_valid
  end
 
  it 'のuser_idがない場合は、無効であること' do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end
end