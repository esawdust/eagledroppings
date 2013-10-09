
require 'pcb'
require 'schematic'

class EagleDesign

  attr_accessor :pcb_contents, :schematic_contents, :clone_postfix, :basename

  def initialize filename
    @basename = File.basename(filename)
    pcb = @basename + ".brd"
    schematic = @basename + ".sch"

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