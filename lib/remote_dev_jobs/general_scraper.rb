class GeneralScraper



  def data
    @data ||= Nokogiri::HTML(open(URL))
  end

end