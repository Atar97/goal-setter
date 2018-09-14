# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do 
    
    context 'Username' do
      FactoryBot.create(:user)
      
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username) }
    end 
    
    context 'Password' do 
      it { should validate_presence_of(:password_digest) }
      it { should validate_length_of(:password).is_at_least(6) }
    end 
    
    it { should validate_presence_of(:session_token) }
  end   
  
  describe "Class Methods" do 
    context "#find_by_credentials" do 
      user = FactoryBot.create(:user)
      it "Find the correct user" do 
        expect(User.find_by_credentials(user.username, 'starwars')).to eq(user)
      end 
    end 
  end 
  
  
   
end
