require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Smi::Config.set_path(File.dirname(__FILE__) + '/mibs')
#Smi::Wrapper.smiSetPath(File.dirname(__FILE__) + '/mibs')

Smi::Config.init(nil)
#Smi::Wrapper.smiInit(nil)

["IF-MIB", "RFC1213-MIB", "IP-MIB", "HOST-RESOURCES-MIB", "SNMPv2-TC"].each do |m|
  Smi::Config.load_module(m)
  #Smi::Wrapper.smiLoadModule(m)
end


describe "Smi::Config" do

  it "should get the mib path" do
    Smi::Config.get_path.should match(/mibs/)
  end
end

describe "Smi::Module" do
   it "should get a list of modules" do
     mlist = Smi::Module.get_modules.first.name.should == "IF-MIB"
   end

   it "should get IF-MIB module" do
     m = Smi::Module.get_module("IF-MIB")
     m.name.should eql("IF-MIB")
   end
   
   
   it "should get a list of nodes from IF-MIB" do
     m = Smi::Module.get_module("RFC1213-MIB")
     nodes = m.get_nodes
     nodes.count.should eql(11)
     node = nodes.first
     node.name.should eql("mib-2")
     node.oid.should eql("1.3.6.1.2.1")
   end
 end
 
describe "Smi::Node" do
   
   it "should get child nodes" do
     node = Smi::Node.get_node("ifEntry")
     node.children.first.name.should eql("ifIndex")
     node.children.last.name.should eql("ifSpecific")
   end
   

   it "should get node from leaf" do
     node = Smi::Node.get_node("ifDescr.5")
     node.name.should eql("ifDescr")
     node.oid.should eql("1.3.6.1.2.1.2.2.1.2")
   end

   it "should translate oid" do
     Smi.translate("ifDescr.5").should eql("1.3.6.1.2.1.2.2.1.2.5")
   end

   it "should set index in get_node" do
      node = Smi::Node.get_node("1.3.6.1.2.1.2.2.1.2.1")
      node.oid.should eql("1.3.6.1.2.1.2.2.1.2")
      node.index.should eql("1")
   end

   it "should return the node type" do
      node = Smi::Node.get_node("1.3.6.1.2.1.2.2.1.2.1")
      node.type.class.should eql(Smi::Node::Type)
   end

   #it "should do stuff" do
   #node = Smi::Node.get_node("ipAdEntIfIndex")
   #puts node.struct.inspect
   #related = Smi::Wrapper.smiGetRelatedNode(node.struct.pointer)
   #puts related.inspect
   #end
end

describe Smi::Node::Type do
  it "should return its format" do
    node = Smi::Node.get_node("1.3.6.1.2.1.25.1.2")
    node.type.format.should eql("2d-1d-1d,1d:1d:1d.1d,1a1d:1d")
  end
end
