require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other) { FactoryBot.create(:archer) }
  let(:relationship) { Relationship.new(follower_id: user.id, followed_id: other.id) }
  
  it 'は、有効であること' do
    expect(relationship).to be_valid
  end

  it 'のfollower_idがない場合は、無効であること' do
    relationship.follower_id = nil
    expect(relationship).to_not be_valid
  end

  it 'のfollowed_idがない場合は、無効であること' do
    relationship.followed_id = nil
    expect(relationship).to_not be_valid
  end
end
