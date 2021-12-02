FactoryBot.define do
  factory :movie do
    user
    link { "https://www.youtube.com/watch?v=test" }
    title { "title" }
    description { "description" }
  end
end
