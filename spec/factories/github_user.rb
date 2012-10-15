FactoryGirl.define do
  factory :github_user, class: Github::Org do
    avatar_url "https://secure.gravatar.com/avatar/ec913744ec6c908c66e2cb141dadcd77?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png"
    login "gitomic-test-organization"

    initialize_with { new(Hashie::Mash.new(attributes)) }
  end
end