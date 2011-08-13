module ApplicationHelper

	def title
		base_title = "Connect Four on Rails"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	def logo
		image_tag("connectfour.png", :alt => "Connect Four", :class => "round")
	end
end
