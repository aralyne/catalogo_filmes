require "rails_helper"

RSpec.describe Movie, type: :model do
    it { is_expected.to validate_presence_of(:title) } 
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:user) }
end 