require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

Smi::Config.set_path(File.dirname(__FILE__) + '/mibs')
#Smi::Wrapper.smiSetPath(File.dirname(__FILE__) + '/mibs')

Smi::Config.init(nil)
#Smi::Wrapper.smiInit(nil)

["IF-MIB", "RFC1213-MIB"].each do |m|
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
end
