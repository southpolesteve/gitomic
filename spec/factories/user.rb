FactoryGirl.define do
  factory :test_user, class: User do
    name "Gitomic Test User"
    email "steve+github@gitomic.com"
    provider "github" 
    uid "2382633"
    avatar "https://secure.gravatar.com/avatar/ec913744ec6c908c66e2cb141dadcd77?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    github_token "4014890907c8ef103452e391f670ef395a3d47e6"
    github_login "gitomic-test"
  end

  factory :test_user_2, class: User do
    name "Gitomic Test User 2"
    email "steve+github2@gitomic.com"
    provider "github" 
    uid "2560085"
    avatar "https://secure.gravatar.com/avatar/502c2111703936c85cde22963474e49a?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    github_token "a22c6d47c3dd2709f4b4d1861011a01bbf05b291"
    github_login "gitomic-test-2"
  end
end