
class Combiner
  def initialize(dir, new_file)
    @dir = dir 
    @new_file = new_file
    @ext = File.extname(new_file)
  end

  def combine
    output = File.new(@new_file, 'w')
    Dir[@dir + '/*' + @ext].each do |file|
      contents = File.read(file)
      output.write(contents)
    end
    output.close
  end
end



duck = Combiner.new(ARGV[0], ARGV[1])
duck.combine
