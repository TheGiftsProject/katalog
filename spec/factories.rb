FactoryGirl.define do
  factory :user do
    name 'isc-ci'
    uid  '3001848'
  end

  factory :project do
    title     "MyAwesomeKataRepo"
    repo_url  "https://github.com/iic-ninjas/MyAwesomeKataRepo"
    status    :idea

    ignore do
      users_count 1
    end

    after(:build) do |project, evaluator|
      if evaluator.users_count > 0
        #project.users << build_list(:users, evaluator.users_count, :project => project)
        project.users << build(:users, :project => project)
      end
    end
  end
end