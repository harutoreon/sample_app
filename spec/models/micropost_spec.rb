require 'rails_helper'
 
RSpec.describe Micropost, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let(:micropost) { user.microposts.build(content: 'Lorem ipsum') }

  it 'は、有効であること' do
    expect(micropost).to be_valid
  end
 
  it 'のuser_idがない場合は、無効であること' do
    micropost.user_id = nil
    expect(micropost).to_not be_valid
  end

  it '並び順は投稿の新しい順になっていること' do
    expect(FactoryBot.create(:most_recent)).to eq Micropost.first
    expect(FactoryBot.create(:orange)).to eq Micropost.second
    expect(FactoryBot.create(:cat_video)).to eq Micropost.last
  end

  describe 'content' do
    it 'が空なら、無効であること' do
      micropost.content = '    '
      expect(micropost).to_not be_valid
    end
   
    it 'が141文字以上なら、無効であること' do
      micropost.content = 'a' * 141
      expect(micropost).to_not be_valid
    end
  end
end