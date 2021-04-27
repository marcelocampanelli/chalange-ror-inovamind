class Crawler
  def initialize(_params = {})
    make
    { status: 'true' }
  end

  def create_quote(params)
    Quote.create(params)
  end

  private

  def conection
    require 'nokogiri'
    require 'net/http'

    request = Net::HTTP.new('quotes.toscrape.com', 443)
    request.use_ssl = true
    response = request.get('/')
    Nokogiri::HTML(response.body)
  end

  def make
    doc = conection

    doc.search('.col-md-8 .quote').each do |item|
      quote = item.search('.text').first
      author = item.search('.author').first
      author_about = item.search('span a').first.values
      group_tag = item.search('.tags').first
      tags = group_tag.content.gsub(/\s+/, ' ').strip.split(' ')
      tags.delete_at(0)

      quote = {
        quote: quote.content,
        author: author.content,
        author_about: author_about.first,
        tags: tags
      }

      create_quote(quote)
    end
  end
end
