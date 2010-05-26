module Smi
  class Node
    extend Forwardable
    attr_accessor :struct
    def_delegators :@struct, :pointer, :name, :decl, :access, :status, :format, :value, :units, :description, :reference, :indexkind, :implied, :create, :nodekind
    def initialize(ptr)
      @struct = ptr
    end
    
    def oid
      @struct.oid.read_array_of_int(@struct.oidlen).join(".")
    end
    
    def self.get_node(oid)
      struct = Wrapper::smiGetNode(nil, oid)
      new(struct)
    end
    
    def children
      nodes = []
      node = Wrapper::smiGetFirstChildNode(struct.pointer)
      node = self.class.new(node)
      nodes << node
      while !(node = Wrapper::smiGetNextChildNode(node.pointer)).null?
        node = self.class.new(node)
        nodes << node
      end
      nodes
    end
    
  end
end
