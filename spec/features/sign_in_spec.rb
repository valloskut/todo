require 'spec_helper'


describe 'Sign In Page' do
  let(:user) { create :user }

  subject { page }
  context 'when not signed in' do
    before { visit new_user_session_path }
    it { should have_content 'Email' }
    it { should have_field 'user[email]' }
    it { should have_content 'Password' }
    it { should have_field 'user[password]' }
    it { should have_content 'Remember me' }
    it { should have_unchecked_field 'user[remember_me]' }
    it { should have_button 'Sign In', new_user_session_path }
    it { should have_link 'Sign Up', href: new_user_registration_path }

    describe "sign in with valid credentials" do
      it "redirects back to referrer" do
        [root_path, api_path].each do |path|
          visit path
          sign_in user
          expect(current_path).to eq(path)
          sign_out
        end
      end
    end
    describe "sign in with invalid credentials" do
      before do
        visit new_user_session_path
        fill_in "user_email", with: user.email
        fill_in "user_password", with: 'wrong password'
        click_button 'Sign In'
      end
      it "does not redirect" do
        expect(current_path).to eq(new_user_session_path)
      end
      it { should have_content 'Invalid email or password'}
    end
  end

  context 'when signed in' do
    before do
      sign_in(user)
      visit new_user_session_path
    end
    it_behaves_like 'an already authorised page'
  end

end