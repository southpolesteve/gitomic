module IntegrationSpecHelper
  
  def login(user = nil)
    if user && user.github_login != "gitomic-test"
      raise "Tried to login with user that does not match omniauth stub"
    else
      visit "/auth/github"
    end
  end

  def wait_for_ajax
    wait_until do
      page.evaluate_script('$.active') == 0
    end
  end

end