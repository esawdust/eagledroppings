require_relative '../pcb'

describe EaglePCB do
  it "should be a brd design file" do
    board_design = File.open("test.brd","r").read
    pcb = EaglePCB.new( board_design )
    pcb.isPCB == true
  end

  it "should know it was given an invalid board file" do
    board_design = File.open("test.sch","r").read
    pcb = EaglePCB.new( board_design )
    pcb.isPCB  == false
  end

  it "should be able to locate all the parts in a board file" do
    board_design = File.open("test.brd","r").read
    pcb = EaglePCB.new( board_design )
    parts_list = pcb.parts
    parts_list.should have(20).items
    @names = []
    parts_list.each do | element |
      # puts "part, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    @names.should include("AMP1.1")
    @names.should include("C1.4")
    @names.should include("LMV932-1.1")
  end

  it "should be able to locate all the signals in a board file" do
    board_design = File.open("test.brd","r").read
    pcb = EaglePCB.new( board_design )
    signals_list = pcb.signals
    signals_list.should have(13).items

    @names = []
    signals_list.each do | element |
      # puts "signal, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    @names.should include("GND")
    @names.should include("3.3V")
    @names.should include("ADC0")
    @names.should include("G1.1A")
    @names.should include("G1.1B")
    @names.should include("AMPREF")
    @names.should include("N$8")
    @names.should_not include("Bogus")
  end

  it "should be able to clone parts" do

    pcb = EaglePCB.new( File.open("test.brd","r").read )
    pcb.clone("-XYZ")

    parts_list = pcb.parts
    parts_list.should have(20).items
    @names = []
    parts_list.each do | element |
      # puts "part, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    @names.should include("AMP1.1-XYZ")
    @names.should include("C1.4-XYZ")
    @names.should include("LMV932-1.1-XYZ")

  end

  it "should be able to clone signals" do
    pcb = EaglePCB.new( File.open("test.brd","r").read )
    pcb.clone("-XYZ")

    signals_list = pcb.signals
    signals_list.should have(13).items

    @names = []
    signals_list.each do | element |
      # puts "signal, #{element.attributes["name"]}"
      @names << element.attributes["name"].to_s
    end

    @names.should include("ADC0-XYZ")
    @names.should include("G1.1A-XYZ")
    @names.should include("AMPREF-XYZ")
    @names.should include("N$8-XYZ")

    @names.should_not include("3.3V-XYZ")
    @names.should_not include("3.3V-GND")

  end

  it "should be able to clone contact refs" do
    pcb = EaglePCB.new( File.open("test.brd","r").read )
    pcb.clone("-XYZ")

    contacts_list = pcb.contacts
    contacts_list.should have(52).items

    @names = []
    contacts_list.each do | element |
      # puts "contact, #{element.attributes["element"]}"
      @names << element.attributes["element"].to_s
    end

  end

  it "should be able to clone a new file for Eagle" do
    pcb = EaglePCB.new( File.open("test.brd","r").read )
    pcb.clone("-ABC")

    File.new("test-conversion.brd","w").write(pcb.board_doc.to_s)
  end


end

