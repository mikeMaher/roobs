require 'nokogiri'

class Splitter
  def initialize(file_path, new_path)
    @ext = File.extname(file_path)
    @doc = Nokogiri::XML File.read(file_path)
    @new_path = new_path
  end

  def split
    chapters = @doc.css('chapter')
    chapters.each_with_index do |chap, ind|
      chap_number = ind + 1
      file_name = @new_path + chap_number.to_s + @ext
      new_file = File.new(file_name, 'w')
      new_file.write(chap.to_s)
      new_file.close
    end
  end
end

duck = Splitter.new(ARGV[0], ARGV[1])
duck.split
