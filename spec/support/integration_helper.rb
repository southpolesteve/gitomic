module IntegrationSpecHelper
  def login
    visit "/auth/github"
  end
end