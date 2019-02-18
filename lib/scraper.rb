require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    doc = Nokogiri::HTML(html)
    
    student_hash_array = []
    doc.css("div.roster-cards-container").each do |student_card|
     student_card.css(".student-card a").each do |student|
       url = student.attr("href")
       name = student.css("h4.student-name").text
       location = student.css("p.student-location").text
       student_hash = {:name => name, :location => location, :profile_url => url}
       student_hash_array << student_hash
     end  
   end
  student_hash_array
  end


  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
  
    twitter_url = nil 
    linkedin_url = nil
    github_url = nil
    blog_url = nil
    doc.css("div.social-icon-container a").each do |url|
      url = url.attr("href")
      if url.include?("twitter")
        twitter_url = url
      elsif url.include?("linkedin")
        linkedin_url = url
      elsif url.include?("github")
        github_url = url
      else blog_url = url
      end  
    end
    profile_quote = doc.css("div.profile-quote").text
    bio = doc.css("div.description-holder p").text
    student_info = {:twitter => twitter_url, :linkedin => linkedin_url, :github => github_url, :blog => blog_url, :profile_quote => profile_quote, :bio => bio}
    student_info
  end   
    
    
    
    
  

end

