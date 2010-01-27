require 'rubygems'
require 'sinatra'
require 'RMagick'
require 'rvg/rvg'

FORMATS = {
  "png" => "png",
  "gif" => "gif",
  "jpg" => "jpeg"
}

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

    rvg = Magick::RVG.new(width, height).viewbox(0, 0, width, height) do |canvas|
      canvas.background_fill = params[:color] || 'gray'
    end

    img = rvg.draw

    img.format = format

    drawable = Magick::Draw.new
    drawable.pointsize = width / 10
    drawable.font = ("./DroidSans.ttf")
    drawable.fill = params[:textcolor] || 'black'
    drawable.gravity = Magick::CenterGravity
    drawable.annotate(img, 0, 0, 0, 0, "#{width} x #{height}")

    send_data img.to_blob,
      :filename => "#{params[:size]}.#{format}",
      :disposition => 'inline',
      :quality => 90,
      :type => "image/#{format}"

  rescue Exception => e
    "Something broke. Use this thing like http://host:port/200x300, or add color and textcolor params to decide color. Error is: [#{e}]"
  end
end
