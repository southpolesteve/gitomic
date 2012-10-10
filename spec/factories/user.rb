FactoryGirl.define do
  factory :test_user, class: User do
    name "Gitomic Test User"
    email "steve+github@gitomic.com"
    provider "github" 
    uid "2382633"
    avatar "https://secure.gravatar.com/avatar/ec913744ec6c908c66e2cb141dadcd77?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    github_token "035bf79dcdfebaf681b72c72e60aff551a8c6d87"
    github_login "gitomic-test"
  end
end