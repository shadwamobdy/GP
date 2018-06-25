class MainController < ApplicationController
  
	require 'uri'
	require 'base64'
	require 'net/http'
	require 'net/https'
	
	@@IP = nil

	def index
		@@IP = params[:ip]
	end

	def init
	  	@description = params[:anything][:description]
		@description.gsub(" ", "+")
		uri = "http://#{@@IP}:8080/process?desc=#{@description}"
		url = URI.encode(uri)
		url = URI.parse(url)
		req = Net::HTTP::Get.new(url.to_s)
		# file = open("app/assets/images/download1.png")
		# req.body = file.read
		# req["Content-Type"] = "image/png"
		res = Net::HTTP.start(url.host, url.port, read_timeout: 120) {|http|
			response = http.request(req)
			File.open(Rails.root.join('app', 'assets', 'images', 'output', 'output.png'), 'wb') do |file|
			    file.write(Base64.decode64(response.body))
			end
		}
		cl_image_tag("app/assets/images/output/output.png", :width=>250, :height=>250, :gravity=>"faces", :crop=>"fill")
	end
end
