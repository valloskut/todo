require 'spec_helper'


describe 'API Information Page' do

  subject { page }
  context 'when not signed in' do
    before { visit api_path }
    it "redirects to sign in page" do
      expect(current_path).to eq(new_user_session_path)
    end
  end


  context 'when signed in' do
    before do
      @user = create :user
      sign_in(@user)
      visit api_path
    end
    it_behaves_like 'an authorised page'
    it { should have_content 'Email' }
    it { should have_field :email, with: @user.email }
    it { should have_content 'User Token' }
    it { should have_field :token, with: @user.authentication_token }
    it { should have_content 'API Endpoints' }
  end

end