class BitmapEditor

  attr_reader :bit_map

  COMMANDS = {
    "I" => "init",
    "L" => "color",
    "V" => "vertical",
    "H" => "horizontal",
    "C" => "clear",
    "S" => "show"
  }

  def run(file)
    return puts "please provide correct file" if file.nil? || !File.exists?(file)

    File.open(file).each do |line|
      commands = line.chomp.split(/\s+/)
      command_method = commands.slice!(0)
      send(COMMANDS[command_method], commands)
    end
  end

  def init args
    @bit_map = Array.new(args.last.to_i) { Array.new(args.first.to_i, "O") }
  end

  def color args
    x, y, color = args
    @bit_map[y.to_i-1][x.to_i-1] = color
  end

  def clear args = []
    init( [@bit_map.first.size, @bit_map.size] )
  end

  def vertical args
    x, y1, y2, color = args
    (y1..y2).to_a.each{|y| color([x,y,color])}
  end

  def horizontal args
    x1, x2, y, color = args
    (x1..x2).to_a.each{|x| color([x,y,color])}
  end

  def show args = []
    puts "\n"
    @bit_map.each do |bits|
      puts bits.each { |bit| bit }.join(" ")
    end
  end

end
