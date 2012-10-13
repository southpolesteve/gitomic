require 'spec_helper'

describe "the home page" do

  it "exists" do
    visit root_path
    page.should have_content("Gitomic")
  end
end