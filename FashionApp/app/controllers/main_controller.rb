class MainController < ApplicationController

	require 'uri'
	require 'base64'
	require 'net/http'
	require 'net/https'

	@@description = nil
	@@img = nil

	def index
	end

	def init
		@@description = params[:anything][:description]
		@@img = params[:anything][:pose]
		@name = "download1.png"
		File.open(Rails.root.join('app', 'assets', 'images', @name), 'wb') do |file|
		    file.write(@@img.read)
		end
		# name_file = "download1.txt"
		# File.open(Rails.root.join('app', 'assets', 'description', name_file), 'wb') do |file|
		#     file.write(@@description)
		# end
		# system "./script.sh '40.125.69.98' '#{@@description}'"
		@@description.gsub(" ", "+")
		uri = "http://localhost:8080/process?desc=#{@@description}"
		url = URI.encode(uri)
		url = URI.parse(url)
		req = Net::HTTP::Post.new(url.to_s)
		file = open("app/assets/images/download1.png")
		req.body = file.read
		req["Content-Type"] = "image/png"
		res = Net::HTTP.start(url.host, url.port) {|http|
			response = http.request(req)
			File.open(Rails.root.join('app', 'assets', 'images', 'output', 'output.png'), 'wb') do |file|
			    file.write(Base64.decode64(response.body))
			end
		}
		
	end

end
