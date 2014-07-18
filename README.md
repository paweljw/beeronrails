Beer on Rails
=============

Motivation
-------

I collect beer bottle stickers, and I have a lot (>500) of them. This is an online application which helps me keep track of what I do and don't have, written in Rails 3. It stores the name, photo, country, brewery - and a lot of different information - for each beer. It also provides sorting and filtering functions which help me when incorporating new items into my collection.

Deployment
---

A live example can be seen at http://brew.steamshard.net - this is the database for my actual collection, now completely migrated into Beer on Rails. Make note that the online version is the latest master, and will usually lack features from the current development branch.

Development
-----
Beer on Rails is under ongoing development - right now it's facing a port to Rails 4.

The project has also spawned a library, [ean-country](https://github.com/paweljw/ean-country), which translates the country prefixes in EAN-13 barcodes to ISO 3166 country codes. It's also available as a gem under `gem install ean-country`.