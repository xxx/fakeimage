require 'sinatra'
require 'RMagick'
require 'rvg/rvg'

FORMATS = {
  "png" => "png",
  "gif" => "gif",
  "jpg" => "jpeg"
}

get '/' do
  "Welcome to fakeimage. Please see the README at <a href='http://github.com/xxx/fakeimage'>http://github.com/xxx/fakeimage</a> for usage info so I don't have to maintain two copies of it. Try <a href='http://fakeimage.heroku.com/243x350.gif?color=darkorchid2&textcolor=snow'>this</a>."
end

get '/:size' do
  begin
    wh, format = params[:size].split('.')
    format ||= 'png'
    format = FORMATS[format]

    width, height = wh.split('x')

    width = width.to_i

    if height
      height = height.to_i
    else
      height = width
    end

    color = color_convert(params[:color], 'grey69')
    text_color = color_convert(params[:textcolor], 'black')

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
    "Something broke. Use this thing like http://host:port/200x300, or add color and textcolor params to decide color. Error is: [#{e}]"
  end

end

private

def color_convert(original, default)
  if original
    if original[0..0] == '!'
      original.gsub(/!/, '#')
    else
      original
    end
  else
    default
  end
end
