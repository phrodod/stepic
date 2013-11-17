#!/usr/bin/env ruby

require_relative 'dna'

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
  if input.length == 1
    input = input[0].split
  end
  input = input.collect do |line|
    line.strip
  end
  input = input.select do |line|
    line != ""
  end
  if output.length == 1
    output = output[0].strip
  end
  [input, output]
end

def check_output_vs_expected output, matches
  if output.length != matches.length
    puts "Results don't match expected size"
    puts "Size(expected) = #{output.length}"
    puts "Size(actual) = #{matches.length}"
  else
    (0...output.length).each do |i|
      if output[i] != matches[i]
        puts "Mismatch at position #{i}: expected #{output[i]}, found #{matches[i]}"
      end
    end
  end
end

content = <<-eos
Sample Input:
     ATTCTGGA
     CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAAT
     3

Sample Output:
     6 7 26 27
eos

if $0 == __FILE__ 

  if ARGV.length > 0
    content = File.open(ARGV[0], 'r').read
  end
  input, output = split_content content
  if input.length != 3
    puts "Invalid input: length should be 3"
  end

  pattern = input[0]
  genome = input[1]
  num_mismatches_allowed = input[2].to_i

  dna = Dna.new(genome)
  matches = dna.find_approximate_pattern pattern, num_mismatches_allowed
  matches = matches.join(' ')

  if output.length > 0
    check_output_vs_expected output, matches
  else
    puts matches
  end
end
