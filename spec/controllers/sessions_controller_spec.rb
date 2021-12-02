RSpec.describe SessionsController, type: :controller do
  describe "#create" do
    before { allow(UpdateYoutubeMetadata).to receive(:perform_now) }

    context "user with new email and password" do
      it "should create new user and log in" do
        params = { email: "test@example.com", password: "1234" }
        expect { post :create, params: params }.to change(User, :count).by(1)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to match("Login sucess")

        expect(UpdateYoutubeMetadata).to have_received(:perform_now).once
      end
    end

    context "user with email and wrong password" do
      let!(:user) { create(:user, password: "1234") }

      it "should not let user log in" do
        params = { email: user.email, password: "123456" }
        expect { post :create, params: params }.to change(User, :count).by(0)
        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:danger]).to match("wrong email or password")

        expect(UpdateYoutubeMetadata).not_to have_received(:perform_now)
      end
    end
  end

  describe "#logout" do
    context "user log out" do
      let(:user) { create(:user) }

      before { login(user) }

      it "should let user logged out" do
        delete :logout

        expect(response.status).to eq(302)
        expect(response).to redirect_to(root_path)
        expect(flash[:success]).to match("Log out sucess")
      end
    end
  end
end
