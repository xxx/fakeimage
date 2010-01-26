require 'rubygems'
require 'sinatra'
require 'RMagick'
require 'rvg/rvg'

get '/:size' do
  begin
    width, height = params[:size].split('x').map(&:to_i)

    rvg = Magick::RVG.new(width, height).viewbox(0, 0, width, height) do |canvas|
      canvas.background_fill = params[:color].to_s || 'gray'
    end

    img = rvg.draw

    img.format = "png"

    drawable = Magick::Draw.new
    drawable.pointsize = width / 10
    drawable.font = ("./DroidSans.ttf")
    drawable.fill = params[:textcolor].to_s || 'black'
    drawable.gravity = Magick::CenterGravity
    drawable.annotate(img, 0, 0, 0, 0, "#{width} x #{height}")

    send_data img.to_blob,
      :filename => "#{params[:size]}.png",
      :disposition => 'inline',
      :quality => 90,
      :type => 'image/png'

  rescue Exception => e
    "Something broke. Use this thing like http://host:port/200x300, or add color and textcolor params to decide color. Error is: [#{e}]"
  end
end
