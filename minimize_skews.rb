#!/usr/bin/env ruby

require_relative 'dna'

if $0 == __FILE__
   data = []
   if ARGV.length > 0
      data = []
      File.open(ARGV[0], 'r').each do |line|
         data << line.chomp
      end
      if ARGV.length > 1
         data << ARGV[1..ARGV.length].join(' ')
      end
   else
      data = ['TAAAGACTGCCGAGAGGCCAACACGAGTGCTAGAACGAGGGGCGTAAACGCGGGTCCGAT']
   end
   genome = data[0]

   dna = Dna.new genome
   skews = dna.skew
   minima = dna.find_minima skews
   puts minima.join(" ")
end
