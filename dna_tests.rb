require 'test/unit'
require_relative 'dna'

class TestMinimizeSkews < Test::Unit::TestCase
  def test_minima
    genome = 'TAAAGACTGCCGAGAGGCCAACACGAGTGCTAGAACGAGGGGCGTAAACGCGGGTCCGAT'
    dna = Dna.new genome
    skews = [0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, -1, 0, 0, 1, 1, 2, 3, 2, 1, 1, 1, 0, 
      0, -1, 0, 0, 1, 1, 2, 1, 1, 1, 2, 2, 2, 1, 2, 2, 3, 4, 5, 6, 5, 6, 6, 6, 6, 
      6, 5, 6, 5, 6, 7, 8, 8, 7, 6, 7, 7, 7]
    minima = dna.find_minima skews
    answer = minima.join(' ')
    assert_equal("11 24", answer)
  end

  def test_skew
    genome = 'TAAAGACTGCCGAGAGGCCAACACGAGTGCTAGAACGAGGGGCGTAAACGCGGGTCCGAT'
    dna = Dna.new genome
    skews = dna.skew
    answer = skews.join(' ')
    assert_equal("0 0 0 0 0 1 1 0 0 1 0 -1 0 0 1 1 2 3 2 1 1 1 0 0 -1 0 0" +
                 " 1 1 2 1 1 1 2 2 2 1 2 2 3 4 5 6 5 6 6 6 6 6 5 6 5 6 7 " +
                 "8 8 7 6 7 7 7", answer)
  end

  def test_find_pattern
    genome = 'GATATATGCATATACTT'
    pattern = 'ATAT'
    dna = Dna.new(genome)
    matches = dna.find_pattern(pattern)
    answer = matches.join(' ')
    assert_equal("1 3 9", answer)
  end

  def test_find_clumps
    genome = 'CGGACTCGACAGATGTGAAGAACGACAATGTGAAGACTCGACACGACAGAGTGAAGAGAAGAGGAAACATTGTAA'
    kmer_length = 5
    region_length = 50 
    minimum_count = 4
    dna = Dna.new genome
    matches = dna.find_clumps kmer_length, region_length, minimum_count
    answer = matches.join(" ")
    assert_equal("CGACA GAAGA", answer)
  end

  def test_frequent_words
    genome = 'ACGTTGCATGTCGCATGATGCATGAGAGCT'
    size = 4 
    dna = Dna.new(genome)
    kmers = dna.find_frequent_kmers(size)
    answer = kmers.join(" ")
    assert_equal("GCAT CATG", answer)
  end

  def test_approximate_pattern_matching
    pattern = "ATTCTGGA"
    genome = "CGCCCGAATCCAGAACGCATTCCCATATTTCGGGACCACTGGCCTCCACGGTACGGACGTCAATCAAAT"
    max_mismatches = 3
    dna = Dna.new(genome)
    match_positions = dna.find_approximate_pattern(pattern, max_mismatches)
    answer = match_positions.join(" ")
    assert_equal "6 7 26 27", answer
  end
end
