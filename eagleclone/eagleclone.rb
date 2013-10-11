#!/usr/bin/env ruby

=begin
 eagleclone.rb by Landon Cox

 utility to clone all the components and nets of an eagle schematic and board
 so that the result may be easily imported into a new design without having to
 go through the tedium of mapping duplicate nets

=end

$:.unshift File.join(File.dirname(__FILE__))            # add current dir to the load path
$:.unshift File.join("#{File.dirname(__FILE__)}/lib")   # add relative lib dir to the load path

require 'cliopts'
require 'eagledesign'

@ed = EagleDesign.new( @options[:design] )
@ed.clone_design(@options[:postfix])
@ed.write

