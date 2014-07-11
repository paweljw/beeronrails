namespace :pjw do
  desc "Preparing database"
  task :prepare_database => :environment do
  	Rake::Task["db:create"].execute
	Rake::Task["db:schema:load"].execute
	Rake::Task["db:load"].execute
  end

end
