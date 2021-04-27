class QuotesController < ApplicationController
  def search
    search = Quote.where({ tags: params[:search] })
    search = get_serializer(search)

    render json: {
      quotes: search
    }
  end
end
