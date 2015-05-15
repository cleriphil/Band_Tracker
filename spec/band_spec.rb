require('spec_helper')

describe(Band) do
  it {should have_and_belong_to_many(:venues)}
  it {should validate_presence_of(:name)}
  it{should validate_length_of(:name).is_at_most(50)}
  it {should validate_presence_of(:genre)}
  it{should validate_length_of(:genre).is_at_most(20)}
end
