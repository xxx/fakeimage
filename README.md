fakeimage
=========

A small Sinatra app influenced by http://dummyimage.com, but written in Ruby.

Try it online at [http://fakeimage-icti.heroku.com](http://fakeimage-icti.heroku.com)

Installation
============

requires ruby 1.8.7 (MRI/REE) or 1.9.2 (YARV) and Bundler

    sudo gem install bundler
		bundle install
		foreman start

This can be deployed directly to Heroku cedar stack

Use
===

In a browser, hit `http://localhost:5000/300x200` for example, or change bg and text colors by passing them as GET params:

`http://localhost:5000/95x150?color=red&textcolor=orange`

Leave off the second dimension for a square.

`http://localhost:5000/200`

Multiple image formats are supported. Just add an extension to the size (e.g. `http://localhost:5000/300x200.gif`) to get that format. png (default), gif, and jpg are supported currently.

See [the ImageMagick documentation](http://www.imagemagick.org/script/color.php#color_names) for the canonical list of colors. Hex colors are also supported, but with the # replaced with a !, like `http://localhost:5000/400x300?color=!849593` In the future, hex colors may be the sole representation of colors.

Copyright
=========

Copyright (c) 2010-2011 Michael Dungan, mpd@jesters-court.net, released under the MIT license

Copyright (c) 2013 Jose Antonio Guerra, jaguerra@icti.es, released under the MIT license


The included Droid Sans font is licensed under the Apache License, online at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).
