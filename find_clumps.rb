#!/usr/bin/env ruby

require_relative 'dna'

if $0 == __FILE__
   if ARGV.length > 0
      data = []
      File.open(ARGV[0], 'r').each do |line|
         data << line.chomp
      end
      if ARGV.length > 1
         data << ARGV[1..ARGV.length].join(' ')
      end
   else
      data = ['CGGACTCGACAGATGTGAAGAACGACAATGTGAAGACTCGACACGACAGAGTGAAGAGAAGAGGAAACATTGTAA', '5 50 4']
   end
   genome, bounds = data
   bounds = bounds.split
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
   puts matches.join(" ")
end
