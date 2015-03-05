fakeimage
=========

A small Sinatra app influenced by http://dummyimage.com, but written in Ruby.

Try it online at [http://fakeimage.heroku.com](http://fakeimage.heroku.com)

Installation
============

requires ruby 1.8.7 (MRI/REE) or 1.9.2 (YARV)

    sudo gem install sinatra rmagick
    ruby fakeimage.rb (or your rack-app-handler of choice)

*Note:* If deploying your own copy to Heroku, use their [Bamboo stack](http://docs.heroku.com/bamboo). I've not had success with Ruby 1.9.1, but REE 1.8.7 is fine.

Use
===

In a browser, hit `http://localhost:4567/300x200` for example, or change bg and text colors by passing them as GET params:

`http://localhost:4567/95x150?color=red&textcolor=orange`

Leave off the second dimension for a square.

`http://localhost:4567/200`

Multiple image formats are supported. Just add an extension to the size (e.g. `http://localhost:4567/300x200.gif`) to get that format. png (default), gif, and jpg are supported currently.

See [the ImageMagick documentation](http://www.imagemagick.org/script/color.php#color_names) for the canonical list of colors. Hex colors are also supported, but with the # replaced with a !, like `http://localhost:4567/400x300?color=!849593` In the future, hex colors may be the sole representation of colors.

Copyright
=========

Copyright (c) 2010-2015 Michael Dungan, mpd@jesters-court.net, released under the MIT license

The included Droid Sans font is licensed under the Apache License, online at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).
