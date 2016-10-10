require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "creates a valid user" do
      user = User.create(username: 'bob', password: 'bob123')
      expect(user).to be_valid
    end

    it 'redirects to show page with valid input' do
      post :create, user: {username: 'bob', password: 'bob123'}
      expect(response).to redirect_to(user_url(User.last))
    end

    it "does not create an invalid user" do
      user = User.create(username: 'bob', password: 'bo23')
      expect(user).to_not be_valid
    end

    it "renders new with invalid users" do
      post :create, user: {username: ''}
      expect(response).to render_template(:new)
    end
  end

end
