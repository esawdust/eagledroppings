$:.unshift File.join(File.dirname(__FILE__))            # add current dir to the load path
$:.unshift File.join("#{File.dirname(__FILE__)}/../lib")   # add relative lib dir to the load path

require 'eagleschematic'

describe EagleSchematic do

  before :each do
    @testpcb = "./spec/test.brd"
    @testschematic = "./spec/test.sch"
  end

  it "should be a sch design file" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.isSchematic == true
  end

  it "should know it was given an invalid schematic file" do
    board_design = File.open(@testpcb,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.isSchematic == false
  end

  it "should be able to locate all the parts in a schematic file" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    parts_list = schematic.parts
    parts_list.should have(35).items
    @names = []
    parts_list.each do | part |
      @names << part.attributes["name"].to_s
    end

    @names.should include("AMP1.1")
    @names.should include("C1.4")
    @names.should include("LMV932-1.1")
  end

  it "should be able to clone parts" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    parts_list = schematic.parts
    parts_list.should have(35).items
    @names = []
    parts_list.each do | part |
      @names << part.attributes["name"].to_s
    end

    @names.should include("AMP1.1-XYZ")
    @names.should include("C1.4-XYZ")
    @names.should include("LMV932-1.1-XYZ")
  end

  it "should be able to clone pinrefs" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    pinref_list = schematic.pin_refs
    pinref_list.should have(66).items
    @names = []
    pinref_list.each do | pinref |
      @names << pinref.attributes["part"].to_s
    end

    @names.should include("AMP1.1-XYZ")
    @names.should include("C1.4-XYZ")
    @names.should include("LMV932-1.1-XYZ")

  end

  it "should be able to clone pinrefs" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    pinref_list = schematic.pin_refs
    pinref_list.should have(66).items
    @names = []
    pinref_list.each do | pinref |
      #puts "pinref:#{pinref.inspect}"
      @names << pinref.attributes["part"].to_s
    end

    @names.should include("C1.5-XYZ")
    @names.should include("LMV932-1.1-XYZ")

  end

  it "should be able to clone nets" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    net_list = schematic.nets
    net_list.should have(13).items
    @names = []
    net_list.each do | pinref |
      @names << pinref.attributes["name"].to_s
    end

    @names.should include("N$5-XYZ")
    @names.should include ("AMPREF-XYZ")
  end

  it "should be able to clone a new file for Eagle" do
    schematic = EagleSchematic.new( File.open(@testschematic,"r").read )
    schematic.clone("-ABC")

    File.new("test-conversion.sch","w").write(schematic.board_doc.to_s)
  end

end
