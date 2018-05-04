class MainController < ApplicationController

	@@description = nil
	@@img = nil

	def index
	end

	def init
		@@description = params[:anything][:description]
		@@img = params[:anything][:pose]
		@name = "test.png"
		File.open(Rails.root.join('app', 'assets', 'images', @name), 'wb') do |file|
		    file.write(@@img.read)
		end
	end

	def display
	end

	def design
		system "test.lua"
	end

end
