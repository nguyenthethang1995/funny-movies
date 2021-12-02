RSpec.describe Movie, type: :model do
  let(:movie) { build(:movie) }

  describe "schema" do
    it { should have_db_column(:user_id).of_type(:integer) }
    it { should have_db_column(:link).of_type(:string) }
    it { should have_db_column(:title).of_type(:string) }
    it { should have_db_column(:description).of_type(:text) }
  end

  describe "create" do
    it { expect { movie.save }.to change(Movie, :count).by(1) }
  end

  describe "validations" do
    it { expect(movie).to allow_value("https://youtu.be/watch?v=test").for(:link) }
    it { should validate_presence_of(:link) }

    it "should not take invalid youtube url" do
      expect(movie).to_not allow_value("https://youtud.be/wrong_yt_url").for(:link)
      expect(movie.errors.full_messages.to_sentence).to eq("Link is invalid")
      expect(movie.errors.count).to eq(1)
    end
  end

  describe "associations" do
    it { should belong_to(:user) }
  end

  describe "callbacks" do
    it { is_expected.to callback(:fetch_youtube_metadata).before(:save) }
  end
end
