=begin
 eaglepcb.rb by Landon Cox

  class to implement the translation of the Eagle PCB file
=end

require 'nokogiri'

class EaglePCB

  attr_accessor :design, :clone_postfix, :board_doc

  def initialize( design )
    @design = design
    @board_doc = Nokogiri::XML( @design )
  end

  def clone( postfix )
    @clone_postfix = postfix

    replace_all_parts
    replace_all_signals
    replace_all_contact_refs

  end

  def isPCB
      if @design =~ /^<board>/
        return true
      else
        return false
      end
  end

  def parts
    elements = board_doc.xpath("//elements/element")
  end

  def signals
    elements = board_doc.xpath("//signal")
  end

  def contacts
    contacts = board_doc.xpath("//contactref")
  end

  def replace_all_parts
    parts_list = board_doc.xpath("//elements/element")
    parts_list.each do | element |
      element.attributes["name"].value = element.attributes["name"].value + @clone_postfix
    end

    parts_list
  end

  def replace_all_signals
    signal_list = board_doc.xpath("//signal")
    signal_list.each do | element |
      if (element.attributes["name"].value != "3.3V" && element.attributes["name"].value != "GND" )
        element.attributes["name"].value = element.attributes["name"].value + @clone_postfix
      end
    end

    signal_list
  end

  def replace_all_contact_refs
    contact_list = board_doc.xpath("//contactref")
    contact_list.each do | element |
      element.attributes["element"].value = element.attributes["element"].value + @clone_postfix
    end

    contact_list
  end

end
