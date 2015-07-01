require 'test_helper'
require 'rails/performance_test_help'

class AuthorizationTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  def setup
    Temping.create :dummy do
      with_columns do |t|
        t.string :name
        t.references :user
        t.references :policy
      end

      include Authorization

      belongs_to :user
      validates :user, presence: true
    end

    FactoryGirl.define do
      factory :dummy do
        user
      end

      factory :private_dummy, parent: :dummy do
        association :policy, factory: :private_policy
      end
    end

    visible = create_list(:dummy, 500)
    invisible = create_list(:private_dummy, 500)

    sign_in create(:user)
  end

end
