#!/usr/bin/env ruby

require_relative 'dna'

if $0 == __FILE__
   if ARGV.length > 0
      data = []
      File.open(ARGV[0], 'r').each do |line|
         data << line.chomp
      end
      if ARGV.length > 1
         data << ARGV[1]
      end
   else
      data = ['ACGTTGCATGTCGCATGATGCATGAGAGCT', '4']
   end
   target, size = data
   size = size.to_i

   dna = Dna.new(target)
   kmers = dna.find_frequent_kmers(size)
   puts kmers.join(" ")
end
