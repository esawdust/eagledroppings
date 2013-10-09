
require 'nokogiri'

class EagleSchematic

  attr_accessor :design, :clone_postfix, :board_doc

  def initialize( design )
    @design = design
    @board_doc = Nokogiri::XML( @design )
  end

  def clone( postfix )
    @clone_postfix = postfix

    replace_all_parts
    replace_all_pinrefs
    replace_all_instances
    replace_all_nets

  end

  def isSchematic
    if @design =~ /^<schematic/
      return true
    else
      return false
    end
  end

  def parts
    parts = board_doc.xpath("//parts/part")
  end

  def pin_refs
    pin_refs = board_doc.xpath("//nets/net/segment/pinref")
  end

  def instances
    instances = board_doc.xpath("//instances/instance")
  end

  def nets
    nets = board_doc.xpath("//nets/net")
  end

  def replace_all_parts
    parts_list = parts
    parts_list.each do | part |
      part.attributes["name"].value = part.attributes["name"].value + @clone_postfix
      # puts "part, #{part.attributes["name"].value}"
    end

    parts_list
  end

  def replace_all_pinrefs
    pins = pin_refs
    pins.each do | pin_ref |
      # puts "pin_ref, #{pin_ref.attributes["part"].value}"
      pin_ref.attributes["part"].value = pin_ref.attributes["part"].value + @clone_postfix
      # puts "pin_ref, #{pin_ref.attributes["part"].value}"
    end

    pins
  end

  def replace_all_instances
    inst = instances
    inst.each do | instance |
      instance.attributes["part"].value = instance.attributes["part"].value + @clone_postfix
      # puts "instance, #{instance.inspect}"
    end

    inst
  end

  def replace_all_nets
    net_list = nets
    net_list.each do |net|
       if (net.attributes["name"].value != "3.3V" && net.attributes["name"].value != "GND" )
         net.attributes["name"].value = net.attributes["name"].value + @clone_postfix
         #puts "net, #{net.attributes['name'].value}"
       end
    end
  end

end
