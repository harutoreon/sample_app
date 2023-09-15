RSpec.describe 'hello' do
  it 'message return hello' do
    message = 'Hello'
    expect(message.downcase).to eq 'hello'
  end
end