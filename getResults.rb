# getResults.rb
require 'sinatra'
require 'open-uri'
require 'nokogiri'

# root index page
get '/:drawNo' do
	draw_number = params[:drawNo]
	toto_results_url = "http://www.singaporepools.com.sg/Lottery?page=wc10_toto_past&drawNo="+draw_number
	toto_html = URI.parse(toto_results_url).read
  	toto_nokogiri_html_doc = Nokogiri::HTML(toto_html)

  	# search for 'td.winning_numbers_toto_b'
  	results_nodeset = toto_nokogiri_html_doc.css('td.winning_numbers_toto_b')
  	results_array = results_nodeset.children.to_a

  	results_string = ''
  	results_array.each_with_index do |e, i|
  		# extract digits only
  		e_number = e.text.gsub(/\D/, '')

  		i != results_array.length - 1 ? results_string += e_number + ' ' : results_string += e_number
  	end

  	p results_string
end