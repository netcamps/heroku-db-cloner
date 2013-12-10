
namespace :clone do

  task :cache_flush  do
    Bundler.with_clean_env { p `heroku --version` }
  end
  
  task :prep_dev_db => :environment do
    puts "dropping devevelopment database..."
    Rake::Task['db:drop'].invoke
    puts "creating new development database..."
    Rake::Task['db:create'].invoke
  end
  
  task :clone_heroku => :environment do
    puts "cloning Heroku db..."
    Bundler.with_clean_env { sh "heroku pgbackups:capture" }
  end
  
  task :download_clone do
    puts "dumping Heroku db..."
    Bundler.with_clean_env { sh "curl -o latest.dump `heroku pgbackups:url`" }
  end
  
  # TODO there's an error here...
  task :import_clone do
    Bundler.with_clean_env { sh "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U chris -d #{Rails.configuration.database_configuration["development"]["database"]} latest.dump" }
  end
  
  task :remove_dump do
    Bundler.with_clean_env { sh "rm latest.dump" }
  end
  
  task :herokudb => [:prep_dev_db, :clone_heroku, :download_clone, :import_clone, :remove_dump] 
end