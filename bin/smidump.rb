#!/usr/bin/env ruby

require 'nice-ffi'

require File.dirname(__FILE__) + "/../lib/smi/wrapper"

SMI::Wrapper.smiInit(nil)
ptr = FFI::MemoryPointer.new :pointer

ptr =  SMI::Wrapper.smiGetNode(nil, "IF-MIB::ifNumber")

node = SMI::Wrapper::SmiNode.new(ptr)

puts node[:oidlen]
puts node[:name]