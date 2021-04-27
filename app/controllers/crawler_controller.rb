class CrawlerController < ApplicationController
  def index
    result = Crawler.new

    render json: {
      status: result
    }
  end
end
