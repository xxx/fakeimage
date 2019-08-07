# fakeimage

A small Sinatra app influenced by http://dummyimage.com, but written in Ruby.

Try it online at [http://fakeimage.herokuapp.com](http://fakeimage.herokuapp.com)

## Installation

Requires ruby 2.4.1+. May work with older versions, but not tested or supported.
```bash
gem install bundler
bundle
ruby fakeimage.rb (or your rack-app-handler of choice)
```

A `Dockerfile` and `docker-compose.yml` are included in the distribution if preferred. Getting up and running
locally should require nothing more than `docker-compose up` in that case.

## Use

In a browser, hit `http://localhost:4567/300x200` for example, or change bg and text colors by passing them as GET params:

`http://localhost:4567/95x150?color=red&textcolor=orange`

Leave off the second dimension for a square.

`http://localhost:4567/200`

Multiple image formats are supported. Just add an extension to the size (e.g. `http://localhost:4567/300x200.gif`) to get that format. png (default), gif, and jpg are supported currently.

See [the ImageMagick documentation](http://www.imagemagick.org/script/color.php#color_names) for the canonical list of colors. Hex colors are also supported, but with the # replaced with a !, like `http://localhost:4567/400x300?color=!849593`.

## Copyright

Copyright (c) Michael Dungan <mpd@jesters-court.net>, released under the MIT license.

The included Droid Sans font is licensed under the Apache License, online at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).
