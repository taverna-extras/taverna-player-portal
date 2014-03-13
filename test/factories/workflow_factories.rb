FactoryGirl.define do
  factory :workflow do
    user
    document { File.new(Rails.root.join('test', 'fixtures', 'files', 'various_type_outputs.t2flow')) }
  end
end
