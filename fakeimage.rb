# frozen_string_literal: true

require 'logger'
require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'rmagick'
require 'rvg/rvg'

FORMATS = {
  'png' => 'png',
  'gif' => 'gif',
  'jpg' => 'jpeg'
}.freeze

LOGGER = Logger.new($stdout)

get '/' do
  <<~HTML
    <p>Welcome to fakeimage.</p>
    <p>
      Please see the README (specifically the 'Use' section) at
      <a href='http://github.com/xxx/fakeimage'>http://github.com/xxx/fakeimage</a> for#{' '}
      usage info so I don't have a chance to let one of the copies get out of date.
    </p>
    <p>Example: <img src='/243x350.gif?color=darkorchid2&textcolor=!B9AF55' /></p>
    <p>
      Code:#{' '}
      <code>&lt;img src='http://fakeimage.heroku.com/243x350.gif?color=darkorchid2&textcolor=!B9AF55' /&gt;</code>
    </p>
  HTML
end

get '/:size' do
  wh, format = params[:size].downcase.split('.')
  format = FORMATS[format] || 'png'

  width, height = wh.split('x').map(&:to_i)

  height ||= width

  color = color_convert(params[:color]) || 'grey69'
  text_color = color_convert(params[:textcolor]) || 'black'

  rvg = Magick::RVG.new(width, height).viewbox(0, 0, width, height) do |canvas|
    canvas.background_fill = color
  end

  img = rvg.draw

  img.format = format

  drawable = Magick::Draw.new
  drawable.pointsize = width / 10
  drawable.font = './DroidSans.ttf'
  drawable.fill = text_color
  drawable.gravity = Magick::CenterGravity
  drawable.annotate(img, 0, 0, 0, 0, "#{width} x #{height}")

  content_type "image/#{format}"
  img.to_blob
rescue Exception => e # rubocop:disable Lint/RescueException
  LOGGER.error("#{e}: #{e.backtrace}")
  <<~HTML
    <p>
      Something broke.  You can try <a href='/200x200'>this simple test</a>.#{' '}
      If this error occurs there as well, you are probably missing app dependencies. Make sure RMagick#{' '}
      is installed correctly. If the test works, you are probably passing bad params in the url.
    </p>
    <p>Use this thing like http://host:port/200x300, or add color and textcolor params to decide color.</p>
    <p>Error is: [<code>#{e}</code>]</p>
  HTML
end

private

def color_convert(original)
  original&.tr('!', '#')
end
