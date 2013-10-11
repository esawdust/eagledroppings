$:.unshift File.join(File.dirname(__FILE__))            # add current dir to the load path
$:.unshift File.join("#{File.dirname(__FILE__)}/../lib")   # add relative lib dir to the load path

require 'eagleschematic'

describe EagleSchematic do

  # use the Sparkfun OpAmp breakout board as a test fixture
  before :each do
    @testpcb = "./spec/OpAmpBreakout-v16.brd"
    @testschematic = "./spec/OpAmpBreakout-v16.sch"
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
    parts_list.should have(22).items
    @names = []
    parts_list.each do | part |
      @names << part.attributes["name"].to_s
    end

    ["FRAME1", "R1", "R2", "R3", "R4", "R5", "R6", "C1", "C2", "C3",
     "GND6", "C5", "C6", "GND1", "JP1", "IC1", "U$3", "R7", "GND2",
     "GND3", "R8", "R9"].each do | thing |
      @names.should include(thing)
    end
  end

  it "should be able to clone parts" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    parts_list = schematic.parts
    parts_list.should have(22).items
    @names = []
    parts_list.each do | part |
      @names << part.attributes["name"].to_s
    end

    ["FRAME1-XYZ", "R1-XYZ", "R2-XYZ", "R3-XYZ", "R4-XYZ", "R5-XYZ", "R6-XYZ",
     "C1-XYZ", "C2-XYZ", "C3-XYZ", "GND6-XYZ", "C5-XYZ", "C6-XYZ", "GND1-XYZ",
     "JP1-XYZ", "IC1-XYZ", "U$3-XYZ", "R7-XYZ", "GND2-XYZ", "GND3-XYZ", "R8-XYZ",
     "R9-XYZ"].each do | thing |
      @names.should include(thing)
     end
  end

  it "should be able to clone pinrefs" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    pinref_list = schematic.pin_refs
    pinref_list.should have(45).items
    @names = []
    pinref_list.each do | pinref |
      @names << pinref.attributes["part"].to_s
    end

    ["R6-XYZ", "GND6-XYZ", "R7-XYZ", "GND1-XYZ", "JP1-XYZ",
     "R3-XYZ", "GND2-XYZ", "C2-XYZ", "GND3-XYZ", "IC1-XYZ",
     "R2-XYZ", "C1-XYZ", "R1-XYZ", "IC1-XYZ", "R5-XYZ", "C3-XYZ",
     "R4-XYZ", "IC1-XYZ", "R2-XYZ", "C5-XYZ", "R1-XYZ", "IC1-XYZ",
     "R7-XYZ", "C1-XYZ", "C6-XYZ", "R5-XYZ", "C6-XYZ", "R7-XYZ",
     "JP1-XYZ", "C5-XYZ", "JP1-XYZ", "C3-XYZ", "R4-XYZ", "IC1-XYZ",
     "IC1-XYZ", "R6-XYZ", "R9-XYZ", "R3-XYZ", "IC1-XYZ", "R8-XYZ",
     "JP1-XYZ", "C2-XYZ", "IC1-XYZ", "R8-XYZ", "R9-XYZ"].each do | thing |
        @names.should include(thing)
      end

  end

  it "should be able to clone pinrefs" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    pinref_list = schematic.pin_refs
    pinref_list.should have(45).items
    @names = []
    pinref_list.each do | pinref |
      #puts "pinref:#{pinref.inspect}"
      @names << pinref.attributes["part"].to_s
    end

    ["R6-XYZ", "GND6-XYZ", "R7-XYZ", "GND1-XYZ", "JP1-XYZ", "R3-XYZ",
     "GND2-XYZ", "C2-XYZ", "GND3-XYZ", "IC1-XYZ", "R2-XYZ", "C1-XYZ",
     "R1-XYZ", "IC1-XYZ", "R5-XYZ", "C3-XYZ", "R4-XYZ", "IC1-XYZ",
     "R2-XYZ", "C5-XYZ", "R1-XYZ", "IC1-XYZ", "R7-XYZ", "C1-XYZ",
     "C6-XYZ", "R5-XYZ", "C6-XYZ", "R7-XYZ", "JP1-XYZ", "C5-XYZ",
     "JP1-XYZ", "C3-XYZ", "R4-XYZ", "IC1-XYZ", "IC1-XYZ", "R6-XYZ",
     "R9-XYZ", "R3-XYZ", "IC1-XYZ", "R8-XYZ", "JP1-XYZ", "C2-XYZ",
     "IC1-XYZ", "R8-XYZ", "R9-XYZ"].each do | thing |
        @names.should include(thing)
      end

  end

  it "should be able to clone nets" do
    board_design = File.open(@testschematic,"r").read
    schematic = EagleSchematic.new( board_design )
    schematic.clone("-XYZ")

    net_list = schematic.nets
    net_list.should have(12).items
    @names = []
    net_list.each do | pinref |
      @names << pinref.attributes["name"].to_s
    end

    ["GND", "N$2-XYZ", "N$7-XYZ", "IN1-XYZ", "OUT1-XYZ",
     "N$4-XYZ", "N$5-XYZ", "IN-XYZ", "OUT-XYZ", "N$1-XYZ",
     "N$3-XYZ", "VCC"].each do | thing |
      @names.should include(thing)
    end

    # make sure power stuff doesn't get translated
    @names.should_not include("VCC-XYZ")
    @names.should_not include("GND-XYZ")
  end

  it "should be able to clone a new file for Eagle" do
    schematic = EagleSchematic.new( File.open(@testschematic,"r").read )
    schematic.clone("-ABC")

    File.new("./spec/OpAmp-breakout-ABC.sch","w").write(schematic.board_doc.to_s)
  end

  it "should generate board files that match exactly pre-validated files" do
    $result = `diff -q ./spec/OpAmp-breakout-ABC.sch ./spec/OpAmp-expected.sch`
    $result == ""
  end

  it "should insure that generated files are not the same as each other" do
    $result = `diff -q ./spec/OpAmp-breakout-ABC.sch ./spec/OpAmp-breakout-ABC.brd`
    $result =~ /differ/
  end

end
