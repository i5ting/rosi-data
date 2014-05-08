require 'curb'
require 'nokogiri'
require 'fileutils'

def myretry (tries = 3)
  begin
    yield
  rescue
    tries -= 1
    retry if tries > 0
    puts "can't operate : #{$!}"
  end
end

def download_pics_albumID(albumID)
  # make the directory to store the image files
  dir = 'rosi-pics/ROSI-' + albumID.to_s
  FileUtils.mkdir_p dir

  url = 'http://rosi.mn/x/album-' + albumID.to_s + '.htm'
  http = ""
  myretry { http = Curl.get(url) }
  doc = Nokogiri::HTML(http.body)

  coverimg = doc.css("div#album-face img")
  coverurl = coverimg[0]['src']
  coverfilepath = dir + "/ROSI-#{albumID.to_s}-" + "000.jpg"
  puts "\nDownloading " + coverurl
  puts 'Store in ' + coverfilepath
  myretry do
    Curl::Easy.download( coverurl, coverfilepath ) do |curl|
      curl.headers["Referer"] = url
    end
  end

  i = 1
  anchors = doc.css("div.album-thumbs-free a")
  anchors.each do |anchor|
    imgurl = anchor['href']
    ext = imgurl.split(/\./).last
    filepath = dir + "/ROSI-#{albumID.to_s}-" + i.to_s.rjust(3,"0") + ".#{ext}"

    puts "\nDownloading " + imgurl
    puts 'Store in ' + filepath
    myretry do
      Curl::Easy.download( imgurl, filepath ) do |curl|
        curl.headers["Referer"] = url
      end
    end

    sleep 0.1
    i += 1
  end
end

# main loop
for num in 1..882
    download_pics_albumID num
end