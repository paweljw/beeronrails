namespace :pjw do
  desc "RDoc"
  RDoc::Task.new :rdoc do |rdoc|
  	rdoc.main = "README.rdoc"

  	rdoc.rdoc_files.include("README.rdoc", "doc/*.rdoc", "app/**/*.rb", "lib/*.rb", "config/**/*.rb")

  	rdoc.title = "App Documentation"
  	rdoc.options << "--all" 
	end
  end
