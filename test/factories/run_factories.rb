FactoryGirl.define do
  factory :run, class: 'TavernaPlayer::Run' do
    user
    workflow
  end
end
