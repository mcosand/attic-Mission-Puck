FactoryGirl.define do
	factory :mission do |m|
		m.title 'Test Mission'
		m.started Time.now
		m.number '13-1234'
	end

  factory :log do |t|
    t.message 'Test message'
    t.when Time.now
  end
end
