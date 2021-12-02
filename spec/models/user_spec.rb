RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  describe "schema" do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:password_digest).of_type(:string) }
  end

  describe "create" do
    it { expect { user.save }.to change(User, :count).by(1) }
  end

  describe "validations" do
    it { expect(user).to allow_value(Faker::Internet.email).for(:email) }
    it { should validate_presence_of(:email) }
    it "should not take invalid emails" do
      expect(user).to_not allow_value("something").for(:email)
      expect(user.errors.full_messages.to_sentence).to eq("Email is invalid")
      expect(user.errors.count).to eq(1)
    end
  end

  describe "associations" do
    it { should have_many(:movies) }
  end
end
