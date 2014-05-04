shared_examples 'an unauthorised page' do
  it { should have_link 'Sign In', href: new_user_session_path }
  it { should have_link 'Sign Up', href: new_user_registration_path }
end

shared_examples 'an authorised page' do
  it { should have_link 'Sign Out', href: destroy_user_session_path }
  it { should have_link 'API Information', href: api_path }
  it { should_not have_link 'Sign In', href: new_user_session_path }
  it { should_not have_link 'Sign Up', href: new_user_registration_path }
end

