FactoryGirl.define do
  factory :log do |l|
    l.message 'Test message'
    l.when Time.now
  end
end
