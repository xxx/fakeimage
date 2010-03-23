gem 'sinatra', '0.9.4'
require 'sinatra'
require 'RMagick'
require 'rvg/rvg'

FORMATS = {
  "png" => "png",
  "gif" => "gif",
  "jpg" => "jpeg"
}

get '/' do
  "<p>Welcome to fakeimage.</p><p>Please see the README (specifically the 'Use' section) at <a href='http://github.com/xxx/fakeimage'>http://github.com/xxx/fakeimage</a> for usage info so I don't have a chance to let one of the copies get out of date.</p><p>Example: <img src='/243x350.gif?color=darkorchid2&textcolor=!B9AF55' /></p><p>Code: <code>&lt;img src='http://fakeimage.heroku.com/243x350.gif?color=darkorchid2&textcolor=!B9AF55' /&gt;</code>"
end

get '/:size' do
  begin
    wh, format = params[:size].downcase.split('.')
    format = FORMATS[format] || 'png'

    width, height = wh.split('x').map { |wat| wat.to_i }

    height = width unless height

    color = color_convert(params[:color]) || 'grey69'
    text_color = color_convert(params[:textcolor]) || 'black'

    rvg = Magick::RVG.new(width, height).viewbox(0, 0, width, height) do |canvas|
      canvas.background_fill = color
    end

    img = rvg.draw

    img.format = format

    drawable = Magick::Draw.new
    drawable.pointsize = width / 10
    drawable.font = ("./DroidSans.ttf")
    drawable.fill = text_color
    drawable.gravity = Magick::CenterGravity
    drawable.annotate(img, 0, 0, 0, 0, "#{width} x #{height}")

    send_data img.to_blob,
      :filename => "#{width}x#{height}.#{format}",
      :disposition => 'inline',
      :quality => 90,
      :type => "image/#{format}"

  rescue Exception => e
    "<p>Something broke.  You can try <a href='/200x200'>this simple test</a>. If this error occurs there as well, you are probably missing app dependencies. Make sure RMagick is installed correctly. If the test works, you are probably passing bad params in the url.</p><p>Use this thing like http://host:port/200x300, or add color and textcolor params to decide color.</p><p>Error is: [<code>#{e}</code>]</p>"
  end

end

private

def color_convert(original)
  if original
    if original.index('!') == 0
      original.tr('!', '#')
    else
      original
    end
  end
end
