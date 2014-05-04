require 'spec_helper'


describe 'Home Page' do

  subject { page }
  context 'when not signed in' do
    before { visit root_path }
    it_behaves_like 'an unauthorised page'
    it { should have_css 'img[src*="todo_screenshot.png"]' }
    it { should have_content 'You need to Sign In or Sign Up before continuing' }
  end


  context 'when signed in' do
    before { sign_in(create :user) }
    it_behaves_like 'an authorised page'
    it { should have_content 'Signed in successfully' }
    it { should have_content 'My Todo List' }
  end

end