require 'spec_helper'

describe StatusController, :type => :controller do

  it "should return the correct status" do
    response = @controller.send(:pingServer)
    response.should be_true
  end

  it "should return the correct status" do
    response = @controller.send(:pingSite)
    response.should be_true
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "@site receives true" do
      get :index
      expect(assigns(:site)).to be_true
    end

    it "@server receives true" do
      get :index
      expect(assigns(:server)).to be_true
    end
  end

end