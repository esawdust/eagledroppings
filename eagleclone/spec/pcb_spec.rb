$:.unshift File.join(File.dirname(__FILE__))            # add current dir to the load path
$:.unshift File.join("#{File.dirname(__FILE__)}/../lib")   # add relative lib dir to the load path

require 'eaglepcb'

describe EaglePCB do

  # use the Sparkfun OpAmp breakout board as a test fixture
  before :each do
    @testpcb = "./spec/OpAmpBreakout-v16.brd"
    @testschematic = "./spec/OpAmpBreakout-v16.sch"
  end

  it "should be a brd design file" do
    board_design = File.open(@testpcb,"r").read
    pcb = EaglePCB.new( board_design )
    pcb.isPCB == true
  end

  it "should know it was given an invalid board file" do
    board_design = File.open( @testschematic,"r").read
    pcb = EaglePCB.new( board_design )
    pcb.isPCB  == false
  end

  it "should be able to locate all the parts in a board file" do
    board_design = File.open(@testpcb,"r").read
    pcb = EaglePCB.new( board_design )
    parts_list = pcb.parts
    parts_list.should have(19).items
    @names = []
    parts_list.each do | element |
      # puts "part, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    @names.should include("IC1")
    @names.should include("R3")
    @names.should include("E$2")
  end

  it "should be able to locate all the signals in a board file" do
    board_design = File.open(@testpcb,"r").read
    pcb = EaglePCB.new( board_design )
    signals_list = pcb.signals
    signals_list.should have(12).items

    @names = []
    signals_list.each do | element |
      # puts "signal, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    ["GND", "N$2", "N$7", "IN1", "OUT1", "N$4", "N$5", "IN", "OUT", "N$1", "N$3", "VCC"].each do | thing |
      @names.should include( thing)
    end

    @names.should_not include("Bogus")
  end

  it "should be able to clone parts" do

    pcb = EaglePCB.new( File.open(@testpcb,"r").read )
    pcb.clone("-XYZ")

    parts_list = pcb.parts
    parts_list.should have(19).items
    @names = []
    parts_list.each do | element |
      # puts "part, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    ["R1-XYZ", "R2-XYZ", "R3-XYZ", "R4-XYZ", "R5-XYZ",
     "R6-XYZ", "C1-XYZ", "C2-XYZ", "C3-XYZ", "C5-XYZ",
     "C6-XYZ", "JP1-XYZ", "IC1-XYZ", "U$3-XYZ", "R7-XYZ",
     "R8-XYZ", "R9-XYZ", "E$1-XYZ", "E$2-XYZ"].each do | thing |
      @names.should include(thing)
    end

  end

  it "should be able to clone signals" do
    pcb = EaglePCB.new( File.open(@testpcb,"r").read )
    pcb.clone("-XYZ")

    signals_list = pcb.signals
    signals_list.should have(12).items

    @names = []
    signals_list.each do | element |
      # puts "signal, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    ["GND", "N$2-XYZ", "N$7-XYZ", "IN1-XYZ", "OUT1-XYZ", "N$4-XYZ",
     "N$5-XYZ", "IN-XYZ", "OUT-XYZ", "N$1-XYZ", "N$3-XYZ", "VCC-XYZ"].each do | thing |
      @names.should include(thing)
    end

    @names.should_not include("3.3V-XYZ")
    @names.should_not include("3.3V-GND")

  end

  it "should be able to clone contact refs" do
    pcb = EaglePCB.new( File.open(@testpcb,"r").read )
    pcb.clone("-XYZ")

    contacts_list = pcb.contacts
    contacts_list.should have(41).items

    @names = []
    contacts_list.each do | element |
      # puts "contact, #{element.attributes["element"]}"
      @names << element.attributes["element"].to_s
    end

  end

  it "should be able to clone a new file for Eagle" do
    pcb = EaglePCB.new( File.open(@testpcb,"r").read )
    pcb.clone("-ABC")

    File.new("./spec/OpAmp-breakout-ABC.brd","w").write(pcb.board_doc.to_s)
  end

  it "should generate board files that match exactly pre-validated files" do
    `diff -q ./spec/OpAmp-breakout-ABC.brd ./spec/OpAmp-expected.brd` == ""
  end

  it "should insure that generated files are not the same as each other" do
    `diff -q ./spec/OpAmp-breakout-ABC.sch ./spec/OpAmp-breakout-ABC.brd` =~ /differ/
  end

end

