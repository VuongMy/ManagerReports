require 'spec_helper'

describe "UserPages" do

  subject {page}
  describe "Sign up page" do
    before {visit signup_path}
    it {should have_title('Sign up page')}
    it {should have_content('Sign up')}
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Submit" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do        
        fill_in "Email",        with: "user@example.com"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end