require 'spec_helper'

describe "DailyReports" do
	subject {page}

  describe "Home" do
    before {visit root_path}
    it {should have_title('Home page')}
    it {should have_content('')}
    end

  describe "Help" do
  	before {visit help_path}
  	it {should have_title('Help page')}
  	it {should have_content('Help')}
  end

  describe "About" do
  	before {visit about_path}
  	it {should have_title('About Us')}
  	it {should have_content('About')}
  end

  describe "Contact" do
  	before {visit contact_path}
  	it {should have_title('Contact Us')}
  	it {should have_content('Contact')}
  end
end
