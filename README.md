fakeimage
=========

A small Sinatra app influenced by http://dummyimage.com, but written in Ruby.

Installation
============

    sudo gem install sinatra rmagick
    ruby fakeimage.rb

Use
===

In a browser, hit `http://localhost:4567/300x200` for example, or change bg and text colors by passing them as GET params:

`http://localhost:4567/95x150?color=red&textcolor=orange`


Copyright
=========

Copyright (c) 2010 Michael Dungan, mpd@jesters-court.net, released under the MIT license
