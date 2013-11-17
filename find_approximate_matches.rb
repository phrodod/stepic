#!/usr/bin/env ruby

require_relative 'dna'
require_relative 'stepic'

content = <<-END_SAMPLE
Sample Input:
     ATTCTGGA
     CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAAT
     3

Sample Output:
     6 7 26 27
END_SAMPLE

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
