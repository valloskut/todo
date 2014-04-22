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
      {method: :get, path: '/api/v1/to_dos', params: {}},
      {method: :get, path: "/api/v1/to_dos/#{todo.id}", params: {}},
      {method: :post, path: '/api/v1/to_dos', params: {to_do: {title: 'Just created'}}},
      {method: :put, path: "/api/v1/to_dos/#{todo.id}", params: {to_do: {title: 'Just updated'}}},
      {method: :delete, path: "/api/v1/to_dos/#{todo.id}", params: {}}
  ] }
  let(:action_params) { [
      {params: {}, status: [401]},
      {params: invalid_email_params, status: [401]},
      {params: invalid_token_params, status: [401]},
      {params: valid_params(user), status: [200, 201, 204]}
  ] }
  context 'check response status' do
    it 'returns appropriate status for authorized and unauthorized requests' do
      actions.each do |action|
        action_params.each do |action_param|
          send(action[:method], action[:path], action[:params].merge(action_param[:params]))
          expect(response.status).to satisfy { |status| action_param[:status].include?(status)}
        end
      end
    end
  end
  describe '#index' do
    it 'returns todos owned by currently authenticated user only' do
      3.times { user.to_dos << create(:to_do) }
      user2 = create :user
      3.times { user2.to_dos << create(:to_do) }
      get '/api/v1/to_dos', valid_params(user)
      expect(json.size).to eq(3)
      expect(json.map { |todo| todo['title'] }.uniq).to eq(user.to_dos.map(&:title))
    end
  end
  describe '#show' do
    it 'returns a todo owned by currently authenticated user only' do
      get "/api/v1/to_dos/#{todo.id}", valid_params(user)
      expect(user.to_do_ids).to include(json['id'])
    end
    it 'returns an error if record not found' do
      user2 = create :user
      todo2 = create :to_do, user_id: user2.id
      get "/api/v1/to_dos/#{todo2.id}", valid_params(user)
      expect(json).to include('error')
      expect(response.status).to eq(404)
      get "/api/v1/to_dos/#{todo.id}", valid_params(user2)
      expect(json).to include('error')
      expect(response.status).to eq(404)
    end
  end
  describe '#create' do
    it 'creates a todo with valid todo params' do
      todo
      count = user.to_dos.count
      post('/api/v1/to_dos', valid_params(user).merge(to_do: {title: 'Just created'}))
      expect(user.to_dos.count).to eq(count + 1)
    end
    it 'raises an error with invalid todo params' do
      post '/api/v1/to_dos', valid_params(user).merge(to_do: {title: nil})
      expect(json).to include('error')
      expect(response.status).to eq(422)
    end
  end
  describe '#update' do
    it 'updates a todo with valid todo params' do
      title = todo.title
      put "/api/v1/to_dos/#{todo.id}", valid_params(user).merge(to_do: {title: 'Just updated'})
      expect(todo.reload.title).not_to eq(title)
      expect(response.status).to eq(200)
    end
    it 'raises an error with invalid todo params' do
      put "/api/v1/to_dos/#{todo.id}", valid_params(user).merge(to_do: {title: nil})
      expect(json).to include('error')
      expect(response.status).to eq(422)
    end
    it 'raises an error if record not found' do
      todo2 = create :to_do
      put "/api/v1/to_dos/#{todo2.id}", valid_params(user).merge(to_do: {title: 'Just updated'})
      expect(json).to include('error')
      expect(response.status).to eq(404)
    end
  end
  describe '#destroy' do
    it 'deletes a todo' do
      todo #
      count = user.to_dos.count
      delete "/api/v1/to_dos/#{todo.id}", valid_params(user)
      expect(user.to_dos.count).to eq(count - 1)
      expect(response.status).to eq(204)
    end
    it 'raises an error if record not found' do
      todo2 = create :to_do
      delete "/api/v1/to_dos/#{todo2.id}", valid_params(user)
      expect(json).to include('error')
      expect(response.status).to eq(404)
    end

  end
end