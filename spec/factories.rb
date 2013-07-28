FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "github-username-#{n}" }
    sequence(:nickname)  { |n| "github-nickname-#{n}" }
    sequence(:uid)  { |n| "300184#{n}" }

    trait :isc_ci do
      name 'isc-ci'
      nickname 'isc-ci'
      uid  '3001848'
    end
  end

  factory :project do
    title     "MyAwesomeKataRepo"

    trait :idea do
      status :idea
    end

    trait :with_repo do
      repo_url  "https://github.com/iic-ninjas/MyAwesomeKataRepo"
    end

    ignore do
      users_count 1
    end

    after(:build) do |project, evaluator|
      if evaluator.users_count > 0
        create_list(:users, evaluator.users_count).each do |user|
          user.projects << project
          user.save
        end
      end
    end
  end
end