task :default => [:clean, :dbmigrate, :run]

desc 'clean log and data files.'
task :clean do
  ['log/database.log','db/development.sqlite3'].each{|x|
     File.delete(x) if File.exists?(x);        
  }              
end

desc 'prepare db and create table.'
task :dbmigrate do
	sh "echo '' > log/database.log"
	sh "sqlite3 db/development.sqlite3 'drop table if exists image_infos'"
  sh "sqlite3 db/development.sqlite3 'create table image_infos(id integer primary key autoincrement,path varchar(255),url varchar(255),title varchar(255),order_i integer,order_s varchar(10),face_image integer)' "
	sh "sqlite3 db/development.sqlite3 'CREATE UNIQUE INDEX IF NOT EXISTS ImageUrlUniqueIndex ON image_infos(url)'"
end

desc 'start to parse data and save to sqlite.db'
task :run do
  sh "ruby parse.rb"      
end
