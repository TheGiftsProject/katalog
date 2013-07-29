require_relative 'spec_helpers/mocks/github_grabber_mock'

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

    trait :use_github_service_hook do
      mock_github_service_hook false
    end

    ignore do
      users_count 1
      mock_github_service_hook true
    end

    after(:build) do |project, evaluator|

      if evaluator.mock_github_service_hook and project.repo_url.present?
        mock_github_grabber = GithubGrabberMock.from_project(project)
        project.stub(:github_grabber).and_return(mock_github_grabber)
      end

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

    sequence(:id)  { |n| "#{n+1}#{n+2}#{n+3}" } #github's uid
    login       'new-user-nickname'
    avatar_url  'http://new-user.avatar-url.com'

    initialize_with { Hashie::Mash.new(attributes) }
  end
end