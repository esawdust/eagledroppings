=begin
 eagledesign.rb by Landon Cox

  class to implement the translation of Eagle PCB and schematics so they
  continue to be matched when a new instance of the design is made
=end

require 'eaglepcb'
require 'eagleschematic'

class EagleDesign

  attr_accessor :pcb_contents, :schematic_contents, :clone_postfix, :basename

  def initialize filename
    @basename = filename

    pcb = filename + ".brd"
    schematic = filename + ".sch"

    @pcb_contents = File.open( pcb, "r").read
    @schematic_contents = File.open( schematic, "r").read
  end

  def clone_design clone_postfix
    @clone_postfix = clone_postfix
    @eagle_pcb = EaglePCB.new( @pcb_contents )
    @pcb_converted = @eagle_pcb.clone( clone_postfix )

    @eagle_schematic = EagleSchematic.new( @schematic_contents )
    @schematic_converted = @eagle_schematic.clone( clone_postfix )
  end

  def write
    pcb_filename = @basename + @clone_postfix + ".brd"
    schematic_filename = @basename + @clone_postfix + ".sch"

    File.open( pcb_filename, "w").write( @eagle_pcb.board_doc.to_s )
    File.open( schematic_filename, "w").write( @eagle_schematic.board_doc.to_s )
  end

end