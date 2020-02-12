require 'nokogiri'
require 'open-uri'

class Scraper 
    
    def get_article 
        doc = Nokogiri::HTML(open('https://thecitylane.com/the-best-65-dumplings-around-the-world/'))
        article = doc.css(".vw-post-content")
        article
    end

    def get_pair
        pair_array = []
        self.get_article.css("h4").each do |p|
            pair_array << p.to_s[4...-6]
        end
        pair_array.map do |p|
            p.split(" \u2013 ")
        end
    end

    def create_country
        self.get_pair.each do |p|
            country_name = p[1]
            Country.find_or_create_by_name(country_name)
        end
    end
        

    def create_dumpling
        self.get_pair.each do |p|
            dumpling_name = p[0]
            dumpling = Dumpling.find_or_create_by_name(dumpling_name)           #make module
            Country.create_country
            

#set country - should come first anyway but just in case

    def self.find_or_create_by_name(name)
        if self.all.detect {|d| d.name == name} == nil
            dumpling = Dumpling.new(name)
            dumpling
        else
            Dumpling.all.detect {|d| d.name == name}
        end
    end

    def get_blurb

    end
end



