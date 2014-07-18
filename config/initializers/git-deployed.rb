include Grit

repo = Repo.new(Rails.root)
head = repo.commits.first

unless head.nil?
	Beeronrails::Application.config.gitid = head.id
else 
	Beeronrails::Application.config.gitid = "travis"
end