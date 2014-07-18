include Grit

repo = Repo.new(Rails.root)
head = repo.commits.first

Beeronrails::Application.config.gitid = head.id