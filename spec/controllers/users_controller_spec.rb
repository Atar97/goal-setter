require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) { FactoryBot.create(:user) }
  describe "GET" do

    context "#index" do
      it "renders the index page" do
        get :index

        expect(response).to be(success)
        expect(response).to render_template(:index)
      end
    end

    context "#show" do
      it "renders the proper show page" do
        get :show, params: {id: user.id}
        expect(response).to be(success)
        expect(response).to render_template(:show)
      end

      it 'redirects to new users page if id is bad' do
        get :show, params: { id: -1 }
        expect(response).to redirects_to(new_user_url)
      end
    end

    context "#new" do
      it 'renders new user page' do
        get :new

        expect(response).to be(success)
        expect(response).to render_template(:new)
      end
    end


    context "#edit" do
      it 'renders the edit page' do
        get :edit, params: {id: user.id}
        expect(reponse).to be(sucess)
        expect(response).to render_template(:edit)
      end

      it 'redirects to new users page if id is bad' do
        get :show, params: { id: -1 }
        expect(response).to redirects_to(new_user_url)
      end
    end
  end

  describe "POST#create" do
    it 'renders the user page if created' do
      post :create, params: { username: 'username', password: 'password' }
      user = User.find_by(username: 'username')
      expect(reponse).to be(sucess)
      expect(response).to redirects_to(user_url(user))
    end

    it 'rerenders the new page if params are bad' do
      post :create
      expect(response).to render(:new)
      expect(flash.now[:errors]).to_not be_nil
    end
  end

  describe "PATCH#update" do

    it 'renders the user page if updated' do
      user_hash = user.attributes
      user_hash['username'] = 'Method Man'
      patch :update, params: user_hash

      expect(User.find(user_hash['id']).username).to eq('Method Man')
      expect(response).to redirects_to(user_url(user))
    end

    it 'renders the edit page if params are bad' do
      patch :update, params: {id: user.id}
      expect(response).to render(:edit)
      expect(flash.now[:errors]).to_not be_nil
    end
  end

  describe "DELETE#destroy" do
    it "destroys the right user" do
      delete :destroy, params: {id: user.id}

      expect(response).to be(success)
      expect { User.find(user.id) }.to raise_error
    end 
  end

end
