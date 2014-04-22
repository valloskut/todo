require 'spec_helper'

def valid_params(user)
  {user_email: user.email, user_token: user.authentication_token}
end

describe "ToDos API", type: :api do
  let(:user) { create :user }
  let(:todo) { create :to_do, user_id: user.id }
  let(:invalid_email_params) { {user_email: 'invalid_email', user_token: user.authentication_token} }
  let(:invalid_token_params) { {user_email: user.email, user_token: 'invalid_token'} }
  let(:actions) { [
      {method: :get, path: 'api/v1/to_dos'},
      {method: :get, path: "api/v1/to_dos/#{todo.id}"}
  ] }
  let(:action_params) { [
      {params: {}, status: 401},
      {params: invalid_email_params, status: 401},
      {params: invalid_token_params, status: 401},
      {params: valid_params(user), status: 200},
  ] }
  context 'check response status' do
    it 'returns appropriate status for authorized and unauthorized requests' do
      actions.each do |action|
        action_params.each do |action_param|
          send(action[:method], action[:path], action_param[:params])
          expect(response.status).to eq(action_param[:status])
        end
      end
    end
  end
  describe '#index' do
    it 'returns todos owned by currently authenticated user only' do
      3.times { user.to_dos << create(:to_do) }
      user2 = create :user
      3.times { user2.to_dos << create(:to_do) }
      get 'api/v1/to_dos', valid_params(user)
      expect(json.size).to eq(3)
      expect(json.map { |x| x['user_id'] }.uniq).to eq([user.id])
    end
  end
  describe '#show' do
    it 'returns a todo owned by currently authenticated user only' do
      get "api/v1/to_dos/#{todo.id}", valid_params(user)
      expect(json).to include('user_id' => user.id)
    end
    it 'returns an error if record not found' do
      user2 = create :user
      get "api/v1/to_dos/#{todo.id}", valid_params(user2)
      expect(json).to include('error')
    end
  end
end