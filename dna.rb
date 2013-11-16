class Dna
  def initialize genome=""
    @genome = genome
  end

  def find_kmer_counts size
    kmer_counts = Hash.new 0
    (0..(@genome.length-size)).each do |i|
      key = @genome[i, size]
      kmer_counts[key] += 1
    end
    kmer_counts
  end

  def find_kmers size
    kmers = {}
    (0..(@genome.length-size)).each do |i|
      keys = kmers.keys
      key = @genome[i, size]
      if keys.include? key
        kmers[key].push i
      else
        kmers[key] = [i]
      end
    end
    kmers
  end

  def find_pattern pattern
    kmers = find_kmers pattern.length
    kmers[pattern]
  end

  def mismatches pattern1, pattern2
    count = 0
    (0...pattern1.length).each do |i|
      count += pattern1[i] == pattern2[i] ? 0 : 1
    end
    count
  end

  def find_approximate_pattern pattern, max_mismatches
    result = []
    (0..(@genome.length-pattern.length)).each do |i|
      chunk = @genome[i, pattern.length]
      if mismatches(chunk, pattern) <= max_mismatches
        result << i
      end
    end
    result
  end

  def find_clumps kmer_length, region_length, minimum_count
    full_genome = @genome
    @genome = full_genome[0, region_length]
    kmer_counts = find_kmer_counts kmer_length
    clumps = []
    kmer_counts.each do |key, value|
      if value >= minimum_count and not clumps.include? key
        clumps << key
      end
    end
    ((region_length - kmer_length - 1)..(full_genome.length - kmer_length - 1)).each do |i|
      added = full_genome[i, kmer_length]
      deleted = full_genome[i - region_length + 1, kmer_length]
      kmer_counts[added] += 1
      kmer_counts[deleted] -= 1
      if kmer_counts[added] >= minimum_count and not clumps.include? added
        clumps << added
      end
    end
    clumps
  end

  def find_frequent_kmers size
     max = 0
     kmers = find_kmers size
     kmers.each { |key, value| max = value.length if value.length > max }
     kmers.keep_if { |key, value| value.length == max }
     kmers.keys
  end

  def skew
     total_skew = 0
     skews = (0...@genome.length).collect do |i|
        if @genome[i] == 'C'
           total_skew -= 1
        elsif @genome[i] == 'G'
           total_skew += 1
        end
        total_skew
     end
     skews.unshift 0
     skews
  end

  def find_minima series
     minima = []
     minimum = series[0]
     (0...series.length).each do |i|
        if series[i] < minimum
           minimum = series[i]
           minima = [i]
        elsif series[i] == minimum
           minima << i
        end
     end
     minima
  end
end
