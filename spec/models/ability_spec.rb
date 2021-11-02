require 'rails_helper'

RSpec.describe Ability do
  subject(:ability) { Ability.new(user) }
  
  context 'admin' do
    let(:user) { FactoryGirl.create(:user, admin: true) }
    
    it { should be_able_to :access, :rails_admin }
    it { should be_able_to :manage, :all }
  end
  
  context 'user' do
    let(:user) { FactoryGirl.create(:user) }
    
    it { should_not be_able_to :access, :rails_admin }
    it { should_not be_able_to :manage, :all }
  end
  
end
