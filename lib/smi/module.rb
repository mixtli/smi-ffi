module Smi
  class Module
    extend Forwardable
    attr_accessor :struct, :name, :path, :organization, :contactinfo, :description, :reference, :language, :conformance
    def_delegators :@struct, :name, :path, :organization, :contactinfo, :description, :reference, :language, :conformance
    class << self
      def get_module(m)
        ptr = Smi::Wrapper.smiGetModule(m)
        new(ptr)
      end
      def get_modules
        ptr = Smi::Wrapper.smiGetFirstModule
        m = self.new(ptr)
        modules = [m]
        while ptr = Smi::Wrapper::smiGetNextModule(ptr)
          break if ptr.pointer.null?
          modules << new(ptr)
        end
        modules
      end
    end
    
    def initialize(ptr)
      @struct = ptr
    end
    
    def get_nodes(nodekind = Wrapper::SMI_NODEKIND_NODE)
        ptr = Wrapper.smiGetFirstNode(@struct.pointer, nodekind)
        n = Smi::Node.new(ptr)
        nodes = [n]
        while ptr = Smi::Wrapper::smiGetNextNode(ptr.pointer, nodekind)
          break if ptr.pointer.null?
          nodes << Smi::Node.new(ptr)
        end
        nodes
      end
    
  end
end
