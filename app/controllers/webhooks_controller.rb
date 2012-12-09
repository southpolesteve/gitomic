class WebhooksController < ApplicationController

  def github
    processs_github_payload
  end

end