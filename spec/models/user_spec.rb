require 'spec_helper'

describe User, type: :model do
  it { should have_many :posts }
end
