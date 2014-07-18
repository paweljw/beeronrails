Sitemap::Generator.instance.load :host => "brew.steamshard.net" do
  path :root, :priority => 1
  resources :beers, :priority => 0.9, :change_frequency => "weekly"
  resources :breweries, :priority => 0.8, :change_frquency => "weekly"
end
