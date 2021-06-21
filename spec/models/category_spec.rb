# frozen_string_literal: true

require "rails_helper"

RSpec.describe Category, type: :model do
  context "associations" do
    it { should have_many(:products) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
  end
end
