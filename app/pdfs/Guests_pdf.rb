class GuestsPdf < Prawn::Document
	def initialize(guests, choice, fontfam, fontsize)
		super(top_margin:40)
		
			@guests = guests

		
		# @even = @guests.values_at(* guests.each_index.select{|d| d.even?})
		# @odd = @guests.values_at(* guests.each_index.select{|d| d.odd?})
		@choice = choice
		@fontfam = fontfam
		@fontsize = fontsize
		#Registering font families 
		if fontfam.to_i == 1
		 font_families.update("font_standard" => {
		 	:normal => "#{Rails.root}/app/assets/fonts/AlexBrush.ttf"
		 	})
		elsif fontfam.to_i == 2
			font_families.update("font_standard" => {
		 	:normal => "#{Rails.root}/app/assets/fonts/Crushed.ttf"
		 	})
		elsif fontfam.to_i == 3
			font_families.update("font_standard" => {
		 	:normal => "#{Rails.root}/app/assets/fonts/HomemadeApple.ttf"
		 	})
		elsif fontfam.to_i == 4
			font_families.update("font_standard" => {
		 	:normal => "#{Rails.root}/app/assets/fonts/Magnolia Light.ttf"
		 	})
		else 
		 	font_families.update("font_standard" => {
		 	:normal => "#{Rails.root}/app/assets/fonts/theodista_decally-webfont.ttf"
		 	})
		end 
	
		print_names

	end

	def print_names
		length = @guests.size
		image_name = "app/assets/images/pla" + @choice + ".png"
		gap = @fontsize.to_i
		name_size =  @fontsize.to_i
		table_size = @fontsize.to_i-5

		font("font_standard")
		if length >= 4 
			1.upto(length/4.floor) do |i| 
				define_grid(:columns => 2, :rows => 4, :gutter => 2)
				grid(1,0).bounding_box do
					image image_name, :fit => [bounds.width, bounds.height], 
					:postion => :center, :vposition => :center
					float do
						bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
							text @guests[4*i-4].name.to_s, :valign => :center, :align => :center, :size => name_size
							move_down gap
							text @guests[4*i-4].table_num.to_s, :valign => :center, :align => :center, :size => table_size
						end 
					end 
				end 
				grid(1,1).bounding_box do
					image image_name, :fit => [bounds.width, bounds.height], 
					:postion => :center, :vposition => :center
					float do
						bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
							text @guests[4*i-3].name, :valign => :center, :align => :center, :size => name_size
							move_down gap
							text @guests[4*i-3].table_num.to_s, :valign => :center, :align => :center, :size => table_size
						end 
					end 
				end 
				grid(3,0).bounding_box do
					image image_name, :fit => [bounds.width, bounds.height], 
					:postion => :center, :vposition => :center
					float do
						bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
							text @guests[4*i-2].name, :valign => :center, :align => :center, :size => name_size
							move_down gap
							text @guests[4*i-2].table_num.to_s, :valign => :center, :align => :center, :size => table_size
						end 
					end 
				end 
				grid(3,1).bounding_box do
					image image_name, :fit => [bounds.width, bounds.height], 
					:postion => :center, :vposition => :center
					float do
						bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
							text @guests[4*i-1].name, :valign => :center, :align => :center, :size => name_size
							move_down gap
							text @guests[4*i-1].table_num.to_s, :valign => :center, :align => :center, :size => table_size
						end 
					end 
				end 
				if length > 4 
					start_new_page
				end 
			end 
		end 

		if length%4 != 0 
			addition = length-length%4
			addition.upto(length) do |i| 
			define_grid(:columns => 2, :rows => 4, :gutter => 2)
				if length%4 == 1
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end
				elsif length%4 == 2 
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end 
					grid(1,1).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4+1].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4+1].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end
				else 
					grid(1,0).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end 
					grid(1,1).bounding_box do
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*3], :width => 100) do 
								text @guests[length-length%4+1].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4+1].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end 
					grid(3,0).bounding_box do 
						image image_name, :fit => [bounds.width, bounds.height], 
						:postion => :center, :vposition => :center
						float do
							bounding_box([bounds.width/3-10,bounds.height*1], :width => 100) do 
								text @guests[length-length%4+2].name, :valign => :center, :align => :center, :size => name_size
								move_down gap
								text @guests[length-length%4+2].table_num.to_s, :valign => :center, :align => :center, :size => table_size
							end 
						end 
					end
				end 
			end 
		end 
	end 
end 

