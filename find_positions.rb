#!/usr/bin/env ruby

require_relative 'dna'

if $0 == __FILE__
   if ARGV.length > 0
      data = []
      if ARGV.length > 1
         data << ARGV[1]
      end
      File.open(ARGV[0], 'r').each do |line|
         data << line.chomp
      end
   else
      data = ['ATAT', 'GATATATGCATATACTT']
   end
   pattern, target = data

   dna = Dna.new(target)
   matches = dna.find_pattern(pattern)
   puts matches.join(" ")
end
