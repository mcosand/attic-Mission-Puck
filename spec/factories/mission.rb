FactoryGirl.define do
	factory :mission do |m|
		m.title 'Test Mission'
		m.started Time.now
		m.number '13-1234'

    after(:create) do |m,evaluator|
      m.create_children({})
    end
	end

end
