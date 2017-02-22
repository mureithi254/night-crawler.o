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

  def docs(file_name)
    @docs = File.readlines(file_name)
  end
  
  def comparative
    lsi = ClassifierReborn::LSI.new
    lsi.add_item @data

    @docs.each do |line|
      lsi.classify line
      puts lsi.find_related(line)
    end 
  end

end

google = Anemon.new('http://www.habahaba.co/')
google.crawler
google.scrapper
google.docs("makefile.txt")
google.comparative