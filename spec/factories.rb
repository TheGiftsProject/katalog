FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "github-username-#{n}" }
    sequence(:nickname)  { |n| "github-nickname-#{n}" }
    sequence(:uid)  { |n| "300184#{n}" }
    sequence(:email)  { |n| "email_text#{n}@email.com" }

    trait :isc_ci do
      name 'isc-ci'
      nickname 'isc-ci'
      email 'isc_ci@email.com'
      uid  '3001848'
    end
  end

  factory :project do
    title     "MyAwesomeKataRepo"
    subtitle  "My Awesome Kata Repo For Specs"

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
        create_list(:user, evaluator.users_count).each do |user|
          user.projects << project
          user.save
        end
      end
    end
  end

  factory :github_contributor, class: Hashie::Mash do

    skip_create

    sequence(:id)  { |n| "#{n+1}#{n+2}" } #github's uid
    login       'new-user-nickname'
    gravatar_id '5d38ab152e1e3e219512a9859fcd93af'

    initialize_with { Hashie::Mash.new(attributes) }
  end
end