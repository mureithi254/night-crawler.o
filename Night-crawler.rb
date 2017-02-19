class Anemon
   require 'anemone'
   require 'nokogiri'
   require 'open-uri'
   require 'classifier-reborn'


   def initialize(url)
     @url = url 
   end

   def crawler
     Anemone.crawl(@url) do |anemone|
       anemone.on_every_page do |page|
         @urls = []
           @urls.push(page.url)
       end 
    end
  end

  def scrapper
     @urls.each do| urli|
        html_data = open(urli).read
        nokogiri_object = Nokogiri::HTML(html_data)
        elements = nokogiri_object.xpath("//a")

        elements.each do |element|
          @data = element.text
        end
    end
  end

  def docs
    
  end
  
  def comparative
    
  end

end

google = Anemon.new('https://en.wikipedia.org/wiki/List_of_Nobel_laureates')
google.crawl
google.nokog