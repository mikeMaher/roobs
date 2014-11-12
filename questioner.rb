 require 'nokogiri'

class Questioner
  attr_reader :doc

  def initialize(file_path)
    @doc = Nokogiri::XML File.read(file_path)
  end

  def question
    questions = doc.css('question > quf').map { |q| q.parent }.uniq
    answers = doc.css('question > ansf').map { |q| q.parent }.uniq
    questions.zip(answers).each do |question, answer|
      question.add_child(answer.children)
      answer.remove
    end
  end
end

# goose = '/home/mmaher/code/questioner/aph-ques-sample.scml'
input = ARGV[0]
output = ARGV[1]

combiner = Questioner.new(input)
combiner.question

File.open(output, 'w').write combiner.doc   
