require 'optparse'

@options = {}

@optparse = OptionParser.new do | opts |

  opts.banner = "\nUsage: eagleclone -d design_to_clone -p clone_postfix"

  opts.on("-d", "--design DESIGN", "specify design file without file extension") do | design |
    @options[:design] = design
  end

  opts.on("-p", "--postfix POSTFIX", "specify the postfix to append to all parts, signals, etc") do |postfix|
    @options[:postfix] = postfix
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end


begin
  @optparse.parse!
rescue OptionParser::ParseError => @parse_error
  puts "\n#{@parse_error.message}"
  exit 1
rescue Exception => @exception
  puts "\n#{@exception.message}"
end

# enforce options

if @options[:design].nil?
  puts "must supply a design file with the -d option"
  exit -1
end

if @options[:postfix].nil?
  puts "must supply a postfix with the -p option"
  exit -1
end

#p @options
