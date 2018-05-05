class MainController < ApplicationController

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
		name_file = "download1.txt"
		File.open(Rails.root.join('app', 'assets', 'description', name_file), 'wb') do |file|
		    file.write(@@description)
		end
		system "./script.sh '40.125.69.98' '#{@@description}'"
	end

end
