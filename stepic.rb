class Stepic
  attr_accessor :input

  def initialize content
    split_content content
  end

  def clean_input input
    if input.length == 1
      input = input[0].split
    end
    input = input.collect do |line|
      line.strip
    end
    input = input.select do |line|
      line != ""
    end
  end

  def split_content content
    data = content.split "\n"
    input = []
    output = []
    input_mode = true
    data.each do |line|
      if line =~ /Input/
        input_mode = true
      elsif line =~ /Output/
        input_mode = false
      elsif input_mode
        input << line
      else
        output << line
      end
    end
    input = clean_input input
    if output.length == 1
      output = output[0].strip
    end
    @input = input
    @output = output
  end

  def handle_output actual
    if @output.length > 0
      test_output_matches_expected actual
    else
      puts actual
    end
  end

  def test_output_matches_expected actual
    expected = @output.split
    actual = actual.split
    if expected.length != actual.length
      puts "Actual result size doesn't match expected result size"
      puts "Size(expected) = #{expected.length}; Expected = #{expected}"
      puts "Size(actual) = #{actual.length}; Actual = #{actual}"
    else
      (0...expected.length).each do |i|
        if expected[i] != actual[i]
          puts "Mismatch at position #{i}: expected #{expected[i]}, found #{actual[i]}"
        end
      end
    end
  end
end
