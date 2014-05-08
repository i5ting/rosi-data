task :default => [:clean,:dbmigrate,:run]

desc 'clean'
task :clean do
  ['log/database.log','db/development.sqlite3'].each{|x|
     File.delete(x);        
  }              
end

desc 'test migrate'
task :dbmigrate do
	sh "sqlite3 db/development.sqlite3 'drop table if exists image_infos'"
  sh "sqlite3 db/development.sqlite3 'create table image_infos(id integer primary key autoincrement,path varchar(255),url varchar(255),title varchar(255),order_i integer,order_s varchar(10),face_image integer)' "
	sh "sqlite3 db/development.sqlite3 'CREATE UNIQUE INDEX IF NOT EXISTS ImageUrlUniqueIndex ON image_infos(url)'"
end

desc 'setup devise example migrating db and creating a default user'
task :run do
  sh "ruby parse.rb"      
end
