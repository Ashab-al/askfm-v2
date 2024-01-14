require 'test_helper'
require "pundit/rspec"

RSpec.describe QuestionPolicy, type: :policy do 

  subject { described_class } 

  permissions :update do
    it "user can update if user is not author" do 
      expect(subject).not_to permit(User.new(...), Question(author: User.last))
    end
  end
end