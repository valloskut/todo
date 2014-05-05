require 'spec_helper'


describe 'Sign Up Page' do

  subject { page }
  context 'when not signed in' do
    before { visit new_user_registration_path }
    it { should have_content 'Email' }
    it { should have_field 'user[email]' }
    it { should have_content 'Password' }
    it { should have_field 'user[password]' }
    it { should have_content 'Password confirmation' }
    it { should have_unchecked_field 'user[password_confirmation]' }
    it { should have_button 'Sign Up', new_user_registration_path }
    it { should have_link 'Sign In', href: new_user_session_path }

    describe "sign up with valid credentials" do
      before { sign_up 'user@email.com', 'password', 'password' }
      it "redirects to home page" do
        expect(current_path).to eq(root_path)
      end
      it { should have_content 'Welcome! You have signed up successfully' }
    end

    describe "does not sign up with invalid credentials" do
      context "email has already been taken" do
        before do
          sign_up 'user@email.com', 'password', 'password'
          sign_out
          sign_up 'user@email.com', 'password', 'password'
        end
        it_behaves_like 'an invalid user registration form'
        it { should have_content 'has already been taken' }
      end
      context "email is invalid" do
        before { sign_up 'invalid email', 'password', 'password' }
        it_behaves_like 'an invalid user registration form'
        it { should have_content 'is invalid' }
      end
      context "password is missing" do
        before { sign_up 'invalid email', '', 'password' }
        it_behaves_like 'an invalid user registration form'
        it { should have_content "can't be blank" }
      end
      context "password confirmation doesn't match" do
        before { sign_up 'invalid email', '', 'password' }
        it_behaves_like 'an invalid user registration form'
        it { should have_content "doesn't match Password" }
      end
      context "password is too short" do
        before { sign_up 'invalid email', 'pass', 'pass' }
        it_behaves_like 'an invalid user registration form'
        it { should have_content "is too short" }
      end
      context "password is too long" do
        before { sign_up 'invalid email', 'pas'*128, 'pass' }
        it_behaves_like 'an invalid user registration form'
        it { should have_content "is too long" }
      end
    end
  end

  context 'when signed in' do
    let(:user) { create :user }
    before do
      sign_in(user)
      visit new_user_registration_path
    end
    it_behaves_like 'an already authorised page'
  end

end