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

if ARGV.length > 0
  content = File.open(ARGV[0], 'r').read
end

stepic = Stepic.new content

if stepic.input.length != 3
  puts "Invalid input: length should be 3"
end

pattern                = stepic.input[0]
genome                 = stepic.input[1]
num_mismatches_allowed = stepic.input[2].to_i

dna = Dna.new(genome)
matches = dna.find_approximate_pattern pattern, num_mismatches_allowed
matches = matches.join(' ')

stepic.handle_output matches
