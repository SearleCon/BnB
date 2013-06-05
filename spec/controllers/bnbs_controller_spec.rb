require 'spec_helper'

describe BnbsController do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @user
    sign_in @user
  end

  describe 'Get #index' do


    it 'populates a list of bnbs' do
      bnb = FactoryGirl.create(:bnb)
      get :index
      expect(assigns(:bnbs)).to match_array [bnb]
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'Get #show' do
    let!(:bnb) { FactoryGirl.create(:bnb) }

    it 'assigns the requested bnb to @bnb' do
      get :show, id: bnb
      expect(assigns(:bnb)).to eq(bnb)
    end

    it 'renders the :show template' do
      get :show, id: bnb
      expect(response).to render_template :show
    end

    it 'redirects to the startpage if the bnb is nil' do
      get :show
      expect(response).to redirect_to(startpage_url)
    end

    describe 'mappable' do
      it 'is mappable' do
        mappable_bnb = FactoryGirl.create(:bnb, :valid_address)
        get :show, id: mappable_bnb.id
        controller.send(:convert_to_map_data, mappable_bnb)
        expect(assigns(:map_data)).to_not be_nil
      end

      it 'is not mappable' do
        non_mappable_bnb = FactoryGirl.create(:bnb, mappable: false)
        get :show, id: non_mappable_bnb
        expect(assigns(:map_data)).to be_nil
      end
    end
  end

  describe 'Get #edit' do
    let!(:bnb) { FactoryGirl.create(:bnb) }

    it 'assigns the requested bnb to @bnb' do
       get :edit, id: bnb
       expect(assigns(:bnb)).to eq bnb
    end

    it 'redirects to the bnb wizard page' do
      get :edit, id: bnb
      expect(response).to redirect_to bnb_setup_wizard_url(bnb)
    end
  end

  describe 'Post #create' do
    it 'saves a new bnb to the database' do
      expect { post :create }.to change(Bnb, :count).by(1)
    end

    it 'redirects to the bnb wizard' do
      post :create
      expect(response).to redirect_to bnb_setup_wizard_url(Bnb.first)
    end
  end


end
