require 'forwardable'
require 'nice-ffi'
require 'smi/wrapper'
require 'smi/config'
require 'smi/module'
require 'smi/node'

#Smi::Wrapper.smiInit(nil)

#modules = ["IF-MIB", "RFC1213-MIB"]

#modules.each do |m| 
#  Smi::Wrapper.smiLoadModule("IF-MIB") 
#end



module Smi
  def self.translate(name)
    node = Smi::Node.get_node(name)
    index = name.split(node.name).last
    node.oid + index
  end

end
