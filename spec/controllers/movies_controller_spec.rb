RSpec.describe MoviesController, type: :controller do
  let(:user) { create(:user) }

  describe "#create" do
    let(:youtube_url) { "https://www.youtube.com/watch?v=test" }

    context "with logged-in user" do
      before do
        login(user)
      end

      it "should share a youtube video" do
        params = { link: youtube_url }
        expect { post :create, params: params }.to change(Movie, :count).by(1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to match("Movie shared")
      end

      it "should not share with empty url" do
        expect { post :create }.to change(Movie, :count).by(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to match("Link is invalid")
      end

      it "should not share with invalid url" do
        params = { link: "wwww.facebook.com" }
        expect { post :create, params: params }.to change(Movie, :count).by(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to match("Link is invalid")
      end
    end

    context "with logged-out user" do
      it "should not be able to share" do
        post :create, params: { link: youtube_url }

        expect(Movie.count).to eq(0)
        expect(flash[:danger]).to match("You need to signed in to do that")
      end
    end
  end

  describe "#share" do
    context "with logged-in user" do
      before do
        login(user)
      end

      it "should render success" do
        get :share

        expect(response.status).to eq(200)
      end
    end

    context "with logged-out user" do
      it "should not be able to go to share screen" do
        get :share

        expect(flash[:danger]).to match("You need to signed in to do that")
      end
    end
  end

  describe "#index" do
    context "with logged-in user" do
      before do
        login(user)
      end

      it "should render success" do
        get :index

        expect(response.status).to eq(200)
      end
    end

    context "with logged-out user" do
      it "should render success" do
        get :index

        expect(response.status).to eq(200)
      end
    end
  end
end
