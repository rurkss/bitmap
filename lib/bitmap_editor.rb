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

      if COMMANDS[command_method].nil?
        puts 'unrecognised command :('
        next
      end

      send(COMMANDS[command_method], commands)
    end
  end

  def init args
    @bit_map = Array.new(args.last.to_i) { Array.new(args.first.to_i, "O") }
  end

  def color args
    x, y, color = args

    x = x.to_i - 1
    y = y.to_i - 1

    if @bit_map[y].nil? || @bit_map[y][x].nil?
      puts "bit #{x}X#{y} is out of range"
      return
    end

    @bit_map[y][x] = color
  end

  def clear args = []
    init( [@bit_map.first.size, @bit_map.size] ) unless @bit_map.nil?
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

    if @bit_map.nil?
      puts "Run command 'I' before use command 'S'"
      return
    end

    puts "\n"
    @bit_map.each do |bits|
      puts bits.each { |bit| bit }.join(" ")
    end
  end

end
