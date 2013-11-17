#!/usr/bin/env ruby

require_relative 'dna'
require_relative 'stepic'

content = <<-END_SAMPLE
Sample Input:
    CGGACTCGACAGATGTGAAGAACGACAATGTGAAGACTCGACACGACAGAGTGAAGAGAAGAGGAAACATTGTAA
    5 50 4
Sample Output:
    CGACA GAAGA
END_SAMPLE

if ARGV.length > 0
  content = File.open(ARGV[0], 'r').read
end

stepic = Stepic.new content

if stepic.input.length != 2
  puts "Invalid input: length should be 2"
  exit
end

genome = stepic.input[0]
bounds = stepic.input[1].split

if bounds.length < 3
  puts "Usage: #{__FILE__} genome_file <kmer length> <target region length> <minimum count>"
  exit
end

int_bounds = bounds.collect do |i|
  i.to_i
end

kmer_length, region_length, minimum_count = int_bounds

puts "Searching genome of size #{genome.length} for kmers of length #{kmer_length} in regions of length #{region_length} occurring at least #{minimum_count} times."

dna = Dna.new genome
matches = dna.find_clumps kmer_length, region_length, minimum_count
matches = matches.join(" ")

stepic.handle_output matches
