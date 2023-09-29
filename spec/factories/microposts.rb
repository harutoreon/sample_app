FactoryBot.define do
  factory :orange, class: Micropost do
    content { 'I just ate an orange!' }
    created_at { 10.minutes.ago }
    user { association :user, email: 'orange@example.com' }
  end

  factory :cat_video, class: Micropost do
    content { 'Sad cats are sad: http://youtu.be/PKffm2uI4dk' }
    created_at { 2.hours.ago }
    user { association :user, email: 'video@example.com' }
  end

  factory :most_recent, class: Micropost do
    content { 'Writing a short test' }
    created_at { Time.zone.now }
    user { association :user, email: 'recent@example.com' }
  end
end

def user_with_posts(posts_count: 5)
  FactoryBot.create(:user) do |user|
    FactoryBot.create_list(:orange, posts_count, user: user)
  end
end