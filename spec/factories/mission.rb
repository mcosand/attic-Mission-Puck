FactoryGirl.define do

  factory :mission do
    title 'Test Mission'
    started { Time.now }
    number '13-1234'
  end

end
