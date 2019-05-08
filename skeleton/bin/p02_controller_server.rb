require 'rack'
require_relative '../lib/controller_base'
require 'byebug'

class MyController < ControllerBase
  
  attr_accessor :req, :res

  # def initialize(req, res)
  #   @req = req
  #   @res = res
  # end
  
  def go
    if req.path == "/cats"
      render_content("hello cats!!!!", "text/html")
    else
      redirect_to("/cats")
    end
  end

  # def render_content(content, content_type)
  #   # debugger
  #   # res['Content-Type'] = content_type
  #   # res.write(content)
  #   # res.finish
  #   # @already_built_response = true
  # end

end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  MyController.new(req, res).go
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

