require 'rubygems' rescue nil
#require 'wirble'
require 'pp'

class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end

if defined? Wirble
  Wirble.init
  Wirble.colorize
end
