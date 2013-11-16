#!/usr/bin/env ruby

require_relative 'dna'

if $0 == __FILE__
   data = []
   if ARGV.length > 0
      data << ARGV[0..ARGV.length].join('')
   else
      data = ['CATGGGCATCGGCCATACGCC']
   end
   genome = data[0]

   dna = Dna.new genome
   skews = dna.skew
   puts skews.join(" ")
end
