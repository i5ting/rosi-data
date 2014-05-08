#! /usr/bin/env ruby
# 
# 
# 
# 

require 'sqlite3'
require 'base64'  
require 'active_record'      
require 'logger'
    
# custom config
# user_input_file_name = 'example.txt'
user_input_file_name = 'nohup.origin.data'
user_output_file_name = 'db/development.sqlite3'

user_encode_seed = 'alfred'

# global var
line_num				=	0
image_url 			= ''

# use ar connect to sqlite3
ActiveRecord::Base.establish_connection(
	:adapter 			=> "sqlite3" ,
	:database 		=> user_output_file_name
)

ActiveRecord::Base.logger = Logger.new(File.open('log/database.log', 'a'))    
    
class ImageInfo < ActiveRecord::Base  
	
end    
    
puts ImageInfo.all.count

# ImageInfo.destroy_all

File.open(user_input_file_name).each do |line|

	if ( line =~ /^Downloading/ )
		image_url = line.sub!(/Downloading\s/, "").gsub(/\s+/, "") 
	elsif( line =~ /^Store\ in\ rosi-pics/ )
		
		path = line.sub!(/Store\ in\ rosi-pics\//, "").gsub(/\s+/, "") 
		a = path.split('/')
		# ROSI-1/ROSI-1-001.jpg
		# A[0] = ROSI-1
		# A[1] = ROSI-1-001.jpg
		title 			= a[0]
		image_name 	= a[1].gsub(/#{a[0]}-/, "") 
		
		f1 = /(\d+)\.jpg/.match(image_name)
		
		# 1
		order_s = image_name.gsub(/\.jpg/, "").to_s
		order_i = image_name.gsub(/\.jpg/, "").to_i
		
		face_image = 0
		
		if ( image_url =~ /\$\.face\.jpg$/ )
			face_image = 1
		end
		
		puts "..Image image_name :#{path} #{image_url} #{title} #{order_s} #{order_i}"
		
		encode_url = Base64.encode64 "#{image_url}_#{user_encode_seed}"
		# sqlite3 db/development.sqlite3 'create table image_infos(id integer primary key autoincrement,path varchar(255),url varchar(255),title varchar(255),order_i integer,order_s varchar(10))
		# save
		ImageInfo.create(:path => path,:url => encode_url,:title => title,:order_i => order_i,:order_s => order_s,:face_image => face_image)
		
		image_url = ''
	end
end
    
puts ImageInfo.all.count
